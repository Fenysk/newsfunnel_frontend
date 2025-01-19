class ExempleEntity {
  final String id;

  ExempleEntity({
    required this.id,
  });

  ExempleEntity copyWith({
    String? id,
  }) {
    return ExempleEntity(
      id: id ?? this.id,
    );
  }
}
