import 'package:oga_glow/core/constants/contact_constants.dart';

class OfficeModel {
  final String? title;
  final String? city;
  final String? address;
  final String? phone;

  OfficeModel({
    this.title,
    this.city,
    this.address,
    this.phone,
  });

  factory OfficeModel.fromJson(Map<String, dynamic> json) {
    return OfficeModel(
      title: json['title']?.toString() ?? json['name']?.toString(),
      city: json['city']?.toString() ?? json['location']?.toString(),
      address: json['address']?.toString() ??
          json['office_address']?.toString() ??
          json['full_address']?.toString(),
      phone: json['phone']?.toString() ??
          json['phone_number']?.toString() ??
          json['contact']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'city': city,
      'address': address,
      if (phone != null) 'phone': phone,
    };
  }
}

class ContactInfoModel {
  final OfficeModel? headOffice;
  final List<OfficeModel> subOffices;
  final List<String> emails;
  final List<String> phoneNumbers;
  final List<String> socialLinks;
  final String? whatsApp;
  final String? website;

  ContactInfoModel({
    this.headOffice,
    this.subOffices = const [],
    this.emails = const [],
    this.phoneNumbers = const [],
    this.socialLinks = const [],
    this.whatsApp,
    this.website,
  });

  factory ContactInfoModel.fromJson(Map<String, dynamic> json) {
    // 1. Head Office parsing (handles 'headOffice', 'head_office', 'main_office', 'office')
    final rawHeadOffice = json['headOffice'] ??
        json['head_office'] ??
        json['main_office'] ??
        json['headOfficeAddress'];

    OfficeModel? headOffice;
    if (rawHeadOffice is Map<String, dynamic>) {
      headOffice = OfficeModel.fromJson(rawHeadOffice);
    } else if (rawHeadOffice is String && rawHeadOffice.isNotEmpty) {
      headOffice = OfficeModel(
        city: json['city']?.toString() ?? ContactConstants.headOfficeCity,
        address: rawHeadOffice,
      );
    }

    // 2. Sub offices parsing (handles 'subOffices', 'sub_offices', 'branches', 'branch_offices', 'other_offices')
    final rawSubOffices = json['subOffices'] ??
        json['sub_offices'] ??
        json['branches'] ??
        json['branch_offices'] ??
        json['other_offices'];

    final List<OfficeModel> subOffices = [];
    if (rawSubOffices is List) {
      for (final item in rawSubOffices) {
        if (item is Map<String, dynamic>) {
          subOffices.add(OfficeModel.fromJson(item));
        } else if (item is String && item.isNotEmpty) {
          subOffices.add(OfficeModel(address: item));
        }
      }
    }

    // 3. Emails parsing (handles 'emails', 'email', 'support_email', 'contact_email', 'contact_emails')
    final List<String> emails = [];
    final rawEmails = json['emails'] ??
        json['email'] ??
        json['support_email'] ??
        json['contact_email'] ??
        json['contact_emails'];

    if (rawEmails is List) {
      emails.addAll(
        rawEmails
            .map((e) => e.toString().trim())
            .where((e) => e.isNotEmpty),
      );
    } else if (rawEmails is String && rawEmails.trim().isNotEmpty) {
      emails.add(rawEmails.trim());
    }

    // 4. Phone numbers parsing (handles 'phoneNumbers', 'phone_numbers', 'phones', 'phone', 'contact_numbers', 'hotline', 'mobile')
    final List<String> phoneNumbers = [];
    final rawPhones = json['phoneNumbers'] ??
        json['phone_numbers'] ??
        json['phones'] ??
        json['phone'] ??
        json['contact_numbers'] ??
        json['hotline'] ??
        json['mobile'];

    if (rawPhones is List) {
      phoneNumbers.addAll(
        rawPhones
            .map((e) => e.toString().trim())
            .where((e) => e.isNotEmpty),
      );
    } else if (rawPhones is String && rawPhones.trim().isNotEmpty) {
      phoneNumbers.add(rawPhones.trim());
    }

    // 5. Social links parsing
    final List<String> socialLinks = [];
    final rawSocialLinks = json['socialLinks'] ??
        json['social_links'] ??
        json['socials'] ??
        json['links'];

    if (rawSocialLinks is List) {
      socialLinks.addAll(
        rawSocialLinks
            .map((e) => e.toString().trim())
            .where((e) => e.isNotEmpty),
      );
    } else if (rawSocialLinks is Map<String, dynamic>) {
      rawSocialLinks.forEach((_, val) {
        if (val != null && val.toString().trim().isNotEmpty) {
          socialLinks.add(val.toString().trim());
        }
      });
    }

    // Individual social handles if present
    for (final key in ['facebook', 'instagram', 'linkedin', 'twitter', 'youtube', 'tiktok']) {
      final val = json[key]?.toString().trim();
      if (val != null && val.isNotEmpty && !socialLinks.contains(val)) {
        socialLinks.add(val);
      }
    }

    final whatsApp = json['whatsapp']?.toString() ??
        json['whatsApp']?.toString() ??
        json['whats_app']?.toString();

    final website = json['website']?.toString() ??
        json['web']?.toString() ??
        json['site']?.toString();

    return ContactInfoModel(
      headOffice: headOffice,
      subOffices: subOffices,
      emails: emails,
      phoneNumbers: phoneNumbers,
      socialLinks: socialLinks,
      whatsApp: whatsApp,
      website: website,
    );
  }

  factory ContactInfoModel.fallback() {
    return ContactInfoModel(
      headOffice: OfficeModel(
        title: ContactConstants.headOfficeTitle,
        city: ContactConstants.headOfficeCity,
        address: ContactConstants.headOfficeAddress,
        phone: ContactConstants.phoneNumber1,
      ),
      subOffices: [
        OfficeModel(
          title: ContactConstants.subOfficeTitle,
          city: ContactConstants.subOfficeCity,
          address: ContactConstants.subOfficeAddress,
          phone: ContactConstants.phoneNumber2,
        ),
      ],
      emails: [
        ContactConstants.emailAddress,
      ],
      phoneNumbers: [
        ContactConstants.phoneNumber1,
        ContactConstants.phoneNumber2,
      ],
      socialLinks: [
        ContactConstants.whatsAppUrl,
        ContactConstants.websiteUrl,
        ContactConstants.facebookUrl,
        ContactConstants.instagramUrl,
        ContactConstants.linkedInUrl,
      ],
      whatsApp: ContactConstants.whatsAppUrl,
      website: ContactConstants.websiteUrl,
    );
  }

  // --- Convenience Getters ---

  String get primaryPhone => phoneNumbers.isNotEmpty
      ? phoneNumbers.first
      : ContactConstants.phoneNumber1;

  String get primaryEmail => emails.isNotEmpty
      ? emails.first
      : ContactConstants.emailAddress;

  String get effectiveWhatsAppUrl =>
      whatsApp ?? ContactConstants.whatsAppUrl;

  String get effectiveWebsiteUrl =>
      website ?? ContactConstants.websiteUrl;

  List<OfficeModel> get allOffices {
    final list = <OfficeModel>[];
    if (headOffice != null) {
      list.add(headOffice!);
    }
    list.addAll(subOffices);
    if (list.isEmpty) {
      list.addAll(ContactInfoModel.fallback().allOffices);
    }
    return list;
  }

  Map<String, dynamic> toJson() {
    return {
      'headOffice': headOffice?.toJson(),
      'subOffices': subOffices.map((office) => office.toJson()).toList(),
      'emails': emails,
      'phoneNumbers': phoneNumbers,
      'socialLinks': socialLinks,
      if (whatsApp != null) 'whatsapp': whatsApp,
      if (website != null) 'website': website,
    };
  }
}

