import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/order_constants.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/widgets/custom_snackbar.dart';
import '../../auth/controllers/auth_controller.dart';
import '../../cart/bindings/cart_binding.dart';
import '../../cart/controllers/cart_controller.dart';
import '../../orders/controllers/order_controller.dart';
import '../models/checkout_preview_model.dart';
import '../models/place_order_model.dart';
import '../repositories/checkout_repository.dart';
import '../widgets/order_success_dialog.dart';

class CheckoutController extends GetxController {
  final CheckoutRepository _checkoutRepository;

  CheckoutController({CheckoutRepository? checkoutRepository})
      : _checkoutRepository = checkoutRepository ?? CheckoutRepository();

  final formKey = GlobalKey<FormState>();

  // Payment method (COD per API docs)
  final paymentMethod = 'COD'.obs;

  // Contact Information Fields
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  // Address Fields
  final selectedProvince = 'Sindh'.obs;
  final cityController = TextEditingController();
  final areaController = TextEditingController();
  final addressController = TextEditingController();
  final landmarkController = TextEditingController();
  final deliveryInstructionsController = TextEditingController();
  final notesController = TextEditingController();
  final saveToAddressBook = false.obs;

  // Coupon
  final couponController = TextEditingController();
  final appliedCouponCode = ''.obs;
  final couponError = ''.obs;

  // Loading States & Preview Data
  final isLoadingPreview = false.obs;
  final isPlacingOrder = false.obs;
  final isApplyingCoupon = false.obs;
  final previewData = Rx<CheckoutPreviewResponse?>(null);
  final previewErrorMessage = ''.obs;

  CartController get _cartController {
    if (!Get.isRegistered<CartController>(tag: CartController.tag)) {
      CartBinding().dependencies();
    }
    return Get.find<CartController>(tag: CartController.tag);
  }

  List<Map<String, dynamic>> get cartItems => _cartController.cartItems;

  // Price calculations synced with preview API with local fallback
  num get subtotal =>
      previewData.value?.priceBreakdown.itemsPrice ?? _cartController.totalSubtotal;
  num get productDiscount =>
      previewData.value?.priceBreakdown.productDiscount ?? _cartController.totalDiscount;
  num get shipping =>
      previewData.value?.priceBreakdown.shippingPrice ?? _cartController.totalShipping;
  num get couponDiscount =>
      previewData.value?.priceBreakdown.couponDiscount ?? 0;
  num get grandTotal =>
      previewData.value?.priceBreakdown.totalPrice ?? _cartController.grandTotal;

  @override
  void onInit() {
    super.onInit();
    _populateUserInfo();
    fetchCheckoutPreview();
  }



  void _populateUserInfo() {
    if (Get.isRegistered<AuthController>()) {
      final auth = Get.find<AuthController>();
      final user = auth.currentUser.value;
      if (user != null) {
        if (nameController.text.isEmpty) nameController.text = user.name;
        if (emailController.text.isEmpty) emailController.text = user.email;
      }
    }
  }

  List<Map<String, dynamic>> _prepareOrderItemsPayload() {
    return cartItems.map((item) {
      final productId = item['id']?.toString() ??
          (item['productModel'] != null ? item['productModel'].id : '') ??
          '';
      final qty = int.tryParse(item['quantity']?.toString() ?? '1') ?? 1;
      return {
        'product': productId,
        'quantity': qty,
      };
    }).where((element) => (element['product'] as String).isNotEmpty).toList();
  }

  /// 1. Checkout Preview API call
  Future<void> fetchCheckoutPreview({String? coupon}) async {
    final items = _prepareOrderItemsPayload();
    if (items.isEmpty) return;

    isLoadingPreview.value = true;
    previewErrorMessage.value = '';

    try {
      final response = await _checkoutRepository.getCheckoutPreview(
        items: items,
        couponCode: coupon,
      );

      previewData.value = response;

      // Handle coupon feedback
      if (coupon != null && coupon.isNotEmpty) {
        if (response.couponError != null && response.couponError!.isNotEmpty) {
          couponError.value = response.couponError!;
          appliedCouponCode.value = '';
        } else {
          couponError.value = '';
          appliedCouponCode.value = coupon;
        }
      }
    } on ApiException catch (e) {
      previewErrorMessage.value = e.message;
      if (coupon != null && coupon.isNotEmpty) {
        couponError.value = e.message;
      }
    } catch (_) {
      previewErrorMessage.value = 'Failed to calculate checkout preview.';
    } finally {
      isLoadingPreview.value = false;
    }
  }

  /// Apply Coupon Code
  Future<void> applyCoupon() async {
    final code = couponController.text.trim();
    if (code.isEmpty) {
      couponError.value = 'Please enter a valid coupon code.';
      return;
    }

    isApplyingCoupon.value = true;
    couponError.value = '';
    await fetchCheckoutPreview(coupon: code);
    isApplyingCoupon.value = false;
  }

  /// Remove Applied Coupon Code
  Future<void> removeCoupon() async {
    couponController.clear();
    appliedCouponCode.value = '';
    couponError.value = '';
    await fetchCheckoutPreview(coupon: null);
  }

  void setPaymentMethod(String v) => paymentMethod.value = v;

  /// 2. Place Order API call
  Future<void> placeOrder(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      CustomSnackbar.showWarning(
        title: 'Incomplete Details',
        message: 'Please complete all required fields before proceeding.',
      );
      return;
    }

    if (selectedProvince.value.isEmpty) {
      CustomSnackbar.showWarning(
        title: 'Province Required',
        message: 'Please select a province.',
      );
      return;
    }

    final items = _prepareOrderItemsPayload();
    if (items.isEmpty) {
      CustomSnackbar.showError(
        title: 'Empty Cart',
        message: 'Your cart is empty. Please add items to checkout.',
      );
      return;
    }

    isPlacingOrder.value = true;

    try {
      String? userId;
      if (Get.isRegistered<AuthController>()) {
        final auth = Get.find<AuthController>();
        userId = auth.currentUser.value?.id;
      }

      final payload = PlaceOrderRequest(
        userId: userId,
        customer: CustomerInput(
          email: emailController.text.trim(),
          phone: phoneController.text.trim(),
        ),
        orderItems: items,
        shippingAddress: ShippingAddressInput(
          phoneNumber: phoneController.text.trim(),
          province: selectedProvince.value,
          city: cityController.text.trim(),
          area: areaController.text.trim(),
          fullAddress: addressController.text.trim(),
          landmark: landmarkController.text.trim(),
          deliveryInstructions: deliveryInstructionsController.text.trim(),
        ),
        paymentMethod: paymentMethod.value,
        couponCode: appliedCouponCode.value.isNotEmpty ? appliedCouponCode.value : null,
        notes: notesController.text.trim(),
        saveToAddressBook: saveToAddressBook.value,
      );

      final response = await _checkoutRepository.placeOrder(payload);

      if (response.order != null) {
        // Clear cart on successful order
        _cartController.clearCart();

        // Integrate new order into OrderController so it is visible in My Orders
        _recordOrderInHistory(response.order!);

        // Show celebration success modal
        if (context.mounted) {
          await OrderSuccessDialog.show(context, response.order!);
        }
      } else {
        throw ApiException(message: response.message ?? 'Failed to place order.');
      }
    } on ApiException catch (e) {
      CustomSnackbar.showError(
        title: 'Order Placement Failed',
        message: e.message,
      );
    } catch (e) {
      CustomSnackbar.showError(
        title: 'Order Placement Failed',
        message: 'An unexpected error occurred. Please try again.',
      );
    } finally {
      isPlacingOrder.value = false;
    }
  }

  void _recordOrderInHistory(OrderData orderData) {
    if (Get.isRegistered<OrderController>()) {
      final orderController = Get.find<OrderController>();

      final firstItemName = orderData.orderItems.isNotEmpty &&
              orderData.orderItems.first is Map
          ? (orderData.orderItems.first['name']?.toString() ?? 'Order Item')
          : 'OgaGlow Order';

      final firstItemImage = orderData.orderItems.isNotEmpty &&
              orderData.orderItems.first is Map
          ? (orderData.orderItems.first['image']?.toString() ?? '')
          : '';

      final int totalQty = orderData.orderItems.fold<int>(0, (sum, it) {
        if (it is Map) {
          return sum + (int.tryParse(it['quantity']?.toString() ?? '1') ?? 1);
        }
        return sum + 1;
      });

      final newOrderModel = OrderModel(
        orderId: orderData.id.length > 8
            ? 'OG-${orderData.id.substring(orderData.id.length - 6).toUpperCase()}'
            : 'OG-${orderData.id}',
        productName: firstItemName,
        productImage: firstItemImage.isNotEmpty
            ? firstItemImage
            : 'assets/images/product_placeholder.png',
        quantity: totalQty > 0 ? totalQty : 1,
        unitPrice: orderData.itemsPrice.toDouble(),
        totalPrice: orderData.totalPrice.toDouble(),
        orderDate: _formatOrderDate(orderData.createdAt),
        paymentMethod: orderData.paymentMethod == 'COD'
            ? 'Cash on Delivery'
            : orderData.paymentMethod,
        status: OrderStatus.pending,
        customerName: nameController.text.trim().isNotEmpty
            ? nameController.text.trim()
            : (orderData.customer?.email ?? 'Customer'),
        phoneNumber: orderData.customer?.phone ?? phoneController.text.trim(),
        shippingAddress:
            '${addressController.text.trim()}, ${areaController.text.trim()}, ${cityController.text.trim()}, ${selectedProvince.value}',
        estimatedDelivery: '3-5 Business Days',
        notes: orderData.notes ?? '',
        trackingSteps: [
          TrackingStepModel(
            title: 'Order Placed',
            description:
                'Your order has been placed. Courier: ${orderData.courierName ?? 'Leopards Courier'} (${orderData.trackingNumber ?? 'Tracking assigned'})',
            dateTime: _formatOrderDate(orderData.createdAt),
            isCompleted: true,
          ),
          const TrackingStepModel(
            title: 'Processing',
            description: 'Your order is being packed and prepared for pickup.',
            dateTime: '',
            isCompleted: false,
          ),
          const TrackingStepModel(
            title: 'Shipped',
            description: 'Handed over to Leopards Courier for dispatch.',
            dateTime: '',
            isCompleted: false,
          ),
          const TrackingStepModel(
            title: 'Out for Delivery',
            description: 'Courier agent is on the way to your address.',
            dateTime: '',
            isCompleted: false,
          ),
          const TrackingStepModel(
            title: 'Delivered',
            description: 'Package delivered to recipient.',
            dateTime: '',
            isCompleted: false,
          ),
        ],
      );

      orderController.addNewOrder(newOrderModel);
    }
  }

  String _formatOrderDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) {
      return 'Just now';
    }
    try {
      final dt = DateTime.parse(dateStr).toLocal();
      return '${dt.day}/${dt.month}/${dt.year} • ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
    } catch (_) {
      return 'Recently';
    }
  }
}
