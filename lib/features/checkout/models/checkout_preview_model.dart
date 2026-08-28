class CheckoutPreviewResponse {
  final bool success;
  final List<CheckoutItem> items;
  final PriceBreakdown priceBreakdown;
  final dynamic coupon;
  final String? couponError;

  CheckoutPreviewResponse({
    this.success = true,
    required this.items,
    required this.priceBreakdown,
    this.coupon,
    this.couponError,
  });

  factory CheckoutPreviewResponse.fromJson(Map<String, dynamic> json) {
    var rawItems = json['items'];
    List<CheckoutItem> parsedItems = [];
    if (rawItems is List) {
      parsedItems = rawItems
          .map((item) => CheckoutItem.fromJson(item as Map<String, dynamic>))
          .toList();
    }

    final rawPriceBreakdown = json['priceBreakdown'];
    final breakdown = rawPriceBreakdown is Map<String, dynamic>
        ? PriceBreakdown.fromJson(rawPriceBreakdown)
        : PriceBreakdown.empty();

    return CheckoutPreviewResponse(
      success: json['success'] == true || json['success'] == null,
      items: parsedItems,
      priceBreakdown: breakdown,
      coupon: json['coupon'],
      couponError: json['couponError']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'items': items.map((i) => i.toJson()).toList(),
      'priceBreakdown': priceBreakdown.toJson(),
      'coupon': coupon,
      'couponError': couponError,
    };
  }
}

class CheckoutItem {
  final String product;
  final String name;
  final String? image;
  final int quantity;
  final num price;
  final num originalPrice;
  final num shippingPrice;
  final num discountAmount;
  final num subtotal;
  final Map<String, dynamic>? discount;

  CheckoutItem({
    required this.product,
    required this.name,
    this.image,
    required this.quantity,
    required this.price,
    required this.originalPrice,
    required this.shippingPrice,
    required this.discountAmount,
    required this.subtotal,
    this.discount,
  });

  factory CheckoutItem.fromJson(Map<String, dynamic> json) {
    num parseNum(dynamic val) {
      if (val == null) return 0;
      if (val is num) return val;
      return num.tryParse(val.toString()) ?? 0;
    }

    int parseInt(dynamic val) {
      if (val == null) return 0;
      if (val is int) return val;
      if (val is num) return val.toInt();
      return int.tryParse(val.toString()) ?? 0;
    }

    return CheckoutItem(
      product: json['product']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      image: json['image']?.toString(),
      quantity: parseInt(json['quantity']),
      price: parseNum(json['price']),
      originalPrice: parseNum(json['originalPrice']),
      shippingPrice: parseNum(json['shippingPrice']),
      discountAmount: parseNum(json['discountAmount']),
      subtotal: parseNum(json['subtotal']),
      discount: json['discount'] is Map<String, dynamic>
          ? json['discount'] as Map<String, dynamic>
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product': product,
      'name': name,
      'image': image,
      'quantity': quantity,
      'price': price,
      'originalPrice': originalPrice,
      'shippingPrice': shippingPrice,
      'discountAmount': discountAmount,
      'subtotal': subtotal,
      if (discount != null) 'discount': discount,
    };
  }
}

class PriceBreakdown {
  final num itemsPrice;
  final num productDiscount;
  final num shippingPrice;
  final num discountAmount;
  final num couponDiscount;
  final String? appliedCouponCode;
  final num totalPrice;

  PriceBreakdown({
    required this.itemsPrice,
    required this.productDiscount,
    required this.shippingPrice,
    required this.discountAmount,
    required this.couponDiscount,
    this.appliedCouponCode,
    required this.totalPrice,
  });

  factory PriceBreakdown.empty() {
    return PriceBreakdown(
      itemsPrice: 0,
      productDiscount: 0,
      shippingPrice: 0,
      discountAmount: 0,
      couponDiscount: 0,
      appliedCouponCode: null,
      totalPrice: 0,
    );
  }

  factory PriceBreakdown.fromJson(Map<String, dynamic> json) {
    num parseNum(dynamic val) {
      if (val == null) return 0;
      if (val is num) return val;
      return num.tryParse(val.toString()) ?? 0;
    }

    return PriceBreakdown(
      itemsPrice: parseNum(json['itemsPrice']),
      productDiscount: parseNum(json['productDiscount']),
      shippingPrice: parseNum(json['shippingPrice']),
      discountAmount: parseNum(json['discountAmount']),
      couponDiscount: parseNum(json['couponDiscount']),
      appliedCouponCode: json['appliedCouponCode']?.toString(),
      totalPrice: parseNum(json['totalPrice']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'itemsPrice': itemsPrice,
      'productDiscount': productDiscount,
      'shippingPrice': shippingPrice,
      'discountAmount': discountAmount,
      'couponDiscount': couponDiscount,
      'appliedCouponCode': appliedCouponCode,
      'totalPrice': totalPrice,
    };
  }
}
