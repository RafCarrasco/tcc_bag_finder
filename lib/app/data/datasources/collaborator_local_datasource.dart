import 'package:tcc_bag_finder/domain/entity/collaborator_entity.dart';

abstract class ICollaboratorLocalDatasource {
  Future<List<CollaboratorEntity>> getCollaboratorsByResponsibleId({
    required String responsibleId,
  });
}
