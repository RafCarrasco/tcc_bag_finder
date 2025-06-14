import 'package:tcc_bag_finder/app/presentation/collaborator/stores/collaborator_provider.dart';
import 'package:tcc_bag_finder/app/presentation/traveler/home/widget/appbar/home_search_field_widget.dart';
import 'package:tcc_bag_finder/app/shared/objects/filter_option_object.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_colors.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_dimensions.dart';
import 'package:tcc_bag_finder/app/shared/widgets/filter_side_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class TripPanelSearchBarWidget extends StatefulWidget {
  const TripPanelSearchBarWidget({
    super.key,
  });

  @override
  State<TripPanelSearchBarWidget> createState() =>
      _TripPanelSearchBarWidgetState();
}

class _TripPanelSearchBarWidgetState extends State<TripPanelSearchBarWidget> {
  bool isAscendingAlphabetic = false;
  bool isAscendingByCreatedTime = false;
  bool isAscendingByStatus = false;

  @override
  Widget build(BuildContext context) {
    final collaboratorProvider = Modular.get<CollaboratorProvider>();

    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: HomeSearchFieldWidget(
            hint: 'Procure as viagens do passageiro (ID)...',
            onChanged: (text) async {
              await collaboratorProvider.getAllTripsByTraveler(
                travelerId: text,
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
                    collaboratorProvider.orderByAlphabetic(
                      list: collaboratorProvider.trips ?? [],
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
                    collaboratorProvider.orderByCreatedTime(
                      list: collaboratorProvider.trips ?? [],
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
                    collaboratorProvider.orderByStatus(
                      list: collaboratorProvider.trips ?? [],
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
