import 'dart:convert';
import 'package:newsfunnel_frontend/core/enums/role.enum.dart';
import 'package:newsfunnel_frontend/features/user/1_data/model/profile.model.dart';
import 'package:newsfunnel_frontend/features/user/2_domain/entity/user.entity.dart';

class UserModel {
  final String id;
  final String? email;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<Role> roles;
  final ProfileModel? Profile;

  UserModel({
    required this.id,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
    required this.roles,
    required this.Profile,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      email: map['email'] as String?,
      createdAt: DateTime.parse(map['createdAt'] as String),
      updatedAt: DateTime.parse(map['updatedAt'] as String),
      roles: List<Role>.from((map['roles'] as List).map((role) => Role.values.firstWhere((e) => e.toString().split('.').last.toLowerCase() == role))),
      Profile: ProfileModel.fromMap(map['Profile'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'roles': roles.map((role) => role.toString().split('.').last.toLowerCase()).toList(),
      'Profile': Profile?.toMap(),
    };
  }

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
}

extension UserModelExtension on UserModel {
  UserEntity toEntity() => UserEntity(
        id: id,
        email: email,
        createdAt: createdAt,
        updatedAt: updatedAt,
        roles: roles,
        Profile: Profile?.toEntity(),
      );
}
