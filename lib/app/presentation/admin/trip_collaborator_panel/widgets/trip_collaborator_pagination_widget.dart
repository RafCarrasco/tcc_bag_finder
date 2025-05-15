import 'package:tcc_bag_finder/app/presentation/user/stores/user_provider.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_colors.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_dimensions.dart';
import 'package:tcc_bag_finder/domain/entity/collaborator_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class TripCollaboratorPaginationWidget extends StatefulWidget {
  final List<CollaboratorEntity> collaborators;

  const TripCollaboratorPaginationWidget({
    super.key,
    required this.collaborators,
  });

  @override
  State<TripCollaboratorPaginationWidget> createState() =>
      _TripCollaboratorPaginationWidgetState();
}

class _TripCollaboratorPaginationWidgetState
    extends State<TripCollaboratorPaginationWidget> {
  UserProvider provider = Modular.get<UserProvider>();
  @override
  Widget build(BuildContext context) {
    if (widget.collaborators.isEmpty) {
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
      itemCount: widget.collaborators.length,
      itemBuilder: (context, index) {
        final collaborator = widget.collaborators[index];
        return ListTile(
          shape: Border(
            left: BorderSide(
              color: AppColors.primary,
              width: AppDimensions.borderThin,
            ),
          ),
          title: Text(
            collaborator.fullName,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          subtitle: buildCollaboratorDetails(
            context,
            collaborator,
          ),
          trailing: buildTrailingIcons(
            context,
            collaborator,
          ),
        );
      },
    );
  }

  Widget buildCollaboratorDetails(
      BuildContext context, CollaboratorEntity collaborator) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          collaborator.email,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: AppColors.secondaryGrey,
              ),
        ),
        const SizedBox(
          height: 4,
        ),
        buildInfoRow(
          context,
          'Viagens Criadas: ',
          collaborator.tripsCreated.toString(),
        ),
        buildInfoRow(
          context,
          'ID: ',
          collaborator.id.substring(
            0,
            4,
          ),
        ),
      ],
    );
  }

  Widget buildInfoRow(BuildContext context, String label, String value) {
    return Row(
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: AppColors.secondaryGrey,
              ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: AppColors.secondaryGrey,
              ),
        ),
      ],
    );
  }

  Widget buildTrailingIcons(
      BuildContext context, CollaboratorEntity collaborator) {
    return collaborator.tripsCreated != 0
        ? Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    AppColors.primary,
                  ),
                ),
                onPressed: () async {
                  Modular.to.pushNamed(
                    '/admin/${provider.user!.id}/trip-collaborator-panel/${collaborator.id}',
                  );
                },
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Viagens criadas',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: AppColors.secondary,
                          ),
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    Icon(
                      Icons.visibility,
                      size: AppDimensions.iconSmall,
                      color: AppColors.secondary,
                    ),
                  ],
                ),
              ),
            ],
          )
        : Text(
            'Nenhuma viagem criada',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: AppColors.secondaryGrey,
                ),
          );
  }
}
