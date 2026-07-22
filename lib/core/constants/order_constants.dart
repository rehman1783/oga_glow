import 'order_models.dart';
export 'order_models.dart';

/// Central repository for all Order data.
///
/// Stores static dummy orders for development. When Firebase is integrated,
/// replace this with a service that fetches from Firestore.
class OrderConstants {
  OrderConstants._();

  // ---------------------------------------------------------------------------
  // Mock Orders
  // ---------------------------------------------------------------------------

  /// Returns a list of sample orders covering all order statuses.
  static List<OrderModel> get orders => _buildOrders();

  static List<OrderModel> _buildOrders() {
    return [
      // 1. Delivered
      OrderModel(
        orderId: 'OG-2024-001',
        productName: 'Vitamin C Brightening Serum',
        productImage: 'assets/images/product_placeholder.png',
        quantity: 2,
        unitPrice: 24.99,
        totalPrice: 49.98,
        orderDate: 'June 10, 2026',
        paymentMethod: 'Credit Card',
        status: OrderStatus.delivered,
        customerName: 'Ahmed Hassan',
        phoneNumber: '+92 300 1234567',
        shippingAddress:
            'House #12, Street 5, Block B, Gulshan-e-Maymar, Karachi, Sindh',
        estimatedDelivery: 'June 15, 2026',
        notes: 'Leave at the front gate, please.',
        trackingSteps: [
          const TrackingStepModel(
            title: 'Order Placed',
            description: 'Your order has been placed successfully.',
            dateTime: 'June 10, 2026 • 09:30 AM',
            isCompleted: true,
          ),
          const TrackingStepModel(
            title: 'Processing',
            description: 'Your order is being processed.',
            dateTime: 'June 10, 2026 • 11:15 AM',
            isCompleted: true,
          ),
          const TrackingStepModel(
            title: 'Shipped',
            description: 'Your order has been shipped.',
            dateTime: 'June 11, 2026 • 03:20 PM',
            isCompleted: true,
          ),
          const TrackingStepModel(
            title: 'Out for Delivery',
            description: 'Your order is out for delivery.',
            dateTime: 'June 13, 2026 • 08:45 AM',
            isCompleted: true,
          ),
          const TrackingStepModel(
            title: 'Delivered',
            description: 'Your order has been delivered successfully.',
            dateTime: 'June 13, 2026 • 02:30 PM',
            isCompleted: true,
          ),
        ],
      ),

      // 2. Out for Delivery
      OrderModel(
        orderId: 'OG-2024-002',
        productName: 'Hydrating Hyaluronic Acid Moisturizer',
        productImage: 'assets/images/product_placeholder.png',
        quantity: 1,
        unitPrice: 34.99,
        totalPrice: 34.99,
        orderDate: 'June 12, 2026',
        paymentMethod: 'JazzCash',
        status: OrderStatus.outForDelivery,
        customerName: 'Fatima Ali',
        phoneNumber: '+92 321 9876543',
        shippingAddress:
            'Flat #7, Al-Rehman Tower, Shahrah-e-Faisal, Karachi, Sindh',
        estimatedDelivery: 'June 16, 2026',
        notes: 'Call before delivery.',
        trackingSteps: [
          const TrackingStepModel(
            title: 'Order Placed',
            description: 'Your order has been placed successfully.',
            dateTime: 'June 12, 2026 • 10:00 AM',
            isCompleted: true,
          ),
          const TrackingStepModel(
            title: 'Processing',
            description: 'Your order is being processed.',
            dateTime: 'June 12, 2026 • 01:30 PM',
            isCompleted: true,
          ),
          const TrackingStepModel(
            title: 'Shipped',
            description: 'Your order has been shipped.',
            dateTime: 'June 13, 2026 • 11:00 AM',
            isCompleted: true,
          ),
          const TrackingStepModel(
            title: 'Out for Delivery',
            description: 'Your order is out for delivery.',
            dateTime: 'June 14, 2026 • 09:15 AM',
            isCompleted: true,
          ),
          const TrackingStepModel(
            title: 'Delivered',
            description: 'Your order has been delivered successfully.',
            dateTime: '',
            isCompleted: false,
          ),
        ],
      ),

      // 3. Shipped
      OrderModel(
        orderId: 'OG-2024-003',
        productName: 'Retinol Night Repair Cream',
        productImage: 'assets/images/product_placeholder.png',
        quantity: 1,
        unitPrice: 44.99,
        totalPrice: 44.99,
        orderDate: 'June 14, 2026',
        paymentMethod: 'Easypaisa',
        status: OrderStatus.shipped,
        customerName: 'Usman Khan',
        phoneNumber: '+92 333 5557777',
        shippingAddress:
            'House #4, Street 12, Phase 2, DHA, Lahore, Punjab',
        estimatedDelivery: 'June 19, 2026',
        notes: '',
        trackingSteps: [
          const TrackingStepModel(
            title: 'Order Placed',
            description: 'Your order has been placed successfully.',
            dateTime: 'June 14, 2026 • 02:00 PM',
            isCompleted: true,
          ),
          const TrackingStepModel(
            title: 'Processing',
            description: 'Your order is being processed.',
            dateTime: 'June 14, 2026 • 04:45 PM',
            isCompleted: true,
          ),
          const TrackingStepModel(
            title: 'Shipped',
            description: 'Your order has been shipped.',
            dateTime: 'June 15, 2026 • 10:30 AM',
            isCompleted: true,
          ),
          const TrackingStepModel(
            title: 'Out for Delivery',
            description: 'Your order is out for delivery.',
            dateTime: '',
            isCompleted: false,
          ),
          const TrackingStepModel(
            title: 'Delivered',
            description: 'Your order has been delivered successfully.',
            dateTime: '',
            isCompleted: false,
          ),
        ],
      ),

      // 4. Processing
      OrderModel(
        orderId: 'OG-2024-004',
        productName: 'Niacinamide 10% + Zinc 1%',
        productImage: 'assets/images/product_placeholder.png',
        quantity: 3,
        unitPrice: 19.99,
        totalPrice: 59.97,
        orderDate: 'June 15, 2026',
        paymentMethod: 'Cash on Delivery',
        status: OrderStatus.processing,
        customerName: 'Sana Malik',
        phoneNumber: '+92 312 4448888',
        shippingAddress:
            'Office #3, Business Centre, I.I. Chundrigar Road, Karachi, Sindh',
        estimatedDelivery: 'June 20, 2026',
        notes: 'Deliver during office hours (10 AM - 5 PM).',
        trackingSteps: [
          const TrackingStepModel(
            title: 'Order Placed',
            description: 'Your order has been placed successfully.',
            dateTime: 'June 15, 2026 • 11:20 AM',
            isCompleted: true,
          ),
          const TrackingStepModel(
            title: 'Processing',
            description: 'Your order is being processed.',
            dateTime: 'June 15, 2026 • 02:00 PM',
            isCompleted: true,
          ),
          const TrackingStepModel(
            title: 'Shipped',
            description: 'Your order has been shipped.',
            dateTime: '',
            isCompleted: false,
          ),
          const TrackingStepModel(
            title: 'Out for Delivery',
            description: 'Your order is out for delivery.',
            dateTime: '',
            isCompleted: false,
          ),
          const TrackingStepModel(
            title: 'Delivered',
            description: 'Your order has been delivered successfully.',
            dateTime: '',
            isCompleted: false,
          ),
        ],
      ),

      // 5. Cancelled
      OrderModel(
        orderId: 'OG-2024-005',
        productName: 'SPF 50 Sunscreen PA+++',
        productImage: 'assets/images/product_placeholder.png',
        quantity: 2,
        unitPrice: 15.99,
        totalPrice: 31.98,
        orderDate: 'June 8, 2026',
        paymentMethod: 'Credit Card',
        status: OrderStatus.cancelled,
        customerName: 'Bilal Ahmed',
        phoneNumber: '+92 345 6669999',
        shippingAddress:
            'House #22, Street 8, Sector F, Askari IV, Rawalpindi, Punjab',
        estimatedDelivery: 'N/A',
        notes: 'Cancelled due to change of mind.',
        trackingSteps: [
          const TrackingStepModel(
            title: 'Order Placed',
            description: 'Your order has been placed successfully.',
            dateTime: 'June 8, 2026 • 03:00 PM',
            isCompleted: true,
          ),
          const TrackingStepModel(
            title: 'Cancelled',
            description: 'Your order has been cancelled.',
            dateTime: 'June 8, 2026 • 05:30 PM',
            isCompleted: true,
          ),
        ],
      ),

      // 6. Pending
      OrderModel(
        orderId: 'OG-2024-006',
        productName: 'Salicylic Acid 2% Face Wash',
        productImage: 'assets/images/product_placeholder.png',
        quantity: 1,
        unitPrice: 12.99,
        totalPrice: 12.99,
        orderDate: 'June 16, 2026',
        paymentMethod: 'Bank Transfer',
        status: OrderStatus.pending,
        customerName: 'Zainab Iqbal',
        phoneNumber: '+92 300 1112233',
        shippingAddress:
            'Flat #10, Al-Noor Apartments, University Road, Peshawar, KPK',
        estimatedDelivery: 'June 22, 2026',
        notes: '',
        trackingSteps: [
          const TrackingStepModel(
            title: 'Order Placed',
            description: 'Your order has been placed successfully.',
            dateTime: 'June 16, 2026 • 09:00 AM',
            isCompleted: true,
          ),
          const TrackingStepModel(
            title: 'Processing',
            description: 'Your order is being processed.',
            dateTime: '',
            isCompleted: false,
          ),
          const TrackingStepModel(
            title: 'Shipped',
            description: 'Your order has been shipped.',
            dateTime: '',
            isCompleted: false,
          ),
          const TrackingStepModel(
            title: 'Out for Delivery',
            description: 'Your order is out for delivery.',
            dateTime: '',
            isCompleted: false,
          ),
          const TrackingStepModel(
            title: 'Delivered',
            description: 'Your order has been delivered successfully.',
            dateTime: '',
            isCompleted: false,
          ),
        ],
      ),
    ];
  }
}

