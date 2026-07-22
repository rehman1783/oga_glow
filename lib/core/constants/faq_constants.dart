import 'faq_models.dart';
export 'faq_models.dart';

/// Central repository for all FAQ page static data.
///
/// Keep all FAQ information here instead of hardcoding inside widgets.
class FaqConstants {
  FaqConstants._();

  // ---------------------------------------------------------------------------
  // Page Headers
  // ---------------------------------------------------------------------------
  static const String pageTitle = 'FAQ';
  static const String pageSubtitle = 'Frequently Asked Questions';
  static const String pageIntroduction =
      'Find quick answers to common questions about our products, shipping, '
      'returns, and more. Save time by browsing our FAQ before contacting support.';

  // ---------------------------------------------------------------------------
  // Search
  // ---------------------------------------------------------------------------
  static const String searchHint = 'Search FAQ...';
  static const String noResultsTitle = 'No FAQs Found';
  static const String noResultsSubtitle =
      'We couldn\'t find any FAQs matching your search. Try using different '
      'keywords or browse the categories below.';

  // ---------------------------------------------------------------------------
  // FAQ Data
  // ---------------------------------------------------------------------------

  /// Returns the full list of FAQ categories with questions.
  static List<FaqCategory> get categories => _buildCategories();

  /// Builds the complete FAQ data set.
  static List<FaqCategory> _buildCategories() {
    return [
      // =========================================================================
      // 1. Shipping & Delivery
      // =========================================================================
      FaqCategory(
        title: 'Shipping & Delivery',
        icon: 'local_shipping',
        questions: [
          const FaqQuestion(
            question: 'How long does shipping take?',
            answer:
                'Standard shipping within Pakistan typically takes **3–7 business days** '
                'depending on your location. For international orders, delivery usually '
                'takes **7–14 business days**. Express shipping options are available at '
                'checkout for faster delivery.',
          ),
          const FaqQuestion(
            question: 'Do you offer international shipping?',
            answer:
                'Yes, we ship to selected international destinations. International shipping '
                'rates and times vary based on the destination country. You can view the '
                'available shipping options and costs at checkout before placing your order.',
          ),
          const FaqQuestion(
            question: 'How can I track my order?',
            answer:
                'Once your order is shipped, you will receive a confirmation email with a '
                'tracking number and a link to track your package. You can also track your '
                'order anytime by logging into your account and visiting the "My Orders" section.',
          ),
          const FaqQuestion(
            question: 'What is the shipping cost?',
            answer:
                'Shipping costs are calculated based on your location, order weight, and '
                'the shipping method selected at checkout. We offer **free shipping** on '
                'orders above a certain amount — check our current promotions for details.',
          ),
          const FaqQuestion(
            question: 'Do you ship to P.O. boxes?',
            answer:
                'Unfortunately, we do not ship to P.O. boxes at this time. Please provide '
                'a physical street address for delivery to ensure your package arrives safely.',
          ),
        ],
      ),

      // =========================================================================
      // 2. Returns & Refunds
      // =========================================================================
      FaqCategory(
        title: 'Returns & Refunds',
        icon: 'autorenew',
        questions: [
          const FaqQuestion(
            question: 'What is your return window?',
            answer:
                'You have **14 calendar days** from the date of delivery to request a return. '
                'Items must be received by our warehouse within 7 days after the return request '
                'is approved. Requests made after the 14-day window will not be accepted unless '
                'the item is defective or damaged.',
          ),
          const FaqQuestion(
            question: 'How do I request a refund?',
            answer:
                'To request a refund, log in to your account and navigate to "My Orders". '
                'Select the order you wish to return and click "Request Return". Follow the '
                'on-screen instructions to submit your request. Our team will review and '
                'notify you within 2–3 business days.',
          ),
          const FaqQuestion(
            question: 'Who pays for return shipping?',
            answer:
                'The customer is responsible for return shipping costs unless the item is '
                'defective, damaged, or incorrect. We recommend using a trackable shipping '
                'service, as we cannot guarantee receipt of returned items. Original shipping '
                'charges are non-refundable unless the return is due to our error.',
          ),
          const FaqQuestion(
            question: 'How long does it take to receive my refund?',
            answer:
                'Once we receive and inspect the returned item, your refund will be processed '
                'within **5–7 business days**. The refund will be issued to your original '
                'payment method. Depending on your bank or card issuer, it may take additional '
                'time for the funds to appear in your account.',
          ),
          const FaqQuestion(
            question: 'Can I exchange an item instead of returning it?',
            answer:
                'Currently, we do not offer direct exchanges. If you wish to exchange an item, '
                'please initiate a return for the unwanted product and place a new order for '
                'the desired item. This ensures faster processing for you.',
          ),
        ],
      ),

      // =========================================================================
      // 3. Orders & Payments
      // =========================================================================
      FaqCategory(
        title: 'Orders & Payments',
        icon: 'payments',
        questions: [
          const FaqQuestion(
            question: 'Which payment methods are accepted?',
            answer:
                'We accept a variety of payment methods including **credit/debit cards** '
                '(Visa, Mastercard), **bank transfers**, **JazzCash**, **Easypaisa**, and '
                '**cash on delivery (COD)** for select locations. All payment transactions '
                'are processed securely through encrypted gateways.',
          ),
          const FaqQuestion(
            question: 'Can I cancel my order?',
            answer:
                'You can cancel your order within **24 hours** of placing it, as long as it '
                'has not yet been shipped. To cancel, log in to your account, go to "My Orders", '
                'and click "Cancel Order". If the order has already been shipped, please refer '
                'to our return policy.',
          ),
          const FaqQuestion(
            question: 'When will my payment be charged?',
            answer:
                'Your payment method will be charged at the time of order confirmation. For '
                'cash on delivery (COD) orders, payment is collected at the time of delivery. '
                'Prepaid orders are charged immediately upon successful placement.',
          ),
          const FaqQuestion(
            question: 'Can I change my order after placing it?',
            answer:
                'Once an order is placed, modifications cannot be made. If you need to change '
                'the shipping address, items, or quantities, please cancel the order within '
                '24 hours (if not yet shipped) and place a new order with the correct details.',
          ),
          const FaqQuestion(
            question: 'Is my payment information secure?',
            answer:
                'Absolutely. We use industry-standard **SSL encryption** to protect your '
                'payment information. We do not store full credit card details on our servers. '
                'All payments are processed through trusted third-party payment gateways with '
                'the highest security standards.',
          ),
        ],
      ),

      // =========================================================================
      // 4. Product Care
      // =========================================================================
      FaqCategory(
        title: 'Product Care',
        icon: 'spa',
        questions: [
          const FaqQuestion(
            question: 'How should I store skincare products?',
            answer:
                'To maintain product efficacy, store your skincare products in a **cool, dry '
                'place** away from direct sunlight and humidity. Avoid storing them in the '
                'bathroom where temperature and moisture levels fluctuate. Always ensure the '
                'lid is tightly closed after use.',
          ),
          const FaqQuestion(
            question: 'How long do products last after opening?',
            answer:
                'Each product has a **Period After Opening (PAO)** symbol on its packaging, '
                'indicating how many months it remains effective after opening (e.g., 6M, 12M). '
                'Generally, most skincare products last **6–12 months** after opening. Always '
                'check the PAO symbol and discard products past their expiry.',
          ),
          const FaqQuestion(
            question: 'Are your products suitable for sensitive skin?',
            answer:
                'Many of our products are formulated to be gentle and suitable for sensitive '
                'skin. However, we always recommend performing a **patch test** on a small area '
                'of skin before full application. Each product listing includes detailed '
                'ingredient information to help you make an informed choice.',
          ),
          const FaqQuestion(
            question: 'Are your products tested on animals?',
            answer:
                'We are committed to cruelty-free practices. None of our products are tested '
                'on animals. We work with suppliers and brands that share our ethical values '
                'and adhere to strict cruelty-free standards.',
          ),
          const FaqQuestion(
            question: 'Do your products contain parabens or sulfates?',
            answer:
                'Our product formulations vary by brand and type. Many of our products are '
                '**paraben-free** and **sulfate-free**, but we encourage you to check the '
                'ingredient list on each product page for specific details. We clearly label '
                'key product attributes to help you shop with confidence.',
          ),
        ],
      ),

      // =========================================================================
      // 5. Account & Login
      // =========================================================================
      FaqCategory(
        title: 'Account & Login',
        icon: 'person',
        questions: [
          const FaqQuestion(
            question: 'How do I reset my password?',
            answer:
                'To reset your password, go to the login page and tap **"Forgot Password?"**. '
                'Enter your registered email address, and we will send you a password reset '
                'link. Follow the instructions in the email to create a new password. If you '
                'don\'t receive the email, please check your spam folder.',
          ),
          const FaqQuestion(
            question: 'How do I update my profile?',
            answer:
                'Log in to your account and navigate to **"My Profile"** from the menu. '
                'From there, you can update your name, email address, phone number, and '
                'shipping addresses. Remember to save your changes before leaving the page.',
          ),
          const FaqQuestion(
            question: 'Can I have multiple shipping addresses?',
            answer:
                'Yes, you can save multiple shipping addresses in your account. Go to "My '
                'Profile" and select "Addresses" to add, edit, or remove your saved addresses. '
                'You can choose any saved address during checkout.',
          ),
          const FaqQuestion(
            question: 'How do I delete my account?',
            answer:
                'If you wish to delete your account, please contact our customer support team '
                'at **support@ogaglow.com** with your account details. We will process your '
                'request within 5–7 business days. Please note that account deletion is '
                'permanent and cannot be undone.',
          ),
        ],
      ),

      // =========================================================================
      // 6. General Questions
      // =========================================================================
      FaqCategory(
        title: 'General Questions',
        icon: 'help_outline',
        questions: [
          const FaqQuestion(
            question: 'How do I contact support?',
            answer:
                'You can reach our customer support team through multiple channels:\n\n'
                '• **Email:** support@ogaglow.com\n'
                '• **Phone:** +92 321 3270507\n'
                '• **WhatsApp:** +92 321 3270507\n'
                '• **Live Chat:** Available on our website\n\n'
                'Our support team is available Monday to Saturday, 9:00 AM to 6:00 PM (PKT).',
          ),
          const FaqQuestion(
            question: 'Where are you located?',
            answer:
                'Our head office is located in **Karachi, Sindh, Pakistan**. We also have a '
                'sub-office in Hyderabad, Sindh. While our physical stores are currently '
                'limited to select locations, we deliver nationwide and to select international '
                'destinations.',
          ),
          const FaqQuestion(
            question: 'How can I report an issue?',
            answer:
                'If you encounter any issues with your order, product, or account, please '
                'contact our support team immediately. You can also report issues through '
                'your account under **"My Orders"** by selecting the relevant order and '
                'choosing "Report an Issue". We strive to resolve all issues within 48 hours.',
          ),
          const FaqQuestion(
            question: 'Do you offer promotional discounts?',
            answer:
                'Yes! We regularly run promotions, seasonal sales, and special discounts. '
                'To stay updated, subscribe to our newsletter, follow us on social media, '
                'and keep an eye on our website\'s "Offers" section. You can also earn '
                'rewards through our loyalty program.',
          ),
          const FaqQuestion(
            question: 'Can I leave a product review?',
            answer:
                'Absolutely! We encourage customers to share their honest feedback. To leave '
                'a review, go to "My Orders", select the purchased product, and click '
                '"Write a Review". Your reviews help other customers make informed decisions '
                'and help us improve our products and services.',
          ),
        ],
      ),
    ];
  }
}

