class OfficeModel {
  final String? city;
  final String? address;

  OfficeModel({this.city, this.address});

  factory OfficeModel.fromJson(Map<String, dynamic> json) {
    return OfficeModel(
      city: json['city']?.toString(),
      address: json['address']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'city': city, 'address': address};
  }
}

class ContactInfoModel {
  final OfficeModel? headOffice;
  final List<OfficeModel> subOffices;
  final List<String> emails;
  final List<String> phoneNumbers;
  final List<String> socialLinks;

  ContactInfoModel({
    this.headOffice,
    this.subOffices = const [],
    this.emails = const [],
    this.phoneNumbers = const [],
    this.socialLinks = const [],
  });

  factory ContactInfoModel.fromJson(Map<String, dynamic> json) {
    final headOfficeJson = json['headOffice'];
    final subOfficesJson = json['subOffices'] is List
        ? json['subOffices'] as List
        : <dynamic>[];
    final emailsJson = json['emails'] is List
        ? json['emails'] as List
        : <dynamic>[];
    final phoneNumbersJson = json['phoneNumbers'] is List
        ? json['phoneNumbers'] as List
        : <dynamic>[];
    final socialLinksJson = json['socialLinks'] is List
        ? json['socialLinks'] as List
        : <dynamic>[];

    return ContactInfoModel(
      headOffice: headOfficeJson is Map<String, dynamic>
          ? OfficeModel.fromJson(headOfficeJson)
          : null,
      subOffices: subOfficesJson
          .whereType<Map<String, dynamic>>()
          .map(OfficeModel.fromJson)
          .toList(),
      emails: emailsJson
          .map((e) => e.toString())
          .where((e) => e.isNotEmpty)
          .toList(),
      phoneNumbers: phoneNumbersJson
          .map((e) => e.toString())
          .where((e) => e.isNotEmpty)
          .toList(),
      socialLinks: socialLinksJson
          .map((e) => e.toString())
          .where((e) => e.isNotEmpty)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'headOffice': headOffice?.toJson(),
      'subOffices': subOffices.map((office) => office.toJson()).toList(),
      'emails': emails,
      'phoneNumbers': phoneNumbers,
      'socialLinks': socialLinks,
    };
  }
}
