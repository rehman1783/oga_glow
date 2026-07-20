import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  final categories = [
    'All',
    'Skin Care',
    'Hair Care',
    'Body Care',
    'Kits',
  ].obs;

  final selectedCategory = 'All'.obs;

  final searchController = TextEditingController();

  final searchText = ''.obs;

  final searchSuggestions = <Map<String, dynamic>>[].obs;

  final allProducts = [
    {
      "name": "Glow Face Wash",
      "category": "Skin Care",
      "price": "1500",
      "image": "assets/images/banner1.jpeg",
    },
    {
      "name": "Hair Growth Serum",
      "category": "Hair Care",
      "price": "2200",
      "image": "assets/images/banner2.jpeg",
    },
    {
      "name": "Body Lotion",
      "category": "Body Care",
      "price": "1800",
      "image": "assets/images/banner3.jpeg",
    },
    {
      "name": "Glow Kit",
      "category": "Kits",
      "price": "3500",
      "image": "assets/images/banner1.jpeg",
    },
  ];

  void openCategory(String category) {
    selectedCategory.value =
        categories.contains(category) ? category : 'All';
  }

  void changeCategory(String category) {
    selectedCategory.value = category.trim();
  }

  /// Search
  void onSearchChanged(String value) {
  searchText.value = value;

  if (value.trim().isEmpty) {
    searchSuggestions.clear();
    return;
  }

  final query = value.toLowerCase().trim();

  searchSuggestions.value = allProducts.where((product) {
    final name = product["name"].toString().toLowerCase();
    final category = product["category"].toString().toLowerCase();

    return name.contains(query) || category.contains(query);
  }).toList();
}

  /// Suggestion click
  void selectSuggestion(Map<String, dynamic> product) {
    searchController.text = product["name"];

    searchText.value = product["name"];

    searchSuggestions.clear();
  }

 List<Map<String, dynamic>> get filteredProducts {
  List<Map<String, dynamic>> products = allProducts;

  // Category Chip Filter
  if (selectedCategory.value != "All") {
    products = products.where((product) {
      return product["category"] == selectedCategory.value;
    }).toList();
  }

  // Search Filter
  if (searchText.value.isNotEmpty) {
    final query = searchText.value.toLowerCase().trim();

    products = products.where((product) {
      final name = product["name"].toString().toLowerCase();
      final category = product["category"].toString().toLowerCase();

      return name.contains(query) || category.contains(query);
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