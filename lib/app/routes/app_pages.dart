import 'package:get/get.dart';
import 'package:oga_glow/features/auth/bindings/auth_entry_binding.dart';

import 'package:oga_glow/features/category/bindings/category_binding.dart';
import 'package:oga_glow/features/category/views/category_screen.dart';

import 'package:oga_glow/features/home/bindings/home_binding.dart';
import 'package:oga_glow/features/home/views/home_screen.dart';

import 'package:oga_glow/features/main_navigation/bindings/main_navigation_binding.dart';
import 'package:oga_glow/features/main_navigation/views/main_navigation_screen.dart';
import 'package:oga_glow/features/product/bindings/product_binding.dart';
import 'package:oga_glow/features/product/views/product_screen.dart';
import 'package:oga_glow/features/auth/bindings/login_binding.dart';
import 'package:oga_glow/features/auth/bindings/signup_binding.dart';
import 'package:oga_glow/features/auth/bindings/forgot_password_binding.dart';
import 'package:oga_glow/features/auth/views/login_screen.dart';
import 'package:oga_glow/features/auth/views/signup_screen.dart';
import 'package:oga_glow/features/auth/views/forgot_password_screen.dart';
import 'package:oga_glow/features/auth/views/verification_screen.dart';

import '../../features/splash/bindings/splash_binding.dart';
import '../../features/splash/views/splash_screen.dart';

import '../../features/wishlist/bindings/wishlist_binding.dart';
import '../../features/wishlist/views/wishlist_screen.dart';

import '../../features/profile/views/profile_screen.dart';
import '../../features/cart/views/cart_screen.dart';
import '../../features/cart/bindings/cart_binding.dart';

import 'app_routes.dart';
import '../../features/auth/views/auth_entry_screen.dart';
import '../../features/checkout/views/checkout_screen.dart';
import '../../features/checkout/bindings/checkout_binding.dart';
import '../../features/contact/views/contact_screen.dart';
import '../../features/contact/bindings/contact_binding.dart';
import '../../features/about/views/about_screen.dart';
import '../../features/about/bindings/about_binding.dart';
import '../../features/legal/views/legal_screen.dart';
import '../../features/legal/views/terms_of_service_screen.dart';
import '../../features/legal/views/privacy_policy_screen.dart';
import '../../features/legal/views/return_refund_policy_screen.dart';
import '../../features/legal/bindings/legal_binding.dart';
import '../../features/faq/views/faq_screen.dart';
import '../../features/faq/bindings/faq_binding.dart';
import '../../features/orders/views/order_history_screen.dart';
import '../../features/orders/views/order_details_screen.dart';
import '../../features/orders/bindings/order_binding.dart';

class AppPages {
  AppPages._();

  static final pages = <GetPage>[
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(name: AppRoutes.auth, page: () => const AuthEntryScreen()),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.mainNavigation,
      page: () => const MainNavigationScreen(),
      binding: MainNavigationBinding(),
    ),
    // GetPage(
    //   name: AppRoutes.category,
    //   page: () => const CategoryScreen(),
    //   binding: CategoryBinding(),
    // ),
    GetPage(
      name: AppRoutes.checkout,
      page: () => const CheckoutScreen(),
      binding: CheckoutBinding(),
    ),

    GetPage(
      name: AppRoutes.allProducts,
      page: () => const CategoryScreen(),
      binding: CategoryBinding(),
      arguments: 'All',
    ),

    // GetPage(
    //   name: AppRoutes.products,
    //   page: () => const ProductScreen(),
    //   binding: ProductBinding(),
    // ),
    GetPage(
      name: AppRoutes.products_details,
      page: () => const ProductScreen(),
      binding: ProductBinding(),
    ),
    // GetPage(
    //   name: AppRoutes.wishlist,
    //   page: () => WishlistScreen(),
    //   binding: WishlistBinding(),
    // ),
    // GetPage(
    //   name: AppRoutes.cart,
    //   page: () => CartScreen(),
    //   binding: CartBinding(),
    // ),
    GetPage(name: AppRoutes.profile, page: () => const ProfileScreen()),

    // Auth routes
    GetPage(
      name: AppRoutes.entry,
      page: () => const AuthEntryScreen(),
      binding: AuthEntryBinding(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.signup,
      page: () => const SignupScreen(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: AppRoutes.forgotPassword,
      page: () => const ForgotPasswordScreen(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: AppRoutes.verification,
      page: () => const VerificationScreen(),
    ),

    // Contact
    GetPage(
      name: AppRoutes.contact,
      page: () => const ContactScreen(),
      binding: ContactBinding(),
    ),

    // About
    GetPage(
      name: AppRoutes.about,
      page: () => const AboutScreen(),
      binding: AboutBinding(),
    ),

    // Legal & Compliance
    GetPage(
      name: AppRoutes.legal,
      page: () => const LegalScreen(),
      binding: LegalBinding(),
    ),
    GetPage(
      name: AppRoutes.termsOfService,
      page: () => const TermsOfServiceScreen(),
    ),
    GetPage(
      name: AppRoutes.privacyPolicy,
      page: () => const PrivacyPolicyScreen(),
    ),
    GetPage(
      name: AppRoutes.returnRefundPolicy,
      page: () => const ReturnRefundPolicyScreen(),
    ),

    // FAQ
    GetPage(
      name: AppRoutes.faq,
      page: () => const FaqScreen(),
      binding: FaqBinding(),
    ),

    // Orders
    GetPage(
      name: AppRoutes.orderHistory,
      page: () => const OrderHistoryScreen(),
      binding: OrderBinding(),
    ),
    GetPage(
      name: AppRoutes.orderDetails,
      page: () => const OrderDetailsScreen(),
    ),
  ];
}
