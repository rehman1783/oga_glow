import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oga_glow/data/models/product_model.dart';
import 'package:oga_glow/data/repositories/product_repository.dart';

class HomeController extends GetxController {
  final ProductRepository _productRepository;

  HomeController({ProductRepository? productRepository})
      : _productRepository = productRepository ?? ProductRepository();

  final currentBanner = 0.obs;

  final banners = [
    'assets/images/banner1.jpeg',
    'assets/images/banner2.jpeg',
    'assets/images/banner3.jpeg',
  ];

  final categories = [
    {
      "name": "Skin Care",
      "categoryKey": "skin-care",
      "icon": Icons.spa_outlined,
    },
    {
      "name": "Hair Care",
      "categoryKey": "hair-care",
      "icon": Icons.cut_outlined,
    },
    {
      "name": "Body Care",
      "categoryKey": "body-care",
      "icon": Icons.self_improvement_outlined,
    },
    {
      "name": "Kits",
      "categoryKey": "kits",
      "icon": Icons.inventory_2_outlined,
    },
  ];

  final isLoading = true.obs;
  final hasError = false.obs;
  final errorMessage = ''.obs;

  final allProducts = <ProductModel>[].obs;

  List<ProductModel> get featuredProducts => allProducts;
  List<ProductModel> get bestSellers => allProducts.take(4).toList();
  List<ProductModel> get newArrivals => allProducts.reversed.toList();
  List<ProductModel> get hotDeals =>
      allProducts.where((p) => p.hasDiscount).toList();

  @override
  void onInit() {
    super.onInit();
    fetchHomeProducts();
  }

  Future<void> fetchHomeProducts() async {
    try {
      isLoading.value = true;
      hasError.value = false;
      errorMessage.value = '';

      final fetched = await _productRepository.getProducts();
      allProducts.assignAll(fetched);
    } catch (e) {
      hasError.value = true;
      errorMessage.value = e.toString().replaceAll('Exception: ', '');
    } finally {
      isLoading.value = false;
    }
  }

  void updateBanner(int index) {
    currentBanner.value = index;
  }
}
