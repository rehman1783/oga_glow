import 'package:get/get.dart';

class CategoryController extends GetxController {
  final categories = ['All', 'Skin Care', 'Hair Care', 'Body Care', 'Kits'].obs;

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

  @override
  void onInit() {
    super.onInit();
    // Note: controller can be reused because of Get.lazyPut.
    // Don’t rely on onInit() alone for deep-link arguments.
    _setSelectedFromArguments();
  }

  @override
  void onReady() {
    super.onReady();
    // Ensure arguments are applied after the route is mounted.
    _setSelectedFromArguments();
  }

  void _setSelectedFromArguments() {
    final raw = Get.arguments?.toString();
    if (raw == null || raw.trim().isEmpty) return;

    final normalized = raw.trim();

    // Keep controller categories consistent.
    if (categories.contains(normalized)) {
      selectedCategory.value = normalized;
    } else {
      selectedCategory.value = 'All';
    }
  }

  void changeCategory(String category) {
    selectedCategory.value = category.trim();
  }

  List<Map<String, dynamic>> get filteredProducts {
    if (selectedCategory.value == 'All') {
      return allProducts;
    }

    return allProducts
        .where((product) => product['category'] == selectedCategory.value)
        .toList();
  }
}
