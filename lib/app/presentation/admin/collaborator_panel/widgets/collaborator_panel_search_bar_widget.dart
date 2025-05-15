import 'package:tcc_bag_finder/app/presentation/admin/stores/admin_provider.dart';
import 'package:tcc_bag_finder/app/presentation/traveler/home/widget/appbar/home_search_field_widget.dart';
import 'package:tcc_bag_finder/app/shared/objects/filter_option_object.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_colors.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_dimensions.dart';
import 'package:tcc_bag_finder/app/shared/widgets/filter_side_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CollaboratorPanelSearchBarWidget extends StatefulWidget {
  final String adminId;

  const CollaboratorPanelSearchBarWidget({
    super.key,
    required this.adminId,
  });

  @override
  State<CollaboratorPanelSearchBarWidget> createState() =>
      _CollaboratorPanelSearchBarWidgetState();
}

class _CollaboratorPanelSearchBarWidgetState
    extends State<CollaboratorPanelSearchBarWidget> {
  bool isAscendingAlphabetic = false;
  bool isAscendingByCreatedTime = false;
  bool isAscendingByStatus = false;

  @override
  Widget build(BuildContext context) {
    final adminProvider = Modular.get<AdminProvider>();

    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: HomeSearchFieldWidget(
            hint: 'Procure seu colaborador...',
            onChanged: (text) async {
              await adminProvider.getCollaboratorsByName(
                name: text,
                responsibleId: widget.adminId,
              );
            },
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.filter_list,
            size: AppDimensions.iconLarge,
            color: AppColors.primary,
          ),
          onPressed: () => showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            useRootNavigator: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(AppDimensions.radiusLarge),
              ),
            ),
            builder: (context) => FilterSidebar(
              options: [
                FilterOption(
                  icon: Icons.abc,
                  label: 'A-Z',
                  onTap: () {
                    adminProvider.orderByAlphabetic(
                      list: adminProvider.collaborators ?? [],
                      isAscending: isAscendingAlphabetic,
                    );
                    setState(() {
                      isAscendingAlphabetic = !isAscendingAlphabetic;
                    });
                  },
                  iconColor: AppColors.secondary,
                ),
                FilterOption(
                  icon: Icons.calendar_month,
                  label: 'Data de cadastro',
                  onTap: () {
                    adminProvider.orderByCreatedTime(
                      list: adminProvider.collaborators ?? [],
                      isAscending: isAscendingByCreatedTime,
                    );
                    setState(() {
                      isAscendingByCreatedTime = !isAscendingByCreatedTime;
                    });
                  },
                  iconColor: AppColors.secondary,
                ),
                FilterOption(
                  icon: Icons.check_circle,
                  label: 'Ativo',
                  onTap: () {
                    adminProvider.orderByStatus(
                      list: adminProvider.collaborators ?? [],
                      isAscending: isAscendingByStatus,
                    );
                    setState(() {
                      isAscendingByStatus = !isAscendingByStatus;
                    });
                  },
                  iconColor: AppColors.secondary,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
