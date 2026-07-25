import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oga_glow/data/models/product_model.dart';
import 'package:oga_glow/data/repositories/product_repository.dart';

class CategoryController extends GetxController {
  final ProductRepository _productRepository;

  CategoryController({ProductRepository? productRepository})
      : _productRepository = productRepository ?? ProductRepository();

  static const List<String> defaultCategories = [
    'All',
    'Skin Care',
    'Hair Care',
    'Body Care',
    'Kits',
  ];

  final categories = <String>[...defaultCategories].obs;
  final selectedCategory = 'All'.obs;

  final searchController = TextEditingController();
  final searchText = ''.obs;
  final searchSuggestions = <ProductModel>[].obs;

  final isLoading = true.obs;
  final hasError = false.obs;
  final errorMessage = ''.obs;

  final allProducts = <ProductModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategoryProducts();
  }

  Future<void> fetchCategoryProducts() async {
    try {
      isLoading.value = true;
      hasError.value = false;
      errorMessage.value = '';

      final fetched = await _productRepository.getProducts();
      allProducts.assignAll(fetched);

      _updateDynamicCategories();
    } catch (e) {
      hasError.value = true;
      errorMessage.value = e.toString().replaceAll('Exception: ', '');
    } finally {
      isLoading.value = false;
    }
  }

  void _updateDynamicCategories() {
    final catSet = <String>{...defaultCategories};
    for (final p in allProducts) {
      if (p.categoryDisplayName.isNotEmpty) {
        catSet.add(p.categoryDisplayName);
      }
    }
    categories.assignAll(catSet.toList());
  }

  void openCategory(String category) {
    if (category.trim().isEmpty) {
      selectedCategory.value = 'All';
      return;
    }

    final target = category.trim();

    // Check match by display name or slug
    final matched = categories.firstWhere(
      (c) =>
          c.toLowerCase() == target.toLowerCase() ||
          c.replaceAll(' ', '-').toLowerCase() == target.toLowerCase() ||
          c.replaceAll('-', ' ').toLowerCase() == target.toLowerCase(),
      orElse: () {
        // If not in categories, format title case and add if valid
        final formatted = target
            .split(RegExp(r'[-_ ]'))
            .map((w) => w.isNotEmpty ? '${w[0].toUpperCase()}${w.substring(1).toLowerCase()}' : '')
            .join(' ');
        if (formatted.isNotEmpty && !categories.contains(formatted)) {
          categories.add(formatted);
          return formatted;
        }
        return 'All';
      },
    );
    selectedCategory.value = matched;
  }

  void changeCategory(String category) {
    selectedCategory.value = category.trim();
  }

  /// Live Search
  void onSearchChanged(String value) {
    searchText.value = value;

    if (value.trim().isEmpty) {
      searchSuggestions.clear();
      return;
    }

    final query = value.toLowerCase().trim();

    searchSuggestions.value = allProducts.where((product) {
      final name = product.name.toLowerCase();
      final catRaw = product.category.toLowerCase();
      final catDisplay = product.categoryDisplayName.toLowerCase();
      final desc = product.description.toLowerCase();
      final ingredients = product.ingredients.toLowerCase();
      final benefits = product.benefits.toLowerCase();

      return name.contains(query) ||
          catRaw.contains(query) ||
          catDisplay.contains(query) ||
          desc.contains(query) ||
          ingredients.contains(query) ||
          benefits.contains(query);
    }).toList();
  }

  /// Suggestion click
  void selectSuggestion(ProductModel product) {
    searchController.text = product.name;
    searchText.value = product.name;
    searchSuggestions.clear();
  }

  List<ProductModel> get filteredProducts {
    List<ProductModel> products = allProducts;

    // Category Chip Filter
    if (selectedCategory.value != "All") {
      final selLower = selectedCategory.value.toLowerCase().replaceAll('-', ' ');
      products = products.where((product) {
        final catDispLower = product.categoryDisplayName.toLowerCase().replaceAll('-', ' ');
        final catRawLower = product.category.toLowerCase().replaceAll('-', ' ');
        return catDispLower == selLower || catRawLower == selLower;
      }).toList();
    }

    // Search Filter
    if (searchText.value.isNotEmpty) {
      final query = searchText.value.toLowerCase().trim();

      products = products.where((product) {
        final name = product.name.toLowerCase();
        final catRaw = product.category.toLowerCase();
        final catDisplay = product.categoryDisplayName.toLowerCase();
        final desc = product.description.toLowerCase();

        return name.contains(query) ||
            catRaw.contains(query) ||
            catDisplay.contains(query) ||
            desc.contains(query);
      }).toList();
    }

    return products;
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}