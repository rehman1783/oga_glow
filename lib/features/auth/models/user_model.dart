class UserModel {
  final String id;
  final String name;
  final String email;
  final String? createdAt;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final rawId = json['id'] ?? json['_id'] ?? json['userId'];
    final rawName = json['name'] ?? json['fullName'] ?? json['username'];
    final rawEmail = json['email'] ?? json['userEmail'];
    final rawCreatedAt = json['createdAt'] ?? json['created_at'] ?? json['joinedDate'] ?? json['date'];

    return UserModel(
      id: rawId?.toString() ?? '',
      name: rawName?.toString() ?? '',
      email: rawEmail?.toString() ?? '',
      createdAt: rawCreatedAt?.toString(),
    );
  }

  /// Extracts display initials for avatar (e.g. "Ahmed Hassan" -> "AH")
  String get initials {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return 'O';
    final parts = trimmed.split(RegExp(r'\s+'));
    if (parts.length > 1 && parts[1].isNotEmpty) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return trimmed[0].toUpperCase();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      if (createdAt != null) 'createdAt': createdAt,
    };
  }

  /// Create a copy with updated fields.
  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? createdAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() => 'UserModel(id: $id, name: $name, email: $email)';
}

