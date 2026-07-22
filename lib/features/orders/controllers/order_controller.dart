import 'package:get/get.dart';
import 'package:oga_glow/app/routes/app_routes.dart';
import 'package:oga_glow/core/constants/order_constants.dart';

/// Controller for the Order History screen.
///
/// Manages search filtering and status-based filtering.
class OrderController extends GetxController {
  /// The raw search query entered by the user.
  final searchQuery = RxString('');

  /// Currently selected filter status. Null means "All".
  final selectedStatus = Rx<OrderStatus?>(null);

  /// The filtered list of orders after applying search + filter.
  final filteredOrders = RxList<OrderModel>([]);

  /// All orders loaded from [OrderConstants].
  late final List<OrderModel> allOrders;

  @override
  void onInit() {
    super.onInit();
    allOrders = OrderConstants.orders;
    filteredOrders.assignAll(allOrders);
  }

  /// Filters orders based on [query] and the currently selected [status].
  void filterOrders({String? query, OrderStatus? status}) {
    if (query != null) {
      searchQuery.value = query;
    }
    if (status != null || query == null) {
      // Only update status when explicitly passed
      if (status != null) {
        selectedStatus.value = status;
      }
    }

    final currentQuery = searchQuery.value.trim().toLowerCase();
    final currentStatus = selectedStatus.value;

    var results = allOrders;

    // Apply status filter
    if (currentStatus != null) {
      results = results.where((o) => o.status == currentStatus).toList();
    }

    // Apply search filter
    if (currentQuery.isNotEmpty) {
      results =
          results
              .where(
                (o) =>
                    o.orderId.toLowerCase().contains(currentQuery) ||
                    o.productName.toLowerCase().contains(currentQuery),
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
    filterOrders(status: status);
  }

  /// Navigate to the Order Details screen.
  void openOrderDetails(OrderModel order) {
    Get.toNamed(AppRoutes.orderDetails, arguments: order);
  }
}

