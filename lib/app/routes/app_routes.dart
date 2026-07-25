abstract class AppRoutes {
  AppRoutes._();

  static const splash = '/';
  static const mainNavigation = '/main-navigation';
  static const home = '/home';
  static const category = '/category';
  static const wishlist = '/wishlist';
  static const cart = '/cart';
  static const checkout = '/checkout';
  static const profile = '/profile';

  /// All products screen (registered as separate route as requested).
  static const allProducts = '/all-products';

  static const products = '/products';
  // ignore: constant_identifier_names
  static const products_details = '/products-details';
  static const productsDetails = '/products-details';

  // Auth
  static const auth = '/auth';
  static const entry = '/entry';
  static const login = '/login';
  static const signup = '/signup';
  static const forgotPassword = '/forgot-password';
  static const verification = '/verification';

  // Contact
  static const contact = '/contact';

  // About
  static const about = '/about';

  // Legal & Compliance
  static const legal = '/legal';
  static const termsOfService = '/legal/terms-of-service';
  static const privacyPolicy = '/legal/privacy-policy';
  static const returnRefundPolicy = '/legal/return-refund-policy';

  // FAQ
  static const faq = '/faq';

  // Orders
  static const orderHistory = '/orders';
  static const orderDetails = '/orders/details';
}
