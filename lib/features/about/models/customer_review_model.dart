class CustomerReview {
  final String id;
  final String name;
  final String email;
  final String comment;
  final String? image;
  final DateTime createdAt;

  CustomerReview({
    required this.id,
    required this.name,
    required this.email,
    required this.comment,
    required this.image,
    required this.createdAt,
  });

  factory CustomerReview.fromJson(Map<String, dynamic> json) {
    return CustomerReview(
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

class CustomerReviewResponse {
  final bool success;
  final List<CustomerReview> reviews;

  CustomerReviewResponse({required this.success, required this.reviews});

  factory CustomerReviewResponse.fromJson(Map<String, dynamic> json) {
    final reviewsJson = json['reviews'] is List
        ? json['reviews'] as List
        : <dynamic>[];
    return CustomerReviewResponse(
      success: json['success'] == true,
      reviews: reviewsJson
          .whereType<Map<String, dynamic>>()
          .map(CustomerReview.fromJson)
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
