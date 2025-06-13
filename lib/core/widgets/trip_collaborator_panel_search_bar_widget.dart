import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../provider/admin_provider.dart';
import '../utils/app_colors.dart';
import '../utils/app_dimensions.dart';
import '../utils/objects/filter_option_object.dart';
import 'appbar/home_search_field_widget.dart';
import 'filter_side_bar.dart';

class TripCollaboratorPanelSearchBarWidget extends StatefulWidget {
  final String adminId;

  const TripCollaboratorPanelSearchBarWidget({
    required this.adminId,
    super.key,
  });

  @override
  State<TripCollaboratorPanelSearchBarWidget> createState() =>
      _TripCollaboratorPanelSearchBarWidgetState();
}

class _TripCollaboratorPanelSearchBarWidgetState
    extends State<TripCollaboratorPanelSearchBarWidget> {
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
                top: Radius.circular(
                  AppDimensions.radiusLarge,
                ),
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
