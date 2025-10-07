import 'package:uuid/uuid.dart';

class TagEntity {
  static const Uuid _uuid = Uuid();

  final String id;
  final String code;
  final DateTime createdAt;

  TagEntity({
    String? id,
    required this.code,
    DateTime? createdAt,
  })  : id = id ?? _uuid.v4(),
        createdAt = createdAt ?? DateTime.now();

  TagEntity copyWith({
    String? id,
    String? code,
    DateTime? createdAt,
  }) {
    return TagEntity(
      id: id ?? this.id,
      code: code ?? this.code,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory TagEntity.fromJson(Map<String, dynamic> json) {
    return TagEntity(
      id: json['id'],
      code: json['code'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory TagEntity.empty() {
    return TagEntity(
      id: '',
      code: '',
      createdAt: DateTime.now(),
    );
  }
}
