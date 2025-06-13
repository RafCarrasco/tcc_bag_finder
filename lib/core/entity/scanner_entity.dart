import 'package:uuid/uuid.dart';

class ScannerEntity {
  static const Uuid _uuid = Uuid();

  final String id;
  final bool isActive;

  ScannerEntity({
    String? id,
    required this.isActive,
  }) : id = id ?? _uuid.v4();

  ScannerEntity copyWith({
    String? id,
    bool? isActive,
  }) {
    return ScannerEntity(
      id: id ?? this.id,
      isActive: isActive ?? this.isActive,
    );
  }

  static ScannerEntity empty() {
    return ScannerEntity(
      id: '',
      isActive: false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'isActive': isActive,
    };
  }

  factory ScannerEntity.fromJson(Map<String, dynamic> json) {
    return ScannerEntity(
      id: json['id'],
      isActive: json['isActive'] ?? false,
    );
  }
}
