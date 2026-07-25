import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:oga_glow/data/models/product_model.dart';
import 'package:oga_glow/data/repositories/product_repository.dart';

class ProductController extends GetxController {
  final ProductRepository _productRepository;

  ProductController({ProductRepository? productRepository})
      : _productRepository = productRepository ?? ProductRepository();

  final quantity = 1.obs;
  final currentImageIndex = 0.obs;
  final pageController = PageController(initialPage: 0);

  final isLoading = true.obs;
  final hasError = false.obs;
  final errorMessage = ''.obs;

  final Rx<ProductModel?> productModel = Rx<ProductModel?>(null);
  final productImages = <String>[].obs;
  final relatedProducts = <ProductModel>[].obs;

  String? productId;
  Timer? _autoPlayTimer;
  int _autoImageIndex = 0;

  @override
  void onInit() {
    super.onInit();
    _extractProductId();
    if (productId != null && productId!.isNotEmpty) {
      fetchProductDetails(productId!);
    } else {
      isLoading.value = false;
      hasError.value = true;
      errorMessage.value = 'Product ID not provided.';
    }
  }

  void _extractProductId() {
    final args = Get.arguments;
    if (args is String) {
      productId = args;
    } else if (args is Map && args.containsKey('id')) {
      productId = args['id']?.toString();
    } else if (args is ProductModel) {
      productId = args.id;
    }
  }

  /// Ensures fresh product details are fetched via Single Product API when navigating
  Future<void> loadProductById(String id) async {
    productId = id;
    await fetchProductDetails(id);
  }

  Future<void> fetchProductDetails(String id) async {
    try {
      isLoading.value = true;
      hasError.value = false;
      errorMessage.value = '';
      quantity.value = 1;
      currentImageIndex.value = 0;

      final details = await _productRepository.getProductById(id);
      productModel.value = details;

      // Extract image URLs
      productImages.value = details.images
          .map((img) => img.url)
          .where((url) => url.isNotEmpty)
          .toList();

      // Fetch related products from same category or fallback list
      _fetchRelatedProducts(details);

      _startAutoPlay();
    } catch (e) {
      hasError.value = true;
      errorMessage.value = e.toString().replaceAll('Exception: ', '');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _fetchRelatedProducts(ProductModel current) async {
    try {
      final all = await _productRepository.getProducts();
      relatedProducts.value = all
          .where((p) =>
              p.id != current.id &&
              (p.category == current.category ||
                  p.categoryDisplayName == current.categoryDisplayName))
          .take(6)
          .toList();

      // Fallback if no matching category products
      if (relatedProducts.isEmpty) {
        relatedProducts.value =
            all.where((p) => p.id != current.id).take(6).toList();
      }
    } catch (e) {
      // Ignore error for related products list
    }
  }

  void changeImage(int index) {
    currentImageIndex.value = index;
  }

  void increaseQuantity() {
    quantity.value++;
  }

  void decreaseQuantity() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }

  void _startAutoPlay() {
    _autoPlayTimer?.cancel();
    if (productImages.length <= 1) return;

    _autoImageIndex = currentImageIndex.value;
    _autoPlayTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (productImages.isEmpty) return;
      _autoImageIndex = (_autoImageIndex + 1) % productImages.length;
      currentImageIndex.value = _autoImageIndex;
      if (pageController.hasClients) {
        pageController.animateToPage(
          _autoImageIndex,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void onClose() {
    _autoPlayTimer?.cancel();
    pageController.dispose();
    super.onClose();
  }
}
