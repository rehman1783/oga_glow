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
  final String productName;
  final String productImage;
  final int quantity;
  final double unitPrice;
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
    required this.productName,
    required this.productImage,
    required this.quantity,
    required this.unitPrice,
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

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    // 1. Order ID
    final id = (json['_id'] ?? json['id'] ?? json['orderId'] ?? '').toString();

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

    String pName = 'OGAGLOW Skincare Order';
    String pImage = 'assets/images/product_placeholder.png';
    double uPrice = 0.0;
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

      final rawImg =
          first['image'] ?? first['productImage'] ?? first['thumbnail'];
      if (rawImg != null && rawImg.toString().isNotEmpty) {
        pImage = rawImg.toString();
      }

      uPrice = (num.tryParse(first['price']?.toString() ?? '0') ?? 0)
          .toDouble();

      for (final item in itemsList) {
        totalQuantity += int.tryParse(item['quantity']?.toString() ?? '1') ?? 1;
      }
    } else {
      totalQuantity = int.tryParse(json['quantity']?.toString() ?? '1') ?? 1;
    }

    // 3. Price
    final double total =
        (num.tryParse(
                  json['totalPrice']?.toString() ??
                      json['totalAmount']?.toString() ??
                      json['itemsPrice']?.toString() ??
                      '0',
                ) ??
                0)
            .toDouble();

    // 4. Date formatting
    final String dateString = _formatDate(
      json['createdAt']?.toString() ?? json['orderDate']?.toString(),
    );

    // 5. Status
    final status = _parseStatus(
      json['orderStatus']?.toString() ?? json['status']?.toString(),
    );

    // 6. Customer & Phone
    String custName = 'Valued Customer';
    String phone = '';
    if (json['customer'] is Map) {
      final c = json['customer'] as Map;
      custName = c['name'] ?? c['fullName'] ?? custName;
      phone = c['phone'] ?? c['phoneNumber'] ?? phone;
    }

    // 7. Shipping Address
    String formattedAddress = 'Standard Delivery Address';
    if (json['shippingAddress'] is Map) {
      final a = json['shippingAddress'] as Map;
      final fullAddr = a['fullAddress'] ?? a['address'] ?? '';
      final area = a['area'] ?? '';
      final city = a['city'] ?? '';
      final province = a['province'] ?? '';
      final recipientPhone = a['phoneNumber'] ?? '';

      if (phone.isEmpty && recipientPhone.toString().isNotEmpty) {
        phone = recipientPhone.toString();
      }
      if (custName == 'Valued Customer' && a['fullName'] != null) {
        custName = a['fullName'].toString();
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
      orderId: id.isNotEmpty
          ? id
          : 'OG-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
      productName: pName,
      productImage: pImage,
      quantity: totalQuantity > 0 ? totalQuantity : 1,
      unitPrice: uPrice > 0 ? uPrice : total,
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
          description: 'Order was created on OGAGLOW.',
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
