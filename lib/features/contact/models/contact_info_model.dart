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

class PhoneChannelModel {
  final String label;
  final String number;

  const PhoneChannelModel({
    required this.label,
    required this.number,
  });

  factory PhoneChannelModel.fromJson(dynamic json, int index) {
    if (json is Map<String, dynamic>) {
      final num = json['number']?.toString() ??
          json['phone']?.toString() ??
          json['value']?.toString() ??
          '';
      final lbl = json['label']?.toString() ??
          json['title']?.toString() ??
          json['name']?.toString() ??
          (index == 0 ? ContactConstants.phoneLabel1 : ContactConstants.phoneLabel2);
      return PhoneChannelModel(
        label: lbl,
        number: num,
      );
    }
    final str = json.toString().trim();
    return PhoneChannelModel(
      label: index == 0 ? ContactConstants.phoneLabel1 : ContactConstants.phoneLabel2,
      number: str,
    );
  }
}

class EmailChannelModel {
  final String label;
  final String email;
  final String? badge;

  const EmailChannelModel({
    required this.label,
    required this.email,
    this.badge,
  });

  factory EmailChannelModel.fromJson(dynamic json, int index) {
    if (json is Map<String, dynamic>) {
      final em = json['email']?.toString() ??
          json['address']?.toString() ??
          json['value']?.toString() ??
          '';
      final lbl = json['label']?.toString() ??
          json['title']?.toString() ??
          json['name']?.toString() ??
          'Customer Support';
      final bdg = json['badge']?.toString() ?? 'Official';
      return EmailChannelModel(label: lbl, email: em, badge: bdg);
    }
    return EmailChannelModel(
      label: index == 0 ? 'Customer Support' : 'Inquiries & Orders',
      email: json.toString().trim(),
      badge: 'Official',
    );
  }
}

class ContactInfoModel {
  final OfficeModel? headOffice;
  final List<OfficeModel> subOffices;
  final List<String> emails;
  final List<String> phoneNumbers;
  final List<PhoneChannelModel> structuredPhones;
  final List<EmailChannelModel> structuredEmails;
  final List<String> socialLinks;
  final String? whatsApp;
  final String? website;
  final String workingHours;

  ContactInfoModel({
    this.headOffice,
    this.subOffices = const [],
    this.emails = const [],
    this.phoneNumbers = const [],
    this.structuredPhones = const [],
    this.structuredEmails = const [],
    this.socialLinks = const [],
    this.whatsApp,
    this.website,
    this.workingHours = 'Mon - Sat: 09:00 AM - 06:00 PM',
  });

  factory ContactInfoModel.fromJson(Map<String, dynamic> json) {
    // 1. Head Office parsing
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

    // 2. Sub offices parsing
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

    // 3. Emails parsing
    final List<String> emails = [];
    final List<EmailChannelModel> structuredEmails = [];
    final rawEmails = json['emails'] ??
        json['email'] ??
        json['support_email'] ??
        json['contact_email'] ??
        json['contact_emails'];

    if (rawEmails is List) {
      for (int i = 0; i < rawEmails.length; i++) {
        final item = rawEmails[i];
        if (item is Map<String, dynamic>) {
          final model = EmailChannelModel.fromJson(item, i);
          if (model.email.isNotEmpty) {
            emails.add(model.email);
            structuredEmails.add(model);
          }
        } else if (item != null && item.toString().trim().isNotEmpty) {
          final emailStr = item.toString().trim();
          emails.add(emailStr);
          structuredEmails.add(EmailChannelModel.fromJson(emailStr, i));
        }
      }
    } else if (rawEmails is String && rawEmails.trim().isNotEmpty) {
      emails.add(rawEmails.trim());
      structuredEmails.add(EmailChannelModel.fromJson(rawEmails.trim(), 0));
    }

    // 4. Phone numbers parsing
    final List<String> phoneNumbers = [];
    final List<PhoneChannelModel> structuredPhones = [];
    final rawPhones = json['phoneNumbers'] ??
        json['phone_numbers'] ??
        json['phones'] ??
        json['phone'] ??
        json['contact_numbers'] ??
        json['hotline'] ??
        json['mobile'];

    if (rawPhones is List) {
      for (int i = 0; i < rawPhones.length; i++) {
        final item = rawPhones[i];
        if (item is Map<String, dynamic>) {
          final model = PhoneChannelModel.fromJson(item, i);
          if (model.number.isNotEmpty) {
            phoneNumbers.add(model.number);
            structuredPhones.add(model);
          }
        } else if (item != null && item.toString().trim().isNotEmpty) {
          final phoneStr = item.toString().trim();
          phoneNumbers.add(phoneStr);
          structuredPhones.add(PhoneChannelModel.fromJson(phoneStr, i));
        }
      }
    } else if (rawPhones is String && rawPhones.trim().isNotEmpty) {
      phoneNumbers.add(rawPhones.trim());
      structuredPhones.add(PhoneChannelModel.fromJson(rawPhones.trim(), 0));
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

    final workingHours = json['working_hours']?.toString() ??
        json['workingHours']?.toString() ??
        json['timings']?.toString() ??
        'Mon - Sat: 09:00 AM - 06:00 PM';

    return ContactInfoModel(
      headOffice: headOffice,
      subOffices: subOffices,
      emails: emails.isNotEmpty ? emails : [ContactConstants.emailAddress],
      phoneNumbers: phoneNumbers.isNotEmpty
          ? phoneNumbers
          : [ContactConstants.phoneNumber1, ContactConstants.phoneNumber2],
      structuredPhones: structuredPhones.isNotEmpty
          ? structuredPhones
          : [
              const PhoneChannelModel(
                label: ContactConstants.phoneLabel1,
                number: ContactConstants.phoneNumber1,
              ),
              const PhoneChannelModel(
                label: ContactConstants.phoneLabel2,
                number: ContactConstants.phoneNumber2,
              ),
            ],
      structuredEmails: structuredEmails.isNotEmpty
          ? structuredEmails
          : [
              const EmailChannelModel(
                label: 'Customer Support Desk',
                email: ContactConstants.emailAddress,
                badge: 'Official',
              ),
            ],
      socialLinks: socialLinks,
      whatsApp: whatsApp,
      website: website,
      workingHours: workingHours,
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
      structuredPhones: [
        const PhoneChannelModel(
          label: ContactConstants.phoneLabel1,
          number: ContactConstants.phoneNumber1,
        ),
        const PhoneChannelModel(
          label: ContactConstants.phoneLabel2,
          number: ContactConstants.phoneNumber2,
        ),
      ],
      structuredEmails: [
        const EmailChannelModel(
          label: 'Customer Support Desk',
          email: ContactConstants.emailAddress,
          badge: 'Official Response',
        ),
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
      workingHours: 'Mon - Sat: 09:00 AM - 06:00 PM',
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
      'workingHours': workingHours,
    };
  }
}


