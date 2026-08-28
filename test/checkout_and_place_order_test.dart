import 'package:flutter_test/flutter_test.dart';
import 'package:oga_glow/features/checkout/models/checkout_preview_model.dart';
import 'package:oga_glow/features/checkout/models/place_order_model.dart';

void main() {
  group('Checkout Preview & Place Order Model Tests', () {
    test('CheckoutPreviewResponse parses sample backend JSON correctly', () {
      final sampleJson = {
        "success": true,
        "items": [
          {
            "product": "6a0d5da172241d4c9fafe20c",
            "name": "Hair Oil",
            "image": null,
            "quantity": 2,
            "price": 1320,
            "originalPrice": 2200,
            "shippingPrice": 250,
            "discountAmount": 1760,
            "subtotal": 2640,
            "discount": {
              "type": "percentage",
              "value": 40
            }
          }
        ],
        "priceBreakdown": {
          "itemsPrice": 2640,
          "productDiscount": 1760,
          "shippingPrice": 250,
          "discountAmount": 0,
          "couponDiscount": 0,
          "appliedCouponCode": null,
          "totalPrice": 2890
        },
        "coupon": null,
        "couponError": null
      };

      final response = CheckoutPreviewResponse.fromJson(sampleJson);

      expect(response.success, true);
      expect(response.items.length, 1);
      expect(response.items.first.name, 'Hair Oil');
      expect(response.items.first.quantity, 2);
      expect(response.items.first.price, 1320);
      expect(response.items.first.subtotal, 2640);
      expect(response.priceBreakdown.itemsPrice, 2640);
      expect(response.priceBreakdown.productDiscount, 1760);
      expect(response.priceBreakdown.shippingPrice, 250);
      expect(response.priceBreakdown.totalPrice, 2890);
      expect(response.couponError, isNull);
    });

    test('CheckoutPreviewResponse handles coupon error properly', () {
      final sampleJson = {
        "success": true,
        "items": [],
        "priceBreakdown": {
          "itemsPrice": 2380,
          "productDiscount": 1020,
          "shippingPrice": 250,
          "discountAmount": 0,
          "couponDiscount": 0,
          "appliedCouponCode": null,
          "totalPrice": 2630
        },
        "coupon": null,
        "couponError": "No coupon code matched"
      };

      final response = CheckoutPreviewResponse.fromJson(sampleJson);

      expect(response.couponError, 'No coupon code matched');
      expect(response.priceBreakdown.totalPrice, 2630);
    });

    test('PlaceOrderRequest serializes to exact expected JSON payload', () {
      final request = PlaceOrderRequest(
        userId: 'user_123',
        customer: CustomerInput(
          email: 'mahnnooranwar191@gmail.com',
          phone: '+9233503123560',
        ),
        orderItems: [
          {
            "product": "6a0d5da172241d4c9fafe20c",
            "quantity": 2,
          }
        ],
        shippingAddress: ShippingAddressInput(
          phoneNumber: '+9233503123560',
          province: 'Khyber Pakhtunkhwa',
          city: 'Chitral',
          area: 'malir',
          fullAddress: 'ce11 malir karachu',
          landmark: 'mega Mall',
          deliveryInstructions: 'Call before delivery',
        ),
        paymentMethod: 'COD',
        couponCode: 'SUMMER40',
        notes: 'Please pack carefully',
        saveToAddressBook: true,
      );

      final json = request.toJson();

      expect(json['userId'], 'user_123');
      expect(json['customer']['email'], 'mahnnooranwar191@gmail.com');
      expect(json['customer']['phone'], '+9233503123560');
      expect(json['orderItems'].length, 1);
      expect(json['shippingAddress']['province'], 'Khyber Pakhtunkhwa');
      expect(json['shippingAddress']['city'], 'Chitral');
      expect(json['shippingAddress']['landmark'], 'mega Mall');
      expect(json['paymentMethod'], 'COD');
      expect(json['couponCode'], 'SUMMER40');
      expect(json['saveToAddressBook'], true);
    });

    test('PlaceOrderResponse parses backend response with Leopards tracking', () {
      final sampleResponseJson = {
        "success": true,
        "message": "Order placed successfully",
        "order": {
          "_id": "6a887c933aad01f4f71c4d83",
          "user": null,
          "customer": {
            "email": "mahnnooranwar191@gmail.com",
            "phone": "+9233503123560"
          },
          "orderItems": [
            {
              "product": "6a0d5da172241d4c9fafe20c",
              "name": "Hair Oil",
              "quantity": 2,
              "price": 1320,
              "originalPrice": 2200,
              "discountAmount": 1760,
              "shippingPrice": 250,
              "taxRate": 0,
              "subtotal": 2640
            }
          ],
          "shippingAddress": {
            "phoneNumber": "+9233503123560",
            "province": "Khyber Pakhtunkhwa",
            "city": "Chitral",
            "area": "malir",
            "fullAddress": "ce11 malir karachu",
            "lat": null,
            "lon": null,
            "landmark": "mega Mall",
            "deliveryInstructions": ""
          },
          "paymentMethod": "COD",
          "paymentStatus": "pending",
          "transactionId": null,
          "paymentDetails": null,
          "orderStatus": "pending",
          "itemsPrice": 2640,
          "shippingPrice": 250,
          "taxPrice": 0,
          "discountAmount": 0,
          "totalPrice": 2890,
          "paidAt": null,
          "notes": "",
          "coupon": null,
          "courierName": "Leopards Courier",
          "trackingNumber": "LEO123456789",
          "createdAt": "2026-08-21T16:28:03.754Z",
          "updatedAt": "2026-08-21T16:28:03.754Z"
        },
        "coupon": null,
        "totalPrice": 2890
      };

      final response = PlaceOrderResponse.fromJson(sampleResponseJson);

      expect(response.success, true);
      expect(response.order, isNotNull);
      expect(response.order!.id, '6a887c933aad01f4f71c4d83');
      expect(response.order!.courierName, 'Leopards Courier');
      expect(response.order!.trackingNumber, 'LEO123456789');
      expect(response.order!.totalPrice, 2890);
      expect(response.order!.itemsPrice, 2640);
      expect(response.order!.shippingPrice, 250);
      expect(response.order!.paymentMethod, 'COD');
    });
  });
}
