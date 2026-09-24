class ApiEndpoints {
  ApiEndpoints._();

  static const String baseUrl = 'https://OGAGLOW-backend.wholcure.com/api';

  // Auth endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String forgotPassword = '/auth/forgot-password';
  static const String deleteAccount = '/auth/delete-account';

  // About Us endpoint
  static const String aboutUs = '/OGAGLOW/about-us';

  // Brand features endpoint
  static const String brandFeatures = '/OGAGLOW/brand/brand-features';

  // Products endpoints
  static const String products = '/OGAGLOW/products';
  static String productDetails(String id) => '/OGAGLOW/products/$id';

  // Checkout & Orders endpoints
  static const String checkoutPreview = '/OGAGLOW/orders/checkout/preview';
  static const String placeOrder = '/OGAGLOW/orders/placeOrder';
  static const String myOrders = '/OGAGLOW/orders/my-orders';

  // Customer Wishlist endpoints
  static const String customerWishlist = '/customers/me/wishlist';
  static const String toggleWishlist = '/customers/me/wishlist/toggle';
  static String removeWishlistItem(String productId) => '/customers/me/wishlist/item/$productId';
  static const String clearWishlist = '/customers/me/wishlist/clear';
}
