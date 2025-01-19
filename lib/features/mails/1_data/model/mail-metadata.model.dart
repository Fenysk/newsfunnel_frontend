import 'dart:convert';

import 'package:newsfunnel_frontend/features/mails/2_domain/entity/mail-metadata.entity.dart';

class MailMetadataModel {
  final String id;
  final bool isNewsletter;
  final String? newsletterName;
  final List<String> theme;
  final List<String> tags;
  final List<String> mainSubjectsTitle;
  final String oneResumeSentence;
  final String longResume;
  final bool differentSubject;
  final bool isExplicitSponsored;
  final String? sponsorIfTrue;
  final String? unsubscribeLink;
  final int priority;
  final String mailId;

  MailMetadataModel({
    required this.id,
    required this.isNewsletter,
    required this.newsletterName,
    required this.theme,
    required this.tags,
    required this.mainSubjectsTitle,
    required this.oneResumeSentence,
    required this.longResume,
    required this.differentSubject,
    required this.isExplicitSponsored,
    required this.sponsorIfTrue,
    required this.unsubscribeLink,
    required this.priority,
    required this.mailId,
  });

  factory MailMetadataModel.fromMap(Map<String, dynamic> map) {
    return MailMetadataModel(
      id: map['id'] as String,
      isNewsletter: map['isNewsletter'] as bool,
      newsletterName: map['newsletterName'] as String?,
      theme: List<String>.from(map['theme'] as List),
      tags: List<String>.from(map['tags'] as List),
      mainSubjectsTitle: List<String>.from(map['mainSubjectsTitle'] as List),
      oneResumeSentence: map['oneResumeSentence'] as String,
      longResume: map['longResume'] as String,
      differentSubject: map['differentSubject'] as bool,
      isExplicitSponsored: map['isExplicitSponsored'] as bool,
      sponsorIfTrue: map['sponsorIfTrue'] as String?,
      unsubscribeLink: map['unsubscribeLink'] as String?,
      priority: map['priority'] as int,
      mailId: map['mailId'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'isNewsletter': isNewsletter,
      'newsletterName': newsletterName,
      'theme': theme,
      'tags': tags,
      'mainSubjectsTitle': mainSubjectsTitle,
      'oneResumeSentence': oneResumeSentence,
      'longResume': longResume,
      'differentSubject': differentSubject,
      'isExplicitSponsored': isExplicitSponsored,
      'sponsorIfTrue': sponsorIfTrue,
      'unsubscribeLink': unsubscribeLink,
      'priority': priority,
      'mailId': mailId,
    };
  }

  factory MailMetadataModel.fromJson(String source) => MailMetadataModel.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
}

extension MailMetadataModelExtension on MailMetadataModel {
  MailMetadataEntity toEntity() => MailMetadataEntity(
        id: id,
        isNewsletter: isNewsletter,
        newsletterName: newsletterName,
        theme: theme,
        tags: tags,
        mainSubjectsTitle: mainSubjectsTitle,
        oneResumeSentence: oneResumeSentence,
        longResume: longResume,
        differentSubject: differentSubject,
        isExplicitSponsored: isExplicitSponsored,
        sponsorIfTrue: sponsorIfTrue,
        unsubscribeLink: unsubscribeLink,
        priority: priority,
        mailId: mailId,
      );
}
