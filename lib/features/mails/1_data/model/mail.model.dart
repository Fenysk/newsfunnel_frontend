import 'dart:convert';
import 'package:newsfunnel_frontend/features/mails/2_domain/entity/mail.entity.dart';

class MailModel {
  final String id;
  final String from;
  final String to;
  final String? subject;
  final String? body;
  final String? markdownSummary;
  final bool isRead;
  final DateTime createdAt;
  final String mailServerId;

  MailModel({
    required this.id,
    required this.from,
    required this.to,
    required this.subject,
    this.body,
    this.markdownSummary,
    required this.isRead,
    required this.createdAt,
    required this.mailServerId,
  });

  factory MailModel.fromMap(Map<String, dynamic> map) {
    return MailModel(
      id: map['id'] as String,
      from: map['from'] as String,
      to: map['to'] as String,
      subject: map['subject'] as String?,
      body: map['body'] as String?,
      markdownSummary: map['markdownSummary'] as String?,
      isRead: map['isRead'] as bool,
      createdAt: DateTime.parse(map['createdAt'] as String),
      mailServerId: map['mailServerId'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'from': from,
      'to': to,
      'subject': subject,
      'body': body,
      'markdownSummary': markdownSummary,
      'isRead': isRead,
      'createdAt': createdAt.toIso8601String(),
      'mailServerId': mailServerId,
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
        markdownSummary: markdownSummary,
        isRead: isRead,
        createdAt: createdAt,
        mailServerId: mailServerId,
      );
}
