import 'dart:convert';
import 'package:newsfunnel_frontend/template/2_domain/entity/exemple.entity.dart';

class ExempleModel {
  final String id;

  ExempleModel({
    required this.id,
  });

  factory ExempleModel.fromMap(Map<String, dynamic> map) {
    return ExempleModel(
      id: map['id'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
    };
  }

  factory ExempleModel.fromJson(String source) => ExempleModel.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
}

extension ExempleModelExtension on ExempleModel {
  ExempleEntity toEntity() => ExempleEntity(
        id: id,
      );
}
