/// Data models for the About Us API response.
class AboutUsModel {
  final String? id;
  final AboutBannerModel? banner;
  final String? firstImage;
  final String? secondImage;
  final String? faqImage;
  final List<AboutFaqModel>? faq;
  final int? v;

  const AboutUsModel({
    this.id,
    this.banner,
    this.firstImage,
    this.secondImage,
    this.faqImage,
    this.faq,
    this.v,
  });

  factory AboutUsModel.fromJson(Map<String, dynamic> json) {
    return AboutUsModel(
      id: json['_id'] as String?,
      banner: json['banner'] != null && json['banner'] is Map<String, dynamic>
          ? AboutBannerModel.fromJson(json['banner'] as Map<String, dynamic>)
          : null,
      firstImage: json['firstImage'] as String?,
      secondImage: json['secondImage'] as String?,
      faqImage: json['FaqImage'] as String?,
      faq: json['FAQ'] != null && json['FAQ'] is List
          ? (json['FAQ'] as List)
              .whereType<Map<String, dynamic>>()
              .map((e) => AboutFaqModel.fromJson(e))
              .toList()
          : null,
      v: json['__v'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'banner': banner?.toJson(),
      'firstImage': firstImage,
      'secondImage': secondImage,
      'FaqImage': faqImage,
      'FAQ': faq?.map((e) => e.toJson()).toList(),
      '__v': v,
    };
  }
}

/// Inner model representing hero banner data.
class AboutBannerModel {
  final String? image;
  final String? paragraph;
  final String? card1;
  final String? card2;
  final String? card3;
  final String? leftButton;
  final String? rightButton;

  const AboutBannerModel({
    this.image,
    this.paragraph,
    this.card1,
    this.card2,
    this.card3,
    this.leftButton,
    this.rightButton,
  });

  factory AboutBannerModel.fromJson(Map<String, dynamic> json) {
    return AboutBannerModel(
      image: json['image'] as String?,
      paragraph: json['paragraph'] as String?,
      card1: json['card1'] as String?,
      card2: json['card2'] as String?,
      card3: json['card3'] as String?,
      leftButton: json['leftButton'] as String?,
      rightButton: json['rightButton'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'paragraph': paragraph,
      'card1': card1,
      'card2': card2,
      'card3': card3,
      'leftButton': leftButton,
      'rightButton': rightButton,
    };
  }
}

/// Inner model representing an FAQ item.
class AboutFaqModel {
  final String? id;
  final String? question;
  final String? answer;

  const AboutFaqModel({
    this.id,
    this.question,
    this.answer,
  });

  factory AboutFaqModel.fromJson(Map<String, dynamic> json) {
    return AboutFaqModel(
      id: json['_id'] as String?,
      question: json['question'] as String?,
      answer: json['answer'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'question': question,
      'answer': answer,
    };
  }
}
