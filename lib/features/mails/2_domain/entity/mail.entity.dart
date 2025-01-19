import 'package:newsfunnel_frontend/features/mails/2_domain/entity/mail-metadata.entity.dart';

class MailEntity {
  final String id;
  final String from;
  final String to;
  final String? subject;
  final String body;
  final DateTime createdAt;
  final String mailServerId;
  final MailMetadataEntity? metadata;

  MailEntity({
    required this.id,
    required this.from,
    required this.to,
    required this.subject,
    required this.body,
    required this.createdAt,
    required this.mailServerId,
    required this.metadata,
  });

  MailEntity copyWith({
    String? id,
    String? from,
    String? to,
    String? subject,
    String? body,
    DateTime? createdAt,
    String? mailServerId,
    MailMetadataEntity? metadata,
  }) {
    return MailEntity(
      id: id ?? this.id,
      from: from ?? this.from,
      to: to ?? this.to,
      subject: subject ?? this.subject,
      body: body ?? this.body,
      createdAt: createdAt ?? this.createdAt,
      mailServerId: mailServerId ?? this.mailServerId,
      metadata: metadata ?? this.metadata,
    );
  }
}
