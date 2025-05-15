import 'package:hive/hive.dart';

part 'scanner_entity.g.dart';

@HiveType(typeId: 4)
class ScannerEntity {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String isActive;

  ScannerEntity({
    required this.id,
    required this.isActive,
  });

  ScannerEntity copyWith({
    String? id,
    String? isActive,
  }) {
    return ScannerEntity(
      id: id ?? this.id,
      isActive: isActive ?? this.isActive,
    );
  }

  static ScannerEntity empty() {
    return ScannerEntity(
      id: '',
      isActive: 'false',
    );
  }
}
