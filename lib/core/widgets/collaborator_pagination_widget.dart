import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../entity/collaborator_entity.dart';
import '../provider/user_provider.dart';
import '../utils/app_colors.dart';
import '../utils/app_dimensions.dart';
import 'delete_confirmation_dialog_widget.dart';
import 'dialogs/collaborator_details_dialog.dart';
import 'dialogs/edit_collaborator_dialog.dart';


class CollaboratorPaginationWidget extends StatelessWidget {
  final List<CollaboratorEntity> collaborators;

  const CollaboratorPaginationWidget({
    super.key,
    required this.collaborators,
  });

  @override
  Widget build(BuildContext context) {
    if (collaborators.isEmpty) {
      return const Center(
        child: Text(
          "Nenhum colaborador encontrado",
        ),
      );
    }

    return ListView.separated(
      separatorBuilder: (context, index) => const Divider(
        color: Colors.transparent,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: AppDimensions.paddingLarge,
      ),
      itemCount: collaborators.length,
      itemBuilder: (context, index) {
        final collaborator = collaborators[index];
        return ListTile(
          shape: Border(
            left: BorderSide(
              color: AppColors.primary,
              width: AppDimensions.borderThin,
            ),
          ),
          style: ListTileStyle.list,
          title: Text(
            collaborator.fullName,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                collaborator.email,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: AppColors.secondaryGrey,
                    ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    'Status: ',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: AppColors.secondaryGrey,
                        ),
                  ),
                  Icon(
                    Icons.circle,
                    color:
                        collaborator.isActive ? AppColors.green : AppColors.red,
                    size: AppDimensions.iconSmall,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'ID: ',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: AppColors.secondaryGrey,
                        ),
                  ),
                  Text(
                    collaborator.id.substring(0, 4),
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: AppColors.secondaryGrey,
                        ),
                  ),
                ],
              ),
            ],
          ),
          trailing: _buildTrailingIcons(context, collaborator),
        );
      },
    );
  }

  Widget _buildTrailingIcons(
      BuildContext context, CollaboratorEntity collaborator) {
    var userProvider = Modular.get<UserProvider>();

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(
            Icons.visibility,
            color: AppColors.secondaryGrey,
            size: AppDimensions.iconMedium,
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return CollaboratorDetailsDialog(
                  collaborator: collaborator,
                );
              },
            );
          },
        ),
        IconButton(
          icon: Icon(
            Icons.edit,
            color: AppColors.primary,
            size: AppDimensions.iconMedium,
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return EditCollaboratorDialog(
                  collaborator: collaborator,
                  onSave: (updatedCollaborator) {
                    userProvider.updateUser(user: updatedCollaborator);
                  },
                );
              },
            );
          },
        ),
        IconButton(
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
            size: AppDimensions.iconMedium,
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return DeleteConfirmationWidgetDialog(
                  collaboratorName: collaborator.fullName,
                  onConfirm: () {
                    userProvider.deleteUser(
                      id: collaborator.id,
                    );
                  },
                );
              },
            );
          },
        ),
      ],
    );
  }
}
