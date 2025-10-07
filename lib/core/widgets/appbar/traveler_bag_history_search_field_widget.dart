import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:bag_finder/shared/providers/trip_provider.dart';
import '../../../shared/providers/traveler_provider.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_dimensions.dart';
import '../../utils/objects/filter_option_object.dart';
import '../filter_side_bar.dart';
import 'home_search_field_widget.dart';

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
  final tripProvider = Modular.get<TripProvider>();

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
            await tripProvider.getTripById(
              value,
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
                    // tripProvider.orderBagsByUpdatedTime(
                    //   list: travelerProvider.bags ?? [],
                    //   isAscending: isAscendingByUpdatedTime,
                    // );
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
                    // travelerProvider.orderBagsByStatus(
                    //   list: travelerProvider.bags ?? [],
                    //   isAscending: isAscendingByUpdatedTime,
                    // );
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
