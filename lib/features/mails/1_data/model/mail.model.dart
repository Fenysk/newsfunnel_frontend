import 'dart:convert';
import 'package:newsfunnel_frontend/features/mails/1_data/model/mail-metadata.model.dart';
import 'package:newsfunnel_frontend/features/mails/2_domain/entity/mail.entity.dart';

class MailModel {
  final String id;
  final String from;
  final String to;
  final String? subject;
  final String? body;
  final DateTime createdAt;
  final String mailServerId;
  final MailMetadataModel? metadata;

  MailModel({
    required this.id,
    required this.from,
    required this.to,
    required this.subject,
    this.body,
    required this.createdAt,
    required this.mailServerId,
    required this.metadata,
  });

  factory MailModel.fromMap(Map<String, dynamic> map) {
    return MailModel(
      id: map['id'] as String,
      from: map['from'] as String,
      to: map['to'] as String,
      subject: map['subject'] as String?,
      body: map['body'] as String?,
      createdAt: DateTime.parse(map['createdAt'] as String),
      mailServerId: map['mailServerId'] as String,
      metadata: map['Metadata'] != null ? MailMetadataModel.fromMap(map['Metadata'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'from': from,
      'to': to,
      'subject': subject,
      'body': body,
      'createdAt': createdAt.toIso8601String(),
      'mailServerId': mailServerId,
      'Metadata': metadata?.toMap(),
    };
  }

  factory MailModel.fromJson(String source) => MailModel.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
}

extension MailModelExtension on MailModel {
  MailEntity toEntity() => MailEntity(
        id: id,
        from: from,
        to: to,
        subject: subject,
        body: body,
        createdAt: createdAt,
        mailServerId: mailServerId,
        metadata: metadata?.toEntity(),
      );
}
