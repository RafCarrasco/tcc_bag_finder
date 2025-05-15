import 'package:tcc_bag_finder/app/presentation/traveler/home/widget/appbar/home_search_field_widget.dart';
import 'package:tcc_bag_finder/app/presentation/traveler/stores/traveler_provider.dart';
import 'package:tcc_bag_finder/app/shared/objects/filter_option_object.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_colors.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_dimensions.dart';
import 'package:tcc_bag_finder/app/shared/widgets/filter_side_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class TripHistoryPanelSearchBarWidget extends StatefulWidget {
  final String hint;
  const TripHistoryPanelSearchBarWidget({
    super.key,
    required this.hint,
  });

  @override
  State<TripHistoryPanelSearchBarWidget> createState() =>
      _TripHistoryPanelSearchBarWidgetState();
}

class _TripHistoryPanelSearchBarWidgetState
    extends State<TripHistoryPanelSearchBarWidget> {
  bool isAscendingByCreatedTime = false;
  bool isAscendingByUpdatedTime = false;

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
            hint: widget.hint,
            onChanged: (text) async {
              await travelerProvider.getTripsById(
                tripId: text,
              );
            },
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.filter_list,
            size: AppDimensions.iconLarge,
            color: AppColors.secondary,
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
                  icon: Icons.calendar_month,
                  label: 'Data de cadastro',
                  onTap: () {
                    travelerProvider.orderTripsByCreatedTime(
                      list: travelerProvider.trips ?? [],
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
                  label: 'Data de atualização',
                  onTap: () {
                    travelerProvider.orderTripsByUpdatedTime(
                      list: travelerProvider.trips ?? [],
                      isAscending: isAscendingByUpdatedTime,
                    );
                    setState(() {
                      isAscendingByUpdatedTime = !isAscendingByUpdatedTime;
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
