abstract class AppRoutes {
  AppRoutes._();

  static const splash = '/';
  static const mainNavigation = '/main-navigation';
  static const home = '/home';
  static const category = '/category';
  static const wishlist = '/wishlist';
  static const cart = '/cart';
  static const profile = '/profile';

  /// All products screen (registered as separate route as requested).
  static const allProducts = '/all-products';

  static const products = '/products';
  static const products_details = '/products-details';

  // Auth
  static const auth = '/auth';
  static const login = '/login';
  static const signup = '/signup';
}
