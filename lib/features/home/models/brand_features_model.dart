class BrandFeaturesResponse {
  final bool success;
  final BrandFeaturesModel? data;
  final String? message;

  const BrandFeaturesResponse({
    required this.success,
    this.data,
    this.message,
  });

  factory BrandFeaturesResponse.fromJson(Map<String, dynamic> json) {
    final dataJson = json['data'];

    return BrandFeaturesResponse(
      success: json['success'] == true,
      data: dataJson is Map<String, dynamic>
          ? BrandFeaturesModel.fromJson(dataJson)
          : null,
      message: json['message']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data?.toJson(),
      'message': message,
    };
  }
}

class BrandFeaturesModel {
  final String? id;
  final List<InfoModel> info;
  final List<FeatureCardModel> card1;
  final List<FeatureCardModel> card2;
  final List<FeatureCardModel> card3;
  final List<Card4Model> card4;

  const BrandFeaturesModel({
    this.id,
    this.info = const [],
    this.card1 = const [],
    this.card2 = const [],
    this.card3 = const [],
    this.card4 = const [],
  });

  factory BrandFeaturesModel.fromJson(Map<String, dynamic> json) {
    return BrandFeaturesModel(
      id: json['_id']?.toString(),
      info: _parseList<InfoModel>(json['info'], InfoModel.fromJson),
      card1: _parseList<FeatureCardModel>(json['card1'], FeatureCardModel.fromJson),
      card2: _parseList<FeatureCardModel>(json['card2'], FeatureCardModel.fromJson),
      card3: _parseList<FeatureCardModel>(json['card3'], FeatureCardModel.fromJson),
      card4: _parseList<Card4Model>(json['card4'], Card4Model.fromJson),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'info': info.map((item) => item.toJson()).toList(),
      'card1': card1.map((item) => item.toJson()).toList(),
      'card2': card2.map((item) => item.toJson()).toList(),
      'card3': card3.map((item) => item.toJson()).toList(),
      'card4': card4.map((item) => item.toJson()).toList(),
    };
  }

  static List<T> _parseList<T>(
    dynamic value,
    T Function(Map<String, dynamic>) parser,
  ) {
    if (value is List) {
      return value
          .whereType<Map<String, dynamic>>()
          .map(parser)
          .toList();
    }
    return <T>[];
  }
}

class InfoModel {
  final String? mainHeading;
  final String? para;

  const InfoModel({this.mainHeading, this.para});

  factory InfoModel.fromJson(Map<String, dynamic> json) {
    return InfoModel(
      mainHeading: json['mainHeading']?.toString(),
      para: json['para']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mainHeading': mainHeading,
      'para': para,
    };
  }
}

class FeatureCardModel {
  final String? title;
  final String? description;

  const FeatureCardModel({this.title, this.description});

  factory FeatureCardModel.fromJson(Map<String, dynamic> json) {
    return FeatureCardModel(
      title: json['title']?.toString(),
      description: json['description']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
    };
  }
}

class Card4Model {
  final String? title;
  final String? description;
  final List<String> bulletPoints;

  const Card4Model({
    this.title,
    this.description,
    this.bulletPoints = const [],
  });

  factory Card4Model.fromJson(Map<String, dynamic> json) {
    final bulletPoints = json['bulletPoints'];

    return Card4Model(
      title: json['title']?.toString(),
      description: json['description']?.toString(),
      bulletPoints: bulletPoints is List
          ? bulletPoints.whereType<String>().where((item) => item.isNotEmpty).toList()
          : const <String>[],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'bulletPoints': bulletPoints,
    };
  }
}
