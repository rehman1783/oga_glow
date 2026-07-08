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

  void changeCategory(String category) {
    selectedCategory.value = category;
  }

  List<Map<String, dynamic>> get filteredProducts {
    if (selectedCategory.value == 'All') {
      return allProducts;
    }

    return allProducts.where(
      (product) =>
          product['category'] == selectedCategory.value,
    ).toList();
  }
}