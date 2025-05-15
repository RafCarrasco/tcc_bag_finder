import 'package:tcc_bag_finder/domain/entity/bag_entity.dart';
import 'package:tcc_bag_finder/domain/enums/bag_status_enum.dart';

class BagEntityAdapter {
  static BagEntity fromJson(Map<String, dynamic> json) {
    return BagEntity(
      id: json['id'],
      ownerId: json['ownerId'],
      description: json['description'],
      status: BagStatusEnum.values.firstWhere(
          (e) => e.toString().split('.').last == json['status'],
          orElse: () => BagStatusEnum.UNKNOWN),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  static Map<String, dynamic> toJson(BagEntity bag) {
    return {
      'id': bag.id,
      'ownerId': bag.ownerId,
      'description': bag.description,
      'status': bag.status.toString().split('.').last,
      'createdAt': bag.createdAt.toIso8601String(),
      'updatedAt': bag.updatedAt?.toIso8601String(),
    };
  }

  // Adicionando fromJsonList
  static List<BagEntity> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
