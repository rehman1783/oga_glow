import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final currentBanner = 0.obs;

  final banners = [
    'assets/images/banner1.jpeg',
    'assets/images/banner2.jpeg',
    'assets/images/banner3.jpeg',
  ];

  final categories = [
  {
    "name": "Skin Care",
    "icon": Icons.spa_outlined,
  },
  {
    "name": "Hair Care",
    "icon": Icons.cut_outlined,
  },
  {
    "name": "Body Care",
    "icon": Icons.self_improvement_outlined,
  },
  {
    "name": "Kits",
    "icon": Icons.inventory_2_outlined,
  },
];
final featuredProducts = [
  {
    "name": "Vitamin C Serum",
    "price": "1500",
    "image": "assets/images/banner1.jpeg",
  },
  {
    "name": "Hair Growth Serum",
    "price": "2200",
    "image": "assets/images/banner2.jpeg",
  },
];
final bestSellers = [
  {
    "name": "Best Seller 1",
    "price": "1800",
    "image": "assets/images/banner1.jpeg",
  },
  {
    "name": "Best Seller 2",
    "price": "2500",
    "image": "assets/images/banner2.jpeg",
  },
  {
    "name": "Best Seller 3",
    "price": "3200",
    "image": "assets/images/banner3.jpeg",
  },
];
final newArrivals = [
  {
    "name": "Glow Face Wash",
    "price": "1700",
    "image": "assets/images/banner1.jpeg",
  },
  {
    "name": "Hair Repair Shampoo",
    "price": "2400",
    "image": "assets/images/banner2.jpeg",
  },
  {
    "name": "Body Care Kit",
    "price": "2900",
    "image": "assets/images/banner3.jpeg",
  },
];
  void updateBanner(int index) {
    currentBanner.value = index;
  }
}
