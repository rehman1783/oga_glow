import 'package:get/get.dart';

class WishlistController extends GetxController {
  final wishlistItems = [
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
  ].obs;

  void removeItem(int index) {
    wishlistItems.removeAt(index);
  }

  void addToCart(Map<String, dynamic> product) {
    // Cart integration later
  }
}
