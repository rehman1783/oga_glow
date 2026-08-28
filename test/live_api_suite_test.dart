import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:oga_glow/data/models/product_model.dart';
import 'package:oga_glow/features/about/models/about_us_model.dart';
import 'package:oga_glow/features/about/models/fake_review_model.dart';
import 'package:oga_glow/features/checkout/models/checkout_preview_model.dart';
import 'package:oga_glow/features/checkout/models/place_order_model.dart';

void main() {
  const baseUrl = 'https://ogaglow-apis.vercel.app/api';
  final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  String? sampleProductId;

  group('OGA Glow - Live Backend API Integration Suite', () {
    test('1. GET /ogaglow/products returns products list and parses correctly', () async {
      final res = await dio.get('/ogaglow/products');
      expect(res.statusCode, 200);
      expect(res.data, isA<Map<String, dynamic>>());
      final listData = res.data['data'] as List;
      expect(listData.isNotEmpty, true);

      final products = listData
          .map((item) => ProductModel.fromJson(item as Map<String, dynamic>))
          .toList();

      expect(products.isNotEmpty, true);
      sampleProductId = products.first.id;
      expect(sampleProductId, isNotEmpty);
      expect(products.first.name, isNotEmpty);
    });

    test('2. GET /ogaglow/products/:id returns specific product details', () async {
      expect(sampleProductId, isNotNull);
      final res = await dio.get('/ogaglow/products/$sampleProductId');
      expect(res.statusCode, 200);
      final pData = res.data['data'] ?? res.data;
      final product = ProductModel.fromJson(pData as Map<String, dynamic>);
      expect(product.id, sampleProductId);
      expect(product.name, isNotEmpty);
      expect(product.price, greaterThan(0));
    });

    test('3. GET /ogaglow/brand/brand-features returns valid brand data', () async {
      final res = await dio.get('/ogaglow/brand/brand-features');
      expect(res.statusCode, 200);
      expect(res.data['success'], true);
      expect(res.data['data'], isNotNull);
    });

    test('4. GET /ogaglow/about-us returns valid about us model', () async {
      final res = await dio.get('/ogaglow/about-us');
      expect(res.statusCode, 200);
      expect(res.data, isA<Map<String, dynamic>>());
      final aboutModel = AboutUsModel.fromJson(res.data as Map<String, dynamic>);
      expect(aboutModel.id, isNotNull);
      expect(aboutModel.banner, isNotNull);
    });

    test('5. GET /ogaglow/fake-reviews/getAllFakeReviews returns fake reviews', () async {
      final res = await dio.get('/ogaglow/fake-reviews/getAllFakeReviews');
      expect(res.statusCode, 200);
      expect(res.data, isA<Map<String, dynamic>>());
      final response = FakeReviewResponse.fromJson(res.data as Map<String, dynamic>);
      expect(response.reviews, isA<List>());
    });

    test('6. POST /ogaglow/orders/checkout/preview calculates price breakdown', () async {
      expect(sampleProductId, isNotNull);
      final payload = {
        'orderItems': [
          {'product': sampleProductId, 'quantity': 2}
        ],
        'items': [
          {'product': sampleProductId, 'quantity': 2}
        ],
        'couponCode': null,
      };
      final res = await dio.post('/ogaglow/orders/checkout/preview', data: payload);
      expect(res.statusCode, 200);
      final preview = CheckoutPreviewResponse.fromJson(res.data as Map<String, dynamic>);
      expect(preview.success, true);
      expect(preview.priceBreakdown.itemsPrice, greaterThan(0));
      expect(preview.priceBreakdown.totalPrice, greaterThan(0));
    });

    test('7. POST /ogaglow/orders/checkout/preview handles invalid coupon gracefully', () async {
      expect(sampleProductId, isNotNull);
      final payload = {
        'orderItems': [
          {'product': sampleProductId, 'quantity': 1}
        ],
        'items': [
          {'product': sampleProductId, 'quantity': 1}
        ],
        'couponCode': 'INVALID_PROMO_CODE_XYZ',
      };
      final res = await dio.post('/ogaglow/orders/checkout/preview', data: payload);
      expect(res.statusCode, 200);
      final preview = CheckoutPreviewResponse.fromJson(res.data as Map<String, dynamic>);
      expect(preview.couponError, isNotEmpty);
      expect(preview.priceBreakdown.couponDiscount, 0.0);
    });

    test('8. POST /ogaglow/orders/placeOrder places a COD order successfully', () async {
      expect(sampleProductId, isNotNull);
      final request = PlaceOrderRequest(
        userId: null,
        customer: CustomerInput(
          email: 'automated.verify@ogaglow.com',
          phone: '+923001234567',
        ),
        orderItems: [
          {'product': sampleProductId, 'quantity': 1}
        ],
        shippingAddress: ShippingAddressInput(
          phoneNumber: '+923001234567',
          province: 'Punjab',
          city: 'Lahore',
          area: 'Gulberg III',
          fullAddress: 'Main Boulevard, Suite 101',
          landmark: 'Near Liberty Market',
          deliveryInstructions: 'Fragile herbal cosmetics',
        ),
        paymentMethod: 'COD',
        couponCode: null,
        notes: 'Automated API Verification Test',
        saveToAddressBook: false,
      );

      final res = await dio.post('/ogaglow/orders/placeOrder', data: request.toJson());
      expect(res.statusCode == 200 || res.statusCode == 201, true);
      final placeOrderRes = PlaceOrderResponse.fromJson(res.data as Map<String, dynamic>);
      expect(placeOrderRes.success, true);
      expect(placeOrderRes.order, isNotNull);
      expect(placeOrderRes.order!.id, isNotEmpty);
      expect(placeOrderRes.order!.courierName, isNotNull);
      expect(placeOrderRes.order!.totalPrice, greaterThan(0));
    });

    test('9. POST /auth/login returns structured 401 response for invalid credentials', () async {
      try {
        await dio.post(
          '/auth/login',
          data: {'email': 'non_existent_user@ogaglow.com', 'password': 'WrongPassword123'},
        );
        fail('Expected DioException with 401 status');
      } on DioException catch (e) {
        expect(e.response?.statusCode, 401);
        expect(e.response?.data['success'], false);
        expect(e.response?.data['message'], isNotEmpty);
      }
    });
  });
}
