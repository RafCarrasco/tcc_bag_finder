import 'package:uuid/uuid.dart';

class TagEntity {
  static const Uuid _uuid = Uuid();

  final String id;
  final String code;
  final String bagId;
  final DateTime createdAt;
  final String? printedCode;

  TagEntity( {
    this.printedCode,
    String? id,
    required this.code,
    required this.bagId,
    DateTime? createdAt,
  })  : id = id ?? _uuid.v4(),
        createdAt = createdAt ?? DateTime.now();

  TagEntity copyWith({
    String? id,
    String? code,
    String? bagId,
    DateTime? createdAt,
  }) {
    return TagEntity(
      id: id ?? this.id,
      code: code ?? this.code,
      bagId: bagId ?? this.bagId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory TagEntity.fromJson(Map<String, dynamic> json) {
    return TagEntity(
      id: json['id'],
      code: json['code'],
      bagId: json['bag_id'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'bag_id': bagId,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory TagEntity.empty() {
    return TagEntity(
      id: '',
      code: '',
      bagId: '',
      createdAt: DateTime.now(),
    );
  }
}
