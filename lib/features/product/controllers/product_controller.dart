import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:oga_glow/data/models/product_model.dart';
import 'package:oga_glow/data/repositories/product_repository.dart';
import 'package:oga_glow/features/product/controllers/product_reviews_controller.dart';

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
  late final ProductReviewsController reviewsController;

  String? productId;
  Timer? _autoPlayTimer;
  int _autoImageIndex = 0;

  @override
  void onInit() {
    super.onInit();
    reviewsController = Get.find<ProductReviewsController>();
    _extractProductId();
    if (productId != null && productId!.isNotEmpty) {
      final hasInitialData = productModel.value != null;
      fetchProductDetails(productId!, background: hasInitialData);
    } else {
      isLoading.value = false;
      hasError.value = true;
      errorMessage.value = 'Product ID not provided.';
    }
  }

  void _extractProductId() {
    final args = Get.arguments;
    if (args is ProductModel) {
      productId = args.id;
      _applyProductData(args);
    } else if (args is Map && args.containsKey('productModel') && args['productModel'] is ProductModel) {
      final model = args['productModel'] as ProductModel;
      productId = model.id;
      _applyProductData(model);
    } else if (args is String) {
      productId = args;
    } else if (args is Map && args.containsKey('id')) {
      productId = args['id']?.toString();
    }

    // Check if product is available in in-memory repository cache for 0ms instant display
    if (productModel.value == null && productId != null && productId!.isNotEmpty) {
      final cached = ProductRepository.findCachedProduct(productId!);
      if (cached != null) {
        _applyProductData(cached);
      }
    }
  }

  void _applyProductData(ProductModel model) {
    productModel.value = model;
    productImages.value = model.images
        .map((img) => img.url)
        .where((url) => url.isNotEmpty)
        .toList();
    isLoading.value = false;
    _startAutoPlay();
    _fetchRelatedProducts(model);
  }

  /// Ensures fresh product details are fetched via Single Product API when navigating
  Future<void> loadProductById(String id) async {
    productId = id;
    final cached = ProductRepository.findCachedProduct(id);
    if (cached != null) {
      _applyProductData(cached);
      await fetchProductDetails(id, background: true);
    } else {
      await fetchProductDetails(id, background: false);
    }
  }

  Future<void> fetchProductDetails(String id, {bool background = false}) async {
    try {
      if (!background) {
        isLoading.value = true;
      }
      hasError.value = false;
      errorMessage.value = '';

      // Concurrently load reviews without blocking product details UI
      reviewsController.setProductId(id);
      unawaited(reviewsController.loadReviews(id));

      final details = await _productRepository.getProductById(id);
      _applyProductData(details);
    } catch (e) {
      if (productModel.value == null) {
        hasError.value = true;
        errorMessage.value = e.toString().replaceAll('Exception: ', '');
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _fetchRelatedProducts(ProductModel current) async {
    try {
      final all = await _productRepository.getProducts();
      relatedProducts.value = all
          .where(
            (p) =>
                p.id != current.id &&
                (p.category == current.category ||
                    p.categoryDisplayName == current.categoryDisplayName),
          )
          .take(6)
          .toList();

      // Fallback if no matching category products
      if (relatedProducts.isEmpty) {
        relatedProducts.value = all
            .where((p) => p.id != current.id)
            .take(6)
            .toList();
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
