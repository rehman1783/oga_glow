import 'package:flutter_test/flutter_test.dart';
import 'package:oga_glow/features/contact/models/contact_info_model.dart';
import 'package:oga_glow/features/product/models/review_model.dart';

void main() {
  group('API model parsing', () {
    test('ReviewModel parses a review payload', () {
      final review = ReviewModel.fromJson({
        'name': 'Ayesha',
        'rating': 5,
        'review': 'Loved the glow.',
        'date': '2026-07-27T10:00:00.000Z',
        'profileImage': 'https://example.com/a.png',
      });

      expect(review.name, 'Ayesha');
      expect(review.rating, 5);
      expect(review.review, 'Loved the glow.');
      expect(review.profileImage, 'https://example.com/a.png');
    });

    test('ContactInfoModel parses office and contact details', () {
      final contact = ContactInfoModel.fromJson({
        'headOffice': {'city': 'Lahore', 'address': 'Mall Road'},
        'subOffices': [
          {'city': 'Karachi', 'address': 'Dolmen Mall'},
          {'city': 'Islamabad', 'address': 'Blue Area'},
        ],
        'emails': ['sales@ogaglow.com', 'support@ogaglow.com'],
        'phoneNumbers': ['+92-300-1234567'],
      });

      expect(contact.headOffice?.city, 'Lahore');
      expect(contact.subOffices.length, 2);
      expect(contact.emails, contains('support@ogaglow.com'));
      expect(contact.phoneNumbers, contains('+92-300-1234567'));
    });
  });
}
