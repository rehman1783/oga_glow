import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oga_glow/core/network/api_exception.dart';
import 'package:oga_glow/core/widgets/custom_snackbar.dart';
import 'package:oga_glow/data/repositories/wishlist_repository.dart';
import 'package:oga_glow/features/auth/controllers/auth_controller.dart';

import '../../cart/widgets/add_to_cart_bottom_sheet.dart';

class WishlistController extends GetxController {
  static const String tag = 'wishlist';

  final WishlistRepository _wishlistRepository;

  WishlistController({WishlistRepository? wishlistRepository})
      : _wishlistRepository = wishlistRepository ?? WishlistRepository();

  /// Wishlist items stored dynamically from API product data.
  final RxList<Map<String, dynamic>> wishlistItems = <Map<String, dynamic>>[].obs;

  /// Set of product IDs currently in wishlist for fast O(1) checking.
  final RxSet<String> wishlistedProductIds = <String>{}.obs;

  /// Loading state when fetching wishlist from server.
  final RxBool isLoading = false.obs;

  /// Processing state for toggle operations.
  final RxBool isOperating = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchWishlist();

    // Listen to AuthController state changes if available
    if (Get.isRegistered<AuthController>()) {
      final authController = Get.find<AuthController>();
      ever(authController.isLoggedIn, (bool loggedIn) {
        if (loggedIn) {
          fetchWishlist(forceRefresh: true);
        } else {
          wishlistItems.clear();
          wishlistedProductIds.clear();
        }
      });
    }
  }

  /// Fetches wishlist from server API.
  Future<void> fetchWishlist({bool forceRefresh = false}) async {
    final authController = Get.isRegistered<AuthController>()
        ? Get.find<AuthController>()
        : null;

    if (authController != null && !authController.isLoggedIn.value) {
      wishlistItems.clear();
      wishlistedProductIds.clear();
      return;
    }

    isLoading.value = true;
    try {
      final items = await _wishlistRepository.getWishlist(forceRefresh: forceRefresh);
      wishlistItems.assignAll(items);

      final ids = items
          .map((e) => e['id']?.toString() ?? e['_id']?.toString() ?? '')
          .where((id) => id.isNotEmpty)
          .toSet();
      wishlistedProductIds.assignAll(ids);
    } on ApiException catch (e) {
      debugPrint('[WishlistController] Error fetching wishlist: ${e.message}');
    } catch (e) {
      debugPrint('[WishlistController] Unexpected error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  bool _isSameProduct(Map<String, dynamic> a, Map<String, dynamic> b) {
    final aId = a['id']?.toString() ?? a['_id']?.toString() ?? '';
    final bId = b['id']?.toString() ?? b['_id']?.toString() ?? '';
    if (aId.isNotEmpty && bId.isNotEmpty) {
      return aId == bId;
    }
    return a['name'] == b['name'] &&
        a['image'] == b['image'] &&
        a['price'] == b['price'];
  }

  /// Checks if a product is in the wishlist.
  bool isInWishlist(Map<String, dynamic> product) {
    final String id = product['id']?.toString() ?? product['_id']?.toString() ?? '';
    if (id.isNotEmpty) {
      return wishlistedProductIds.contains(id);
    }
    for (final item in wishlistItems) {
      if (_isSameProduct(item, product)) return true;
    }
    return false;
  }

  /// Toggles wishlist item via API POST /customers/me/wishlist/toggle.
  Future<void> toggleWishlistItem(Map<String, dynamic> product) async {
    final authController = Get.isRegistered<AuthController>()
        ? Get.find<AuthController>()
        : null;

    if (authController != null && !authController.isLoggedIn.value) {
      CustomSnackbar.showInfo(
        title: 'Login Required',
        message: 'Please login to save products to your wishlist.',
      );
      return;
    }

    final normalized = <String, dynamic>{...product};
    final String productId = normalized['id']?.toString() ?? normalized['_id']?.toString() ?? '';

    if (productId.isEmpty) {
      _fallbackToggleLocal(normalized);
      return;
    }

    isOperating.value = true;
    try {
      final res = await _wishlistRepository.toggleWishlist(productId);
      final bool isWishlisted = res['isWishlisted'] == true;
      final String message = res['message']?.toString() ?? (isWishlisted ? 'Product added to wishlist' : 'Product removed from wishlist');

      if (isWishlisted) {
        wishlistedProductIds.add(productId);
        if (!isInWishlistInList(productId)) {
          wishlistItems.add(normalized);
        }
        CustomSnackbar.showSuccess(
          title: 'Wishlist',
          message: message,
        );
      } else {
        wishlistedProductIds.remove(productId);
        wishlistItems.removeWhere((item) => (item['id']?.toString() ?? item['_id']?.toString()) == productId);
        CustomSnackbar.showInfo(
          title: 'Wishlist',
          message: message,
        );
      }

      // Sync fresh list from API in background
      fetchWishlist(forceRefresh: true);
    } on ApiException catch (e) {
      CustomSnackbar.showError(
        title: 'Wishlist Error',
        message: e.message,
      );
    } catch (e) {
      CustomSnackbar.showError(
        title: 'Error',
        message: 'Could not update wishlist.',
      );
    } finally {
      isOperating.value = false;
    }
  }

  bool isInWishlistInList(String productId) {
    return wishlistItems.any((item) => (item['id']?.toString() ?? item['_id']?.toString()) == productId);
  }

  void _fallbackToggleLocal(Map<String, dynamic> normalized) {
    final index = wishlistItems.indexWhere(
      (item) => _isSameProduct(item, normalized),
    );

    if (index != -1) {
      wishlistItems.removeAt(index);
      CustomSnackbar.showInfo(
        title: 'Wishlist',
        message: 'Item removed from wishlist',
      );
    } else {
      wishlistItems.add(normalized);
      CustomSnackbar.showSuccess(
        title: 'Wishlist',
        message: 'Saved to wishlist',
      );
    }
  }

  /// Adds a product to wishlist.
  Future<void> addToWishlist(Map<String, dynamic> product) async {
    if (isInWishlist(product)) {
      CustomSnackbar.showInfo(
        title: 'Wishlist',
        message: 'Already saved to wishlist',
      );
      return;
    }
    await toggleWishlistItem(product);
  }

  /// Removes an item by index.
  Future<void> removeItem(int index) async {
    if (index >= 0 && index < wishlistItems.length) {
      final product = wishlistItems[index];
      await removeFromWishlist(product);
    }
  }

  /// Removes a product from wishlist via DELETE /customers/me/wishlist/item/:productId or toggle.
  Future<void> removeFromWishlist(Map<String, dynamic> product) async {
    final normalized = <String, dynamic>{...product};
    final String productId = normalized['id']?.toString() ?? normalized['_id']?.toString() ?? '';

    if (productId.isEmpty) {
      wishlistItems.removeWhere((item) => _isSameProduct(item, normalized));
      return;
    }

    final authController = Get.isRegistered<AuthController>()
        ? Get.find<AuthController>()
        : null;

    if (authController == null || !authController.isLoggedIn.value) {
      wishlistItems.removeWhere((item) => (item['id']?.toString() ?? item['_id']?.toString()) == productId);
      wishlistedProductIds.remove(productId);
      return;
    }

    isOperating.value = true;
    try {
      final success = await _wishlistRepository.removeWishlistItem(productId);
      if (success) {
        wishlistItems.removeWhere((item) => (item['id']?.toString() ?? item['_id']?.toString()) == productId);
        wishlistedProductIds.remove(productId);
        CustomSnackbar.showInfo(
          title: 'Wishlist',
          message: 'Product removed from wishlist',
        );
      } else {
        await toggleWishlistItem(product);
      }
    } on ApiException catch (e) {
      CustomSnackbar.showError(
        title: 'Wishlist Error',
        message: e.message,
      );
    } catch (e) {
      CustomSnackbar.showError(
        title: 'Error',
        message: 'Could not remove item from wishlist.',
      );
    } finally {
      isOperating.value = false;
    }
  }

  /// Clears all wishlist items via DELETE /customers/me/wishlist/clear.
  Future<void> clearWishlist() async {
    final authController = Get.isRegistered<AuthController>()
        ? Get.find<AuthController>()
        : null;

    if (authController != null && authController.isLoggedIn.value) {
      isOperating.value = true;
      try {
        await _wishlistRepository.clearWishlist();
        CustomSnackbar.showSuccess(
          title: 'Wishlist Cleared',
          message: 'Wishlist cleared successfully',
        );
      } on ApiException catch (e) {
        CustomSnackbar.showError(
          title: 'Wishlist Error',
          message: e.message,
        );
      } catch (e) {
        CustomSnackbar.showError(
          title: 'Error',
          message: 'Could not clear wishlist.',
        );
      } finally {
        isOperating.value = false;
      }
    }

    wishlistItems.clear();
    wishlistedProductIds.clear();
  }

  /// Used by wishlist UI flow. Opens the quantity selector bottom sheet.
  void addToCartDynamic(BuildContext context, Map<String, dynamic> product) {
    final normalized = <String, dynamic>{...product};
    AddToCartBottomSheet.show(context, normalized);
  }

  /// Alias to keep older code compiling.
  void addToCartLegacy(BuildContext context, Map<String, dynamic> product) {
    addToCartDynamic(context, product);
  }
}
