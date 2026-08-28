class CustomerInput {
  final String email;
  final String phone;

  CustomerInput({
    required this.email,
    required this.phone,
  });

  factory CustomerInput.fromJson(Map<String, dynamic> json) {
    return CustomerInput(
      email: json['email']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'email': email,
    'phone': phone,
  };
}

class ShippingAddressInput {
  final String phoneNumber;
  final String province;
  final String city;
  final String area;
  final String fullAddress;
  final String? landmark;
  final String? deliveryInstructions;
  final num? lat;
  final num? lon;

  ShippingAddressInput({
    required this.phoneNumber,
    required this.province,
    required this.city,
    required this.area,
    required this.fullAddress,
    this.landmark,
    this.deliveryInstructions,
    this.lat,
    this.lon,
  });

  factory ShippingAddressInput.fromJson(Map<String, dynamic> json) {
    return ShippingAddressInput(
      phoneNumber: json['phoneNumber']?.toString() ?? '',
      province: json['province']?.toString() ?? '',
      city: json['city']?.toString() ?? '',
      area: json['area']?.toString() ?? '',
      fullAddress: json['fullAddress']?.toString() ?? '',
      landmark: json['landmark']?.toString(),
      deliveryInstructions: json['deliveryInstructions']?.toString(),
      lat: json['lat'] is num ? json['lat'] as num : null,
      lon: json['lon'] is num ? json['lon'] as num : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'phoneNumber': phoneNumber,
    'province': province,
    'city': city,
    'area': area,
    'fullAddress': fullAddress,
    'landmark': landmark ?? '',
    'deliveryInstructions': deliveryInstructions ?? '',
    if (lat != null) 'lat': lat,
    if (lon != null) 'lon': lon,
  };
}

class PlaceOrderRequest {
  final String? userId;
  final CustomerInput customer;
  final List<Map<String, dynamic>> orderItems;
  final ShippingAddressInput shippingAddress;
  final String paymentMethod;
  final String? couponCode;
  final String? notes;
  final bool saveToAddressBook;

  PlaceOrderRequest({
    this.userId,
    required this.customer,
    required this.orderItems,
    required this.shippingAddress,
    this.paymentMethod = 'COD',
    this.couponCode,
    this.notes = '',
    this.saveToAddressBook = false,
  });

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'customer': customer.toJson(),
    'orderItems': orderItems,
    'shippingAddress': shippingAddress.toJson(),
    'paymentMethod': paymentMethod,
    'couponCode': couponCode,
    'notes': notes ?? '',
    'saveToAddressBook': saveToAddressBook,
  };
}

class PlaceOrderResponse {
  final bool success;
  final String? message;
  final OrderData? order;
  final dynamic coupon;
  final num totalPrice;

  PlaceOrderResponse({
    this.success = true,
    this.message,
    this.order,
    this.coupon,
    required this.totalPrice,
  });

  factory PlaceOrderResponse.fromJson(Map<String, dynamic> json) {
    num parseNum(dynamic val) {
      if (val == null) return 0;
      if (val is num) return val;
      return num.tryParse(val.toString()) ?? 0;
    }

    final rawOrder = json['order'];

    return PlaceOrderResponse(
      success: json['success'] == true || json['success'] == null,
      message: json['message']?.toString(),
      order: rawOrder is Map<String, dynamic> ? OrderData.fromJson(rawOrder) : null,
      coupon: json['coupon'],
      totalPrice: parseNum(json['totalPrice'] ?? (rawOrder is Map ? rawOrder['totalPrice'] : 0)),
    );
  }
}

class OrderData {
  final String id;
  final dynamic user;
  final CustomerInput? customer;
  final List<dynamic> orderItems;
  final dynamic shippingAddress;
  final String paymentMethod;
  final String paymentStatus;
  final String? transactionId;
  final dynamic paymentDetails;
  final String orderStatus;
  final num itemsPrice;
  final num shippingPrice;
  final num taxPrice;
  final num discountAmount;
  final num totalPrice;
  final String? paidAt;
  final String? notes;
  final dynamic coupon;
  final String? courierName;
  final String? trackingNumber;
  final String? createdAt;
  final String? updatedAt;

  OrderData({
    required this.id,
    this.user,
    this.customer,
    required this.orderItems,
    this.shippingAddress,
    required this.paymentMethod,
    required this.paymentStatus,
    this.transactionId,
    this.paymentDetails,
    required this.orderStatus,
    required this.itemsPrice,
    required this.shippingPrice,
    required this.taxPrice,
    required this.discountAmount,
    required this.totalPrice,
    this.paidAt,
    this.notes,
    this.coupon,
    this.courierName,
    this.trackingNumber,
    this.createdAt,
    this.updatedAt,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) {
    num parseNum(dynamic val) {
      if (val == null) return 0;
      if (val is num) return val;
      return num.tryParse(val.toString()) ?? 0;
    }

    final rawCustomer = json['customer'];

    return OrderData(
      id: json['_id']?.toString() ?? json['id']?.toString() ?? '',
      user: json['user'],
      customer: rawCustomer is Map<String, dynamic> ? CustomerInput.fromJson(rawCustomer) : null,
      orderItems: (json['orderItems'] as List?) ?? [],
      shippingAddress: json['shippingAddress'],
      paymentMethod: json['paymentMethod']?.toString() ?? 'COD',
      paymentStatus: json['paymentStatus']?.toString() ?? 'pending',
      transactionId: json['transactionId']?.toString(),
      paymentDetails: json['paymentDetails'],
      orderStatus: json['orderStatus']?.toString() ?? 'pending',
      itemsPrice: parseNum(json['itemsPrice']),
      shippingPrice: parseNum(json['shippingPrice']),
      taxPrice: parseNum(json['taxPrice']),
      discountAmount: parseNum(json['discountAmount']),
      totalPrice: parseNum(json['totalPrice']),
      paidAt: json['paidAt']?.toString(),
      notes: json['notes']?.toString(),
      coupon: json['coupon'],
      courierName: json['courierName']?.toString() ?? 'Leopards Courier',
      trackingNumber: json['trackingNumber']?.toString(),
      createdAt: json['createdAt']?.toString(),
      updatedAt: json['updatedAt']?.toString(),
    );
  }
}
