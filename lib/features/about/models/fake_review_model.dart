class FakeReview {
  final String id;
  final String name;
  final String email;
  final String comment;
  final String? image;
  final DateTime createdAt;

  FakeReview({
    required this.id,
    required this.name,
    required this.email,
    required this.comment,
    required this.image,
    required this.createdAt,
  });

  factory FakeReview.fromJson(Map<String, dynamic> json) {
    return FakeReview(
      id: json['_id']?.toString() ?? json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      comment: json['comment']?.toString() ?? '',
      image: json['image']?.toString(),
      createdAt: _parseDateTime(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'comment': comment,
      'image': image,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  static DateTime _parseDateTime(dynamic value) {
    if (value is DateTime) return value;
    if (value is String && value.isNotEmpty) {
      return DateTime.tryParse(value) ?? DateTime.now();
    }
    return DateTime.now();
  }
}

class FakeReviewResponse {
  final bool success;
  final List<FakeReview> reviews;

  FakeReviewResponse({required this.success, required this.reviews});

  factory FakeReviewResponse.fromJson(Map<String, dynamic> json) {
    final reviewsJson = json['reviews'] is List
        ? json['reviews'] as List
        : <dynamic>[];
    return FakeReviewResponse(
      success: json['success'] == true,
      reviews: reviewsJson
          .whereType<Map<String, dynamic>>()
          .map(FakeReview.fromJson)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'reviews': reviews.map((review) => review.toJson()).toList(),
    };
  }
}
