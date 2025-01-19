class MailMetadataEntity {
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

  MailMetadataEntity({
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

  MailMetadataEntity copyWith({
    String? id,
    bool? isNewsletter,
    String? newsletterName,
    List<String>? theme,
    List<String>? tags,
    List<String>? mainSubjectsTitle,
    String? oneResumeSentence,
    String? longResume,
    bool? differentSubject,
    bool? isExplicitSponsored,
    String? sponsorIfTrue,
    String? unsubscribeLink,
    int? priority,
    String? mailId,
  }) {
    return MailMetadataEntity(
      id: id ?? this.id,
      isNewsletter: isNewsletter ?? this.isNewsletter,
      newsletterName: newsletterName ?? this.newsletterName,
      theme: theme ?? this.theme,
      tags: tags ?? this.tags,
      mainSubjectsTitle: mainSubjectsTitle ?? this.mainSubjectsTitle,
      oneResumeSentence: oneResumeSentence ?? this.oneResumeSentence,
      longResume: longResume ?? this.longResume,
      differentSubject: differentSubject ?? this.differentSubject,
      isExplicitSponsored: isExplicitSponsored ?? this.isExplicitSponsored,
      sponsorIfTrue: sponsorIfTrue ?? this.sponsorIfTrue,
      unsubscribeLink: unsubscribeLink ?? this.unsubscribeLink,
      priority: priority ?? this.priority,
      mailId: mailId ?? this.mailId,
    );
  }
}
