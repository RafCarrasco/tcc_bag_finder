import 'package:tcc_bag_finder/app/presentation/traveler/home/widget/appbar/home_search_field_widget.dart';
import 'package:tcc_bag_finder/app/presentation/traveler/stores/traveler_provider.dart';
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
    final travelerProvider = Modular.get<TravelerProvider>();

    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: HomeSearchFieldWidget(
            hint: 'Procure sua mala...',
            onChanged: (text) async {
              await travelerProvider.getBagsById(
                bagId: text,
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
                  label: 'A-Z (Descrição)',
                  onTap: () {
                    travelerProvider.orderBagsAlphabetic(
                      list: travelerProvider.bags ?? [],
                      isAscending: isAscendingAlphabetic,
                    );
                    setState(() {
                      isAscendingAlphabetic = !isAscendingAlphabetic;
                    });
                  },
                  iconColor: AppColors.secondary,
                ),
                FilterOption(
                  icon: Icons.abc,
                  label: 'Status',
                  onTap: () {
                    travelerProvider.orderBagsByDoneStatus(
                      list: travelerProvider.bags ?? [],
                      isAscending: isAscendingAlphabetic,
                    );
                    setState(() {
                      isAscendingAlphabetic = !isAscendingAlphabetic;
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
