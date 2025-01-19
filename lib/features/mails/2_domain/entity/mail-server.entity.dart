import 'package:newsfunnel_frontend/features/mails/2_domain/entity/mail.entity.dart';

class MailServerEntity {
  final String id;
  final String name;
  final String user;
  final String password;
  final String host;
  final int port;
  final bool tls;
  final String userId;
  final List<MailEntity>? mails;

  MailServerEntity({
    required this.id,
    required this.name,
    required this.user,
    required this.password,
    required this.host,
    required this.port,
    required this.tls,
    required this.userId,
    this.mails,
  });

  MailServerEntity copyWith({
    String? id,
    String? name,
    String? user,
    String? password,
    String? host,
    int? port,
    bool? tls,
    String? userId,
    List<MailEntity>? mails,
  }) {
    return MailServerEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      user: user ?? this.user,
      password: password ?? this.password,
      host: host ?? this.host,
      port: port ?? this.port,
      tls: tls ?? this.tls,
      userId: userId ?? this.userId,
      mails: mails ?? this.mails,
    );
  }
}
