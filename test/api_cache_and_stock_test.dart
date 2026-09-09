import 'package:flutter_test/flutter_test.dart';
import 'package:oga_glow/core/network/api_client.dart';
import 'package:oga_glow/data/models/product_model.dart';
import 'package:oga_glow/data/repositories/product_repository.dart';

void main() {
  group('Product Stock & Out-of-Stock Tests', () {
    test('ProductModel correctly computes isInStock and isOutOfStock', () {
      final inStockProduct = ProductModel(
        id: 'prod_1',
        name: 'Glow Face Serum',
        price: 1500,
        finalPrice: 1200,
        images: [ProductImageModel(id: 'img1', publicId: 'pid1', url: 'https://example.com/serum.jpg')],
        category: 'skin-care',
        countInStock: 5,
      );

      expect(inStockProduct.isInStock, isTrue);
      expect(inStockProduct.isOutOfStock, isFalse);

      final outOfStockProduct = ProductModel(
        id: 'prod_2',
        name: 'Botanical Night Cream',
        price: 2000,
        finalPrice: 2000,
        images: [ProductImageModel(id: 'img2', publicId: 'pid2', url: 'https://example.com/cream.jpg')],
        category: 'skin-care',
        countInStock: 0,
      );

      expect(outOfStockProduct.isInStock, isFalse);
      expect(outOfStockProduct.isOutOfStock, isTrue);
    });

    test('ProductModel parses countInStock from json properly', () {
      final json = {
        'id': 'test_json_1',
        'name': 'Kumkumadi Oil',
        'price': 3500,
        'finalPrice': 3000,
        'countInStock': 0,
        'category': 'skin-care',
        'images': [],
      };

      final model = ProductModel.fromJson(json);
      expect(model.countInStock, equals(0));
      expect(model.isOutOfStock, isTrue);
      expect(model.isInStock, isFalse);
    });
  });

  group('ProductRepository In-Memory Cache Tests', () {
    setUp(() {
      ProductRepository.clearProductCache();
    });

    test('findCachedProduct returns null when cache is empty', () {
      expect(ProductRepository.findCachedProduct('non_existent'), isNull);
    });

    test('clearProductCache clears in-memory product cache', () {
      ProductRepository.clearProductCache();
      expect(ProductRepository.findCachedProduct('any_id'), isNull);
    });
  });

  group('ApiClient Caching & Cache Invalidation Tests', () {
    test('ApiClient clearCache does not throw and clears cleanly', () {
      final client = ApiClient();
      expect(() => client.clearCache(), returnsNormally);
      expect(() => client.clearCache('/ogaglow/products'), returnsNormally);
    });
  });
}
