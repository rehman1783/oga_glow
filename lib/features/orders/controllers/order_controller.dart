import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:oga_glow/app/routes/app_routes.dart';
import 'package:oga_glow/core/constants/order_models.dart';
import 'package:oga_glow/core/network/api_exception.dart';
import 'package:oga_glow/features/auth/controllers/auth_controller.dart';
import '../services/order_service.dart';

/// Controller for the Order History screen.
///
/// Manages live backend orders, search filtering, and status-based filtering.
class OrderController extends GetxController {
  final OrderService _orderService;

  OrderController({OrderService? orderService})
      : _orderService = orderService ?? OrderService();

  /// The raw search query entered by the user.
  final searchQuery = RxString('');

  /// Currently selected filter status. Null means "All".
  final selectedStatus = Rx<OrderStatus?>(null);

  /// All real orders loaded from the backend.
  final allOrders = RxList<OrderModel>([]);

  /// The filtered list of orders after applying search + filter.
  final filteredOrders = RxList<OrderModel>([]);

  /// Loading and error states.
  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final isUnauthorized = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  /// Fetches real orders from the backend API.
  Future<void> fetchOrders({bool showLoading = true}) async {
    // Check auth status first
    bool userLoggedIn = false;
    if (Get.isRegistered<AuthController>()) {
      final auth = Get.find<AuthController>();
      userLoggedIn = auth.isLoggedIn.value && auth.currentToken.value != null;
    }

    if (!userLoggedIn) {
      debugPrint('[OrderController] User not authenticated. Checking if local session orders exist.');
      if (allOrders.isEmpty) {
        isUnauthorized.value = true;
      }
      return;
    }

    if (showLoading) {
      isLoading.value = true;
    }
    errorMessage.value = '';
    isUnauthorized.value = false;

    try {
      final realOrders = await _orderService.getMyOrders();
      allOrders.assignAll(realOrders);
      filterOrders();
    } on UnauthorizedException {
      debugPrint('[OrderController] 401 received from backend orders endpoint.');
      isUnauthorized.value = true;
    } on NetworkException {
      errorMessage.value = 'No internet connection. Please check your network and try again.';
    } on TimeoutException {
      errorMessage.value = 'Request timed out. Please pull down to refresh.';
    } on ApiException catch (e) {
      errorMessage.value = e.message;
    } catch (e) {
      errorMessage.value = 'Failed to load orders. Please try again.';
    } finally {
      isLoading.value = false;
    }
  }

  /// Pull-to-refresh action.
  Future<void> refreshOrders() async {
    await fetchOrders(showLoading: false);
  }

  /// Filters orders based on [query] and the currently selected [status].
  void filterOrders({String? query, OrderStatus? status, bool updateStatus = false}) {
    if (query != null) {
      searchQuery.value = query;
    }
    if (updateStatus) {
      selectedStatus.value = status;
    }

    final currentQuery = searchQuery.value.trim().toLowerCase();
    final currentStatus = selectedStatus.value;

    var results = List<OrderModel>.from(allOrders);

    // Apply status filter
    if (currentStatus != null) {
      results = results.where((o) => o.status == currentStatus).toList();
    }

    // Apply search filter
    if (currentQuery.isNotEmpty) {
      results = results
          .where(
            (o) =>
                o.orderId.toLowerCase().contains(currentQuery) ||
                o.productName.toLowerCase().contains(currentQuery) ||
                o.courierName.toLowerCase().contains(currentQuery) ||
                o.trackingNumber.toLowerCase().contains(currentQuery),
          )
          .toList();
    }

    filteredOrders.assignAll(results);
  }

  /// Convenience: filter by search query only.
  void searchOrders(String query) {
    filterOrders(query: query);
  }

  /// Convenience: filter by status only.
  void filterByStatus(OrderStatus? status) {
    selectedStatus.value = status;
    filterOrders();
  }

  /// Add newly placed order dynamically to the history list from checkout.
  void addNewOrder(OrderModel order) {
    isUnauthorized.value = false;
    allOrders.insert(0, order);
    filterOrders();
  }

  /// Navigate to the Order Details screen.
  void openOrderDetails(OrderModel order) {
    Get.toNamed(AppRoutes.orderDetails, arguments: order);
  }
}
