

import '../../events/user_deleted_event.dart';
import '../../events/user_updated_event.dart';
import '../entity/collaborator_entity.dart';

class CollaboratorEventHandler {
  final void Function(String id) onRemoveById;
  final void Function(CollaboratorEntity user) onUpdate;

  CollaboratorEventHandler({
    required this.onRemoveById,
    required this.onUpdate,
  });

  void handleUserDeleted(UserDeletedEvent event) {
    onRemoveById(event.id);
  }

  void handleUserUpdated(UserUpdatedEvent event) {
    if (event.user is CollaboratorEntity) {
      onUpdate(event.user as CollaboratorEntity);
    }
  }
}
