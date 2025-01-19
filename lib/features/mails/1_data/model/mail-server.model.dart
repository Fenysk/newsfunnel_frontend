import 'dart:convert';
import 'package:newsfunnel_frontend/features/mails/1_data/model/mail.model.dart';
import 'package:newsfunnel_frontend/features/mails/2_domain/entity/mail-server.entity.dart';

class MailServerModel {
  final String id;
  final String name;
  final String user;
  final String password;
  final String host;
  final int port;
  final bool tls;
  final String userId;
  final List<MailModel>? mails;

  MailServerModel({
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

  factory MailServerModel.fromMap(Map<String, dynamic> map) {
    return MailServerModel(
      id: map['id'] as String,
      name: map['name'] as String,
      user: map['user'] as String,
      password: map['password'] as String,
      host: map['host'] as String,
      port: map['port'] as int,
      tls: map['tls'] as bool,
      userId: map['userId'] as String,
      mails: map['Mails'] != null ? List<MailModel>.from((map['Mails'] as List).map((mail) => MailModel.fromMap(mail))) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'user': user,
      'password': password,
      'host': host,
      'port': port,
      'tls': tls,
      'userId': userId,
      if (mails != null) 'Mails': mails!.map((mail) => mail.toMap()).toList(),
    };
  }

  factory MailServerModel.fromJson(String source) => MailServerModel.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
}

extension MailServerModelExtension on MailServerModel {
  MailServerEntity toEntity() => MailServerEntity(
        id: id,
        name: name,
        user: user,
        password: password,
        host: host,
        port: port,
        tls: tls,
        userId: userId,
        mails: mails?.map((mail) => mail.toEntity()).toList(),
      );
}
