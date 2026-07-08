import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  final categories = [
    {
      "name": "Skin Care",
      "icon": Icons.spa,
    },
    {
      "name": "Hair Care",
      "icon": Icons.content_cut,
    },
    {
      "name": "Body Care",
      "icon": Icons.favorite_outline,
    },
    {
      "name": "Kits",
      "icon": Icons.inventory_2_outlined,
    },
  ];
}