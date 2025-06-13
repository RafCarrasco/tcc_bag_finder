import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';

import '../../core/entity/collaborator_entity.dart';
import '../../core/provider/admin_provider.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/app_dimensions.dart';
import '../../core/widgets/collaborator_pagination_widget.dart';
import '../../core/widgets/collaborator_panel_search_bar_widget.dart';

class CollaboratorPanelPage extends StatefulWidget {
  final String adminId;
  const CollaboratorPanelPage({
    super.key,
    required this.adminId,
  });

  @override
  State<CollaboratorPanelPage> createState() => _CollaboratorPanelPageState();
}

class _CollaboratorPanelPageState extends State<CollaboratorPanelPage> {
  final adminProvider = Modular.get<AdminProvider>();
  List<CollaboratorEntity> collaborators = [];

  @override
  void initState() {
    super.initState();
    getCollaborators();
  }

  void getCollaborators() async {
    await adminProvider.getCollaboratorsByResponsibleId(
      id: widget.adminId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              AppDimensions.radiusExtraLarge,
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 5,
                offset: Offset(
                  0,
                  3,
                ),
              ),
            ],
          ),
          child: Container(
            width: double.infinity,
            color: AppColors.primary,
            padding: const EdgeInsets.only(
              top: AppDimensions.paddingMedium,
              left: AppDimensions.paddingSmall,
              right: AppDimensions.paddingSmall,
              bottom: AppDimensions.paddingSmall,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.emoji_people_rounded,
                  size: AppDimensions.iconLarge,
                  color: AppColors.secondary,
                ),
                Text(
                  'Consultar Colaboradores',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: AppColors.secondary,
                        fontSize: AppDimensions.fontLarge,
                        fontWeight: FontWeight.bold,
                      ),
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingMedium,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: AppDimensions.paddingMedium,
                ),
                CollaboratorPanelSearchBarWidget(
                  adminId: widget.adminId,
                ),
                Expanded(
                  child: Consumer<AdminProvider>(
                    builder: (context, adminProvider, _) {
                      if (adminProvider.isLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return CollaboratorPaginationWidget(
                        collaborators: adminProvider.collaborators ?? [],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
