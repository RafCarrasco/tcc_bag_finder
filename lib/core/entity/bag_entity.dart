import 'package:uuid/uuid.dart';
import '../enums/bag_status_enum.dart';
// Import necessário para o novo construtor
import 'bag_status_entity.dart'; 

class BagEntity {
  static const Uuid _uuid = Uuid();

  final String id;
  final String? tripId;
  final BagStatusEnum status;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String? printedCode;
  final String? epc;

  BagEntity({
    String? id,
    required this.status,
    this.tripId,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.printedCode,
    this.epc,
  }) 
    : id = id ?? _uuid.v4(),
      createdAt = createdAt ?? DateTime.now(),
      updatedAt = updatedAt ?? createdAt ?? DateTime.now();

  // ✅ CORREÇÃO: Construtor de fábrica para converter de BagStatusEntity
  factory BagEntity.fromStatusEntity(BagStatusEntity status) {
    // Mapeamos os campos da BagStatusEntity para os campos da BagEntity.
    return BagEntity(
      id: status.bagId, // Assumimos que o bagId na Status Entity é o ID principal da Bagagem
      // Mapeamos a String 'status' de volta para o Enum
      status: BagStatusEnum.values.firstWhere(
        (e) => e.name == status.status,
        orElse: () => BagStatusEnum.NAO_CADASTRADA,
      ),
      tripId: null, // Campo não existe em BagStatusEntity, setamos como null
      createdAt: status.createdAt,
      updatedAt: status.createdAt, // Usamos o createdAt do status como updatedAt
      printedCode: status.printedCode,
      epc: status.rfidTag, // Mapeamos rfidTag para epc
    );
  }

  BagEntity copyWith({
    String? id,
    String? tripId,
    BagStatusEnum? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? printedCode,
    String? epc,
  }) {
    return BagEntity(
      id: id ?? this.id,
      tripId: tripId ?? this.tripId,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      printedCode: printedCode ?? this.printedCode,
      epc: epc ?? this.epc,
    );
  }


  factory BagEntity.empty() {
    final now = DateTime.now();
    return BagEntity(
      id: '',
      status: BagStatusEnum.NAO_CADASTRADA,
      createdAt: now,
      updatedAt: now,
      printedCode: null,
      epc: null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'trip_id': tripId,
      'status': status.name,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String() ?? '',
      'printed_code': printedCode,
      'epc': epc,
    };
  }


  factory BagEntity.fromJson(Map<String, dynamic> json) {
    return BagEntity(
      id: json['id'],
      tripId: json['trip_id'],
      status: BagStatusEnum.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => BagStatusEnum.NAO_CADASTRADA,
      ),
      createdAt: DateTime.parse(json['created_at']), 
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
      printedCode: json['printed_code'],
      epc: json['epc'],
    );
  }
}