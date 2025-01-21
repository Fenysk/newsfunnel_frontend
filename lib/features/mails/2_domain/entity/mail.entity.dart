class MailEntity {
  final String id;
  final String from;
  final String to;
  final String? subject;
  final String? body;
  final String? markdownSummary;
  final DateTime createdAt;
  final String mailServerId;

  MailEntity({
    required this.id,
    required this.from,
    required this.to,
    required this.subject,
    this.body,
    this.markdownSummary,
    required this.createdAt,
    required this.mailServerId,
  });

  MailEntity copyWith({
    String? id,
    String? from,
    String? to,
    String? subject,
    String? body,
    DateTime? createdAt,
    String? markdownSummary,
    String? mailServerId,
  }) {
    return MailEntity(
      id: id ?? this.id,
      from: from ?? this.from,
      to: to ?? this.to,
      subject: subject ?? this.subject,
      body: body ?? this.body,
      markdownSummary: markdownSummary ?? this.markdownSummary,
      createdAt: createdAt ?? this.createdAt,
      mailServerId: mailServerId ?? this.mailServerId,
    );
  }
}
