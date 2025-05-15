import 'package:tcc_bag_finder/app/events/user_deleted_event.dart';
import 'package:tcc_bag_finder/app/events/user_updated_event.dart';
import 'package:tcc_bag_finder/domain/entity/collaborator_entity.dart';

class CollaboratorEventHandler {
  final void Function(
    String,
  ) onRemoveById;
  final void Function(
    CollaboratorEntity,
  ) onUpdate;

  CollaboratorEventHandler({
    required this.onRemoveById,
    required this.onUpdate,
  });

  void handleUserDeleted(
    UserDeletedEvent event,
  ) {
    onRemoveById(
      event.id,
    );
  }

  void handleUserUpdated(
    UserUpdatedEvent event,
  ) {
    onUpdate(
      event.user as CollaboratorEntity,
    );
  }
}
