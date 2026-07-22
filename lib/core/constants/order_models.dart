/// Data models for the Order History module.

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
    required this.trackingSteps,
  });
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

