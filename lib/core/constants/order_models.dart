import 'package:get/get.dart';
import 'package:oga_glow/features/auth/controllers/auth_controller.dart';
import 'package:oga_glow/features/home/controllers/home_controller.dart';

// Data models for the Order History module.

/// Enum representing possible order statuses.
enum OrderStatus {
  pending,
  processing,
  shipped,
  outForDelivery,
  delivered,
  cancelled;

  /// Human-readable label for the status.
  String get label {
    switch (this) {
      case OrderStatus.pending:
        return 'Pending';
      case OrderStatus.processing:
        return 'Processing';
      case OrderStatus.shipped:
        return 'Shipped';
      case OrderStatus.outForDelivery:
        return 'Out for Delivery';
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.cancelled:
        return 'Cancelled';
    }
  }
}

/// Represents a single order.
class OrderModel {
  final String orderId;
  final String rawOrderId;
  final String productName;
  final String productImage;
  final int quantity;
  final double unitPrice;
  final double? originalPrice;
  final double? discountedPrice;
  final double discountAmount;
  final double shippingPrice;
  final double totalPrice;
  final String orderDate;
  final String paymentMethod;
  final OrderStatus status;
  final String customerName;
  final String phoneNumber;
  final String shippingAddress;
  final String estimatedDelivery;
  final String notes;
  final String courierName;
  final String trackingNumber;
  final List<TrackingStepModel> trackingSteps;

  const OrderModel({
    required this.orderId,
    this.rawOrderId = '',
    required this.productName,
    required this.productImage,
    required this.quantity,
    required this.unitPrice,
    this.originalPrice,
    this.discountedPrice,
    this.discountAmount = 0.0,
    this.shippingPrice = 0.0,
    required this.totalPrice,
    required this.orderDate,
    required this.paymentMethod,
    required this.status,
    required this.customerName,
    required this.phoneNumber,
    required this.shippingAddress,
    required this.estimatedDelivery,
    required this.notes,
    this.courierName = '',
    this.trackingNumber = '',
    required this.trackingSteps,
  });

  /// Formats raw IDs (e.g. 24-character hexadecimal MongoDB ObjectIds) into
  /// a short, memorable ID containing capital letters and numbers (e.g. "OG-8868D5").
  static String formatOrderId(String rawId) {
    final clean = rawId.trim();
    if (clean.isEmpty) {
      return 'OG-${DateTime.now().millisecondsSinceEpoch.toString().substring(7).toUpperCase()}';
    }
    // If already in short OG-XXXXXX format
    if (clean.toUpperCase().startsWith('OG-') && clean.length <= 12) {
      return clean.toUpperCase();
    }
    // For 24-character MongoDB hex ObjectId or other long IDs, take the last 6 characters in uppercase
    if (clean.length >= 8) {
      final shortPart = clean.substring(clean.length - 6).toUpperCase();
      return 'OG-$shortPart';
    }
    return 'OG-${clean.toUpperCase()}';
  }

  static String _extractImageFromItem(Map<String, dynamic> item) {
    final directKeys = [
      item['image'],
      item['productImage'],
      item['thumbnail'],
      item['img'],
      item['imageUrl'],
    ];
    for (final k in directKeys) {
      if (k != null && k.toString().trim().isNotEmpty) {
        return k.toString().trim();
      }
    }

    if (item['images'] is List && (item['images'] as List).isNotEmpty) {
      final firstImg = (item['images'] as List).first;
      if (firstImg is Map && firstImg['url'] != null) {
        return firstImg['url'].toString().trim();
      } else if (firstImg is String && firstImg.trim().isNotEmpty) {
        return firstImg.trim();
      }
    }

    if (item['product'] is Map) {
      final p = item['product'] as Map<String, dynamic>;
      if (p['images'] is List && (p['images'] as List).isNotEmpty) {
        final firstImg = (p['images'] as List).first;
        if (firstImg is Map && firstImg['url'] != null) {
          return firstImg['url'].toString().trim();
        } else if (firstImg is String && firstImg.trim().isNotEmpty) {
          return firstImg.trim();
        }
      }
      for (final key in ['image', 'productImage', 'thumbnail', 'url']) {
        if (p[key] != null && p[key].toString().trim().isNotEmpty) {
          return p[key].toString().trim();
        }
      }
    }

    return '';
  }

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    // 1. Order ID
    final rawId =
        (json['_id'] ?? json['id'] ?? json['orderId'] ?? '').toString();
    final formattedId = formatOrderId(rawId);

    // 2. Parse Items
    final rawItems = json['orderItems'] ?? json['items'] ?? [];
    final List<Map<String, dynamic>> itemsList = [];
    if (rawItems is List) {
      for (final it in rawItems) {
        if (it is Map<String, dynamic>) {
          itemsList.add(it);
        }
      }
    }

    String pName = 'Ogaglow Naturals Order';
    String pImage = '';
    String productId = '';
    double uPrice = 0.0;
    double? origPrice;
    double? discPrice;
    int totalQuantity = 0;

    if (itemsList.isNotEmpty) {
      final first = itemsList.first;
      final rawName = first['name'] ?? first['title'] ?? first['productName'];
      if (rawName != null && rawName.toString().isNotEmpty) {
        pName = rawName.toString();
        if (itemsList.length > 1) {
          pName = '$pName + ${itemsList.length - 1} more';
        }
      }

      // Check product ID
      if (first['product'] is String) {
        productId = first['product'].toString();
      } else if (first['product'] is Map && first['product']['_id'] != null) {
        productId = first['product']['_id'].toString();
      } else if (first['_id'] != null) {
        productId = first['_id'].toString();
      }

      pImage = _extractImageFromItem(first);

      uPrice = (num.tryParse(first['price']?.toString() ?? '0') ?? 0)
          .toDouble();

      if (first['originalPrice'] != null) {
        origPrice =
            (num.tryParse(first['originalPrice'].toString()) ?? 0).toDouble();
      }
      if (first['discountedPrice'] != null) {
        discPrice =
            (num.tryParse(first['discountedPrice'].toString()) ?? 0).toDouble();
      }

      for (final item in itemsList) {
        totalQuantity += int.tryParse(item['quantity']?.toString() ?? '1') ?? 1;
      }
    } else {
      totalQuantity = int.tryParse(json['quantity']?.toString() ?? '1') ?? 1;
    }

    // 3. Price & Discount Breakdown
    final double total =
        (num.tryParse(
                  json['totalPrice']?.toString() ??
                      json['totalAmount']?.toString() ??
                      json['itemsPrice']?.toString() ??
                      '0',
                ) ??
                0)
            .toDouble();

    double discAmount =
        (num.tryParse(
                  json['discountAmount']?.toString() ??
                      json['discount']?.toString() ??
                      json['couponDiscount']?.toString() ??
                      '0',
                ) ??
                0)
            .toDouble();

    double shipPrice =
        (num.tryParse(
                  json['shippingPrice']?.toString() ??
                      json['shippingFee']?.toString() ??
                      '0',
                ) ??
                0)
            .toDouble();

    // 3b. Catalog Match Lookup from HomeController for image and discount accuracy
    if (Get.isRegistered<HomeController>()) {
      try {
        final home = Get.find<HomeController>();
        final match = home.allProducts.firstWhereOrNull(
          (p) =>
              p.name.trim().toLowerCase() == pName.trim().toLowerCase() ||
              (productId.isNotEmpty && p.id == productId),
        );
        if (match != null) {
          if (pImage.isEmpty || pImage.contains('placeholder')) {
            pImage = match.mainImageUrl;
          }
          if (match.hasDiscount) {
            origPrice ??= match.price;
            discPrice ??= match.finalPrice;
            if (discAmount <= 0) {
              discAmount =
                  (match.price - match.finalPrice) *
                  (totalQuantity > 0 ? totalQuantity : 1);
            }
          }
          if (shipPrice <= 0 && match.shippingPrice > 0) {
            shipPrice = match.shippingPrice;
          }
        }
      } catch (_) {}
    }

    // Ensure price consistency
    if (uPrice <= 0) {
      if (discPrice != null && discPrice > 0) {
        uPrice = discPrice;
      } else if (origPrice != null && origPrice > 0) {
        uPrice = origPrice;
      } else {
        uPrice = total > shipPrice ? total - shipPrice : total;
      }
    }

    if (discPrice == null) {
      if (origPrice != null && origPrice > uPrice) {
        discPrice = uPrice;
      } else if (discAmount > 0 && uPrice > 0) {
        discPrice = uPrice;
        origPrice ??= uPrice + (discAmount / (totalQuantity > 0 ? totalQuantity : 1));
      } else {
        discPrice = uPrice;
      }
    }

    if (origPrice == null) {
      if (discAmount > 0 && discPrice > 0) {
        origPrice = discPrice + (discAmount / (totalQuantity > 0 ? totalQuantity : 1));
      } else {
        origPrice = discPrice;
      }
    }

    if (shipPrice <= 0 && total > (discPrice * (totalQuantity > 0 ? totalQuantity : 1))) {
      shipPrice = total - (discPrice * (totalQuantity > 0 ? totalQuantity : 1));
    }

    if (pImage.isEmpty) {
      pImage = 'assets/images/product_placeholder.png';
    }

    // 4. Date formatting
    final String dateString = _formatDate(
      json['createdAt']?.toString() ?? json['orderDate']?.toString(),
    );

    // 5. Status
    final status = _parseStatus(
      json['orderStatus']?.toString() ?? json['status']?.toString(),
    );

    // 6. Customer & Phone
    String custName = '';
    String phone = '';
    if (json['customer'] is Map) {
      final c = json['customer'] as Map;
      custName = (c['name'] ?? c['fullName'] ?? c['customerName'] ?? '').toString();
      phone = (c['phone'] ?? c['phoneNumber'] ?? '').toString();
    }
    if (custName.isEmpty && json['customerName'] != null) {
      custName = json['customerName'].toString();
    }
    if (custName.isEmpty && json['user'] is Map) {
      final u = json['user'] as Map;
      custName = (u['name'] ?? u['fullName'] ?? u['username'] ?? '').toString();
    }

    // 7. Shipping Address
    String formattedAddress = 'Standard Delivery Address';
    if (json['shippingAddress'] is Map) {
      final a = json['shippingAddress'] as Map;
      final fullAddr = a['fullAddress'] ?? a['address'] ?? '';
      final area = a['area'] ?? '';
      final city = a['city'] ?? '';
      final province = a['province'] ?? '';
      final recipientPhone = a['phoneNumber'] ?? a['phone'] ?? '';

      if (phone.isEmpty && recipientPhone.toString().isNotEmpty) {
        phone = recipientPhone.toString();
      }
      if (custName.isEmpty || custName.toLowerCase() == 'valued customer') {
        final addressName =
            (a['fullName'] ?? a['name'] ?? a['recipientName'] ?? a['customerName'] ?? '').toString();
        if (addressName.isNotEmpty) {
          custName = addressName;
        }
      }

      final parts = [
        fullAddr,
        area,
        city,
        province,
      ].map((e) => e.toString().trim()).where((e) => e.isNotEmpty).toList();

      if (parts.isNotEmpty) {
        formattedAddress = parts.join(', ');
      }
    } else if (json['shippingAddress'] is String &&
        (json['shippingAddress'] as String).isNotEmpty) {
      formattedAddress = json['shippingAddress'] as String;
    }

    // Fallback to active logged in user profile if customer name is missing or "Valued Customer"
    if (custName.isEmpty || custName.trim().toLowerCase() == 'valued customer') {
      if (Get.isRegistered<AuthController>()) {
        try {
          final authUser = Get.find<AuthController>().currentUser.value;
          if (authUser != null && authUser.name.trim().isNotEmpty) {
            custName = authUser.name.trim();
          }
        } catch (_) {}
      }
    }
    if (custName.isEmpty) {
      custName = 'Valued Customer';
    }

    // 8. Courier & Tracking
    final String courier =
        (json['courierName'] ?? json['courier'] ?? 'Leopards Courier')
            .toString();
    final String tracking = (json['trackingNumber'] ?? json['tracking'] ?? '')
        .toString();

    // 9. Dynamic Tracking Steps
    final steps = _buildTrackingSteps(
      status: status,
      orderDate: dateString,
      courierName: courier,
      trackingNumber: tracking,
    );

    return OrderModel(
      orderId: formattedId,
      rawOrderId: rawId,
      productName: pName,
      productImage: pImage,
      quantity: totalQuantity > 0 ? totalQuantity : 1,
      unitPrice: uPrice > 0 ? uPrice : total,
      originalPrice: origPrice,
      discountedPrice: discPrice,
      discountAmount: discAmount,
      shippingPrice: shipPrice,
      totalPrice: total,
      orderDate: dateString,
      paymentMethod: (json['paymentMethod'] ?? 'Cash on Delivery (COD)')
          .toString(),
      status: status,
      customerName: custName,
      phoneNumber: phone.isNotEmpty ? phone : '+92 (Not specified)',
      shippingAddress: formattedAddress,
      estimatedDelivery: (json['estimatedDelivery'] ?? '3-5 Business Days')
          .toString(),
      notes: (json['notes'] ?? '').toString(),
      courierName: courier,
      trackingNumber: tracking,
      trackingSteps: steps,
    );
  }

  static String _formatDate(String? rawDate) {
    if (rawDate == null || rawDate.isEmpty) return 'Recent';
    try {
      final dt = DateTime.parse(rawDate).toLocal();
      const months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec',
      ];
      final month = months[dt.month - 1];
      final hour = dt.hour > 12 ? dt.hour - 12 : (dt.hour == 0 ? 12 : dt.hour);
      final amPm = dt.hour >= 12 ? 'PM' : 'AM';
      final minute = dt.minute.toString().padLeft(2, '0');
      return '$month ${dt.day}, ${dt.year} • $hour:$minute $amPm';
    } catch (_) {
      return rawDate;
    }
  }

  static OrderStatus _parseStatus(String? rawStatus) {
    final s = (rawStatus ?? '').trim().toLowerCase();
    switch (s) {
      case 'processing':
      case 'in_progress':
      case 'confirmed':
        return OrderStatus.processing;
      case 'shipped':
      case 'in_transit':
      case 'dispatched':
        return OrderStatus.shipped;
      case 'outfordelivery':
      case 'out_for_delivery':
      case 'out for delivery':
        return OrderStatus.outForDelivery;
      case 'delivered':
      case 'completed':
        return OrderStatus.delivered;
      case 'cancelled':
      case 'canceled':
        return OrderStatus.cancelled;
      case 'pending':
      default:
        return OrderStatus.pending;
    }
  }

  static List<TrackingStepModel> _buildTrackingSteps({
    required OrderStatus status,
    required String orderDate,
    required String courierName,
    required String trackingNumber,
  }) {
    if (status == OrderStatus.cancelled) {
      return [
        TrackingStepModel(
          title: 'Order Placed',
          description: 'Order was created on Ogaglow Naturals.',
          dateTime: orderDate,
          isCompleted: true,
        ),
        const TrackingStepModel(
          title: 'Order Cancelled',
          description: 'This order was cancelled.',
          dateTime: 'Updated',
          isCompleted: true,
        ),
      ];
    }

    final isDelivered = status == OrderStatus.delivered;
    final isOutForDelivery =
        isDelivered || status == OrderStatus.outForDelivery;
    final isShipped = isOutForDelivery || status == OrderStatus.shipped;
    final isProcessing = isShipped || status == OrderStatus.processing;

    final courierInfo = trackingNumber.isNotEmpty
        ? '$courierName (Tracking: $trackingNumber)'
        : courierName;

    return [
      TrackingStepModel(
        title: 'Order Placed',
        description: 'Your order was successfully placed.',
        dateTime: orderDate,
        isCompleted: true,
      ),
      TrackingStepModel(
        title: 'Processing',
        description: isProcessing
            ? 'Order items verified and packed in botanical safety packaging.'
            : 'Order will be processed soon.',
        dateTime: isProcessing ? 'In Progress' : 'Pending',
        isCompleted: isProcessing,
      ),
      TrackingStepModel(
        title: 'Shipped',
        description: isShipped
            ? 'Handed over to $courierInfo.'
            : 'Awaiting dispatch from warehouse.',
        dateTime: isShipped ? 'Dispatched' : 'Pending',
        isCompleted: isShipped,
      ),
      TrackingStepModel(
        title: 'Out for Delivery',
        description: isOutForDelivery
            ? 'Courier rider is on the way to your shipping address.'
            : 'Pending courier delivery route.',
        dateTime: isOutForDelivery ? 'Today' : 'Pending',
        isCompleted: isOutForDelivery,
      ),
      TrackingStepModel(
        title: 'Delivered',
        description: isDelivered
            ? 'Package safely received by customer.'
            : 'Expected within 3-5 business days.',
        dateTime: isDelivered ? 'Completed' : 'Pending',
        isCompleted: isDelivered,
      ),
    ];
  }
}

/// Represents a single step in the order tracking timeline.
class TrackingStepModel {
  final String title;
  final String description;
  final String dateTime;
  final bool isCompleted;

  const TrackingStepModel({
    required this.title,
    required this.description,
    required this.dateTime,
    required this.isCompleted,
  });
}
