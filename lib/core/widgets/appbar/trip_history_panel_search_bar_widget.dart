import 'package:bag_finder/shared/providers/bag_status_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_dimensions.dart';
import '../../utils/objects/filter_option_object.dart';
import '../filter_side_bar.dart';
import 'home_search_field_widget.dart';

class TripHistoryPanelSearchBarWidget extends StatefulWidget {
  final String hint;
  final String travelerId;
  const TripHistoryPanelSearchBarWidget({
    super.key,
    required this.hint,
    required this.travelerId
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
    return Consumer<RfidBagProvider>(
      builder: (context, bagStatusProvider, _) {
        return Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: HomeSearchFieldWidget(
                hint: widget.hint,
                onChanged: (text) async {
                  if (text.trim().isEmpty) {
                    await bagStatusProvider.loadUserBags(widget.travelerId);
                  } else {
                    await bagStatusProvider.loadBagsByPrinted(
                      text,
                      widget.travelerId,
                    );
                  }
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
                        setState(() {
                          isAscendingByCreatedTime =
                              !isAscendingByCreatedTime;
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
      },
    );
  }
}
