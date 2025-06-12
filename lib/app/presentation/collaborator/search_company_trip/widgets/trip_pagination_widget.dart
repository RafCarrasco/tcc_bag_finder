import 'package:tcc_bag_finder/app/presentation/collaborator/search_company_trip/dialogs/get_description_dialog_widget.dart';
import 'package:tcc_bag_finder/app/presentation/collaborator/search_company_trip/dialogs/send_notification_dialog_widget.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_colors.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_dimensions.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_icons.dart';
import 'package:tcc_bag_finder/domain/entity/trip_entity.dart';
import 'package:flutter/material.dart';

class TripPaginationWidget extends StatefulWidget {
  final List<TripEntity> trips;

  const TripPaginationWidget({
    super.key,
    required this.trips,
  });

  @override
  State<TripPaginationWidget> createState() => _TripPaginationWidgetState();
}

class _TripPaginationWidgetState extends State<TripPaginationWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.trips.isEmpty) {
      return const Center(
        child: Text(
          "Nenhuma viagem encontrada",
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
      itemCount: widget.trips.length,
      itemBuilder: (context, index) {
        final trip = widget.trips[index];
        return ListTile(
          shape: Border(
            left: BorderSide(
              color: AppColors.primary,
              width: AppDimensions.borderThin,
            ),
          ),
          style: ListTileStyle.list,
          title: Row(
            children: [
              AppIconsPrimary.personIcon,
              Text(
                '(${trip.travelerEntity.id.substring(0, 4)})',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                trip.travelerEntity.fullName,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(),
              ),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  AppIconsPrimary.calendarIcon,
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    trip.createdAt.toString(),
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: AppColors.secondaryGrey,
                        ),
                  ),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  Text(
                    'Status: ',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: AppColors.secondaryGrey,
                        ),
                  ),
                  Icon(
                    Icons.circle,
                    color: trip.isDone ? AppColors.green : AppColors.red,
                    size: AppDimensions.iconSmall,
                  ),
                ],
              ),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: AppIconsSecondaryGrey.notificationIcon,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return SendNotificationDialogWidget(
                        onConfirm: () {},
                        trip: trip,
                      );
                    },
                  );
                },
              ),
              IconButton(
                icon: AppIconsSecondaryGrey.descriptionIcon,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return GetDescriptionDialogWidget(
                        trip: trip,
                      );
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
