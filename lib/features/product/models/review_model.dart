class ReviewModel {
  final String id;
  final String name;
  final String email;
  final int rating;
  final String review;
  final String? productId;
  final String? profileImage;
  final String? createdAt;
  final String? updatedAt;

  ReviewModel({
    this.id = '',
    this.name = '',
    this.email = '',
    this.rating = 0,
    this.review = '',
    this.productId,
    this.profileImage,
    this.createdAt,
    this.updatedAt,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['_id']?.toString() ?? json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      rating: _parseRating(json['rating']),
      review: json['review']?.toString() ?? json['comment']?.toString() ?? '',
      productId:
          json['productId']?.toString() ?? json['product_id']?.toString(),
      profileImage:
          json['profileImage']?.toString() ?? json['avatar']?.toString(),
      createdAt: json['createdAt']?.toString() ?? json['date']?.toString(),
      updatedAt: json['updatedAt']?.toString(),
    );
  }

  static int _parseRating(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'rating': rating,
      'review': review,
      'productId': productId,
      'profileImage': profileImage,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
