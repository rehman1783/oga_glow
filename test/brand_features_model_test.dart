import 'package:flutter_test/flutter_test.dart';
import 'package:oga_glow/features/home/models/brand_features_model.dart';

void main() {
  group('BrandFeaturesModel', () {
    test('parses nested card4 bullet points from API payload', () {
      final payload = {
        '_id': 'abc123',
        'info': [
          {'mainHeading': 'Rooted in Ayurveda', 'para': 'A calm ritual'},
        ],
        'card1': [
          {'title': 'Traditional formulation', 'description': 'Ancient herbs'},
        ],
        'card2': [
          {'title': 'Organic leaf botanical', 'description': 'Plant extracts'},
        ],
        'card3': [
          {'title': 'Sustainability commitment', 'description': 'Less ink'},
        ],
        'card4': [
          {
            'title': 'A calm ritual',
            'description': 'Balance in life',
            'bulletPoints': ['One', 'Two', 'Three'],
          },
        ],
      };

      final model = BrandFeaturesModel.fromJson(payload);

      expect(model.info.first.mainHeading, 'Rooted in Ayurveda');
      expect(model.card1.first.title, 'Traditional formulation');
      expect(model.card4.first.bulletPoints, ['One', 'Two', 'Three']);
    });
  });
}
