class ProductImageModel {
  final String id;
  final String publicId;
  final String url;

  ProductImageModel({
    required this.id,
    required this.publicId,
    required this.url,
  });

  factory ProductImageModel.fromJson(Map<String, dynamic> json) {
    return ProductImageModel(
      id: json['id']?.toString() ?? json['_id']?.toString() ?? '',
      publicId: json['public_id']?.toString() ?? '',
      url: json['url']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'public_id': publicId,
      'url': url,
    };
  }
}

class DiscountModel {
  final String type;
  final num value;
  final bool isActive;
  final String? startDate;

  DiscountModel({
    required this.type,
    required this.value,
    required this.isActive,
    this.startDate,
  });

  factory DiscountModel.fromJson(Map<String, dynamic> json) {
    return DiscountModel(
      type: json['type']?.toString() ?? 'percentage',
      value: json['value'] is num ? json['value'] as num : num.tryParse(json['value']?.toString() ?? '0') ?? 0,
      isActive: json['isActive'] == true,
      startDate: json['startDate']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'value': value,
      'isActive': isActive,
      'startDate': startDate,
    };
  }
}

class ProductModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final double finalPrice;
  final double shippingPrice;
  final double taxRate;
  final String howToUse;
  final String ingredients;
  final String benefits;
  final List<ProductImageModel> images;
  final String category;
  final int countInStock;
  final double averageRating;
  final int totalReviews;
  final DiscountModel? discount;
  final String? createdAt;
  final String? updatedAt;

  ProductModel({
    required this.id,
    required this.name,
    this.description = '',
    required this.price,
    required this.finalPrice,
    this.shippingPrice = 0.0,
    this.taxRate = 0.0,
    this.howToUse = '',
    this.ingredients = '',
    this.benefits = '',
    required this.images,
    required this.category,
    this.countInStock = 0,
    this.averageRating = 0.0,
    this.totalReviews = 0,
    this.discount,
    this.createdAt,
    this.updatedAt,
  });

  bool get hasDiscount => discount?.isActive == true;

  double get discountAmount {
    if (!hasDiscount) return 0.0;
    return price - finalPrice > 0 ? price - finalPrice : 0.0;
  }

  int get discountPercentage {
    if (!hasDiscount) return 0;
    if (discount?.value != null && discount!.value > 0) {
      return discount!.value.toInt();
    }
    if (price > 0 && finalPrice < price) {
      return (((price - finalPrice) / price) * 100).round();
    }
    return 0;
  }

  String get mainImageUrl {
    if (images.isNotEmpty && images.first.url.isNotEmpty) {
      return images.first.url;
    }
    return '';
  }

  /// Formatted category display name (e.g. skin-care -> Skin Care)
  String get categoryDisplayName {
    if (category.isEmpty) return 'General';
    return category
        .split(RegExp(r'[-_]'))
        .map((word) => word.isNotEmpty
            ? '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}'
            : '')
        .join(' ');
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    var rawImages = json['images'];
    List<ProductImageModel> imageList = [];
    if (rawImages is List) {
      imageList = rawImages
          .map((imgJson) => ProductImageModel.fromJson(
                imgJson is Map<String, dynamic> ? imgJson : {'url': imgJson.toString()},
              ))
          .toList();
    }

    double parseDouble(dynamic val) {
      if (val == null) return 0.0;
      if (val is num) return val.toDouble();
      return double.tryParse(val.toString()) ?? 0.0;
    }

    int parseInt(dynamic val) {
      if (val == null) return 0;
      if (val is int) return val;
      if (val is num) return val.toInt();
      return int.tryParse(val.toString()) ?? 0;
    }

    final originalPrice = parseDouble(json['price']);
    final parsedFinalPrice = parseDouble(json['finalPrice']);

    return ProductModel(
      id: json['id']?.toString() ?? json['_id']?.toString() ?? '',
      name: json['name']?.toString() ?? 'Unnamed Product',
      description: json['description']?.toString() ?? '',
      price: originalPrice,
      finalPrice: parsedFinalPrice > 0 ? parsedFinalPrice : originalPrice,
      shippingPrice: parseDouble(json['shippingPrice']),
      taxRate: parseDouble(json['taxRate']),
      howToUse: json['howToUse']?.toString() ?? '',
      ingredients: json['ingredients']?.toString() ?? '',
      benefits: json['benefits']?.toString() ?? '',
      images: imageList,
      category: json['category']?.toString() ?? 'general',
      countInStock: parseInt(json['countInStock']),
      averageRating: parseDouble(json['averageRating']),
      totalReviews: parseInt(json['totalReviews']),
      discount: json['discount'] is Map<String, dynamic>
          ? DiscountModel.fromJson(json['discount'] as Map<String, dynamic>)
          : null,
      createdAt: json['createdAt']?.toString(),
      updatedAt: json['updatedAt']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'finalPrice': finalPrice,
      'shippingPrice': shippingPrice,
      'taxRate': taxRate,
      'howToUse': howToUse,
      'ingredients': ingredients,
      'benefits': benefits,
      'images': images.map((img) => img.toJson()).toList(),
      'category': category,
      'countInStock': countInStock,
      'averageRating': averageRating,
      'totalReviews': totalReviews,
      'discount': discount?.toJson(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
