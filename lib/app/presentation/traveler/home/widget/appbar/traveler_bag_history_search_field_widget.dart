import 'package:tcc_bag_finder/app/presentation/traveler/home/widget/appbar/home_search_field_widget.dart';
import 'package:tcc_bag_finder/app/presentation/traveler/stores/traveler_provider.dart';
import 'package:tcc_bag_finder/app/shared/objects/filter_option_object.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_colors.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_dimensions.dart';
import 'package:tcc_bag_finder/app/shared/widgets/filter_side_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class TravelerBagHistorySearchFieldWidget extends StatefulWidget {
  final String hint;
  const TravelerBagHistorySearchFieldWidget({
    super.key,
    required this.hint,
  });

  @override
  State<TravelerBagHistorySearchFieldWidget> createState() => _TravelerBagHistorySearchFieldWidgetState();
}

class _TravelerBagHistorySearchFieldWidgetState extends State<TravelerBagHistorySearchFieldWidget> {
  var travelerProvider = Modular.get<TravelerProvider>();

  bool isAscendingByUpdatedTime = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        HomeSearchFieldWidget(
          hint: widget.hint,
          onChanged: (value) async {
            await travelerProvider.getTripsById(
              tripId: value,
            );
          },
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
                top: Radius.circular(
                  AppDimensions.radiusLarge,
                ),
              ),
            ),
            builder: (context) => FilterSidebar(
              options: [
                FilterOption(
                  icon: Icons.check_circle,
                  label: 'Data de atualização',
                  onTap: () {
                    travelerProvider.orderBagsByUpdatedTime(
                      list: travelerProvider.bags ?? [],
                      isAscending: isAscendingByUpdatedTime,
                    );
                    setState(() {
                      isAscendingByUpdatedTime = !isAscendingByUpdatedTime;
                    });
                  },
                  iconColor: AppColors.secondary,
                ),
                FilterOption(
                  icon: Icons.check_circle,
                  label: 'Status',
                  onTap: () {
                    travelerProvider.orderBagsByStatus(
                      list: travelerProvider.bags ?? [],
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
