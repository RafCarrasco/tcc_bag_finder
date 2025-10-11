import 'package:flutter/material.dart';

import '../entity/trip_entity.dart';
import '../utils/app_colors.dart';
import '../utils/app_dimensions.dart';
import '../utils/app_icons.dart';
import 'dialogs/get_description_dialog_widget.dart';
import 'dialogs/send_notification_dialog_widget.dart';

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
                '(${(trip.cpf?.length ?? 0) >= 4 ? trip.cpf?.substring(0, 4) ?? '' : trip.cpf ?? ''})',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(width: 5),
              Text(
                trip.cpf ?? '',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(),
              ),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  AppIconsPrimary.calendarIcon,
                  const SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      '${trip.origin} → ${trip.destination}',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: AppColors.secondaryGrey,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                ],
              ),
              if (trip.connection != null && trip.connection!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 2, left: 28),
                  child: Text(
                    'Conexão: ${trip.connection}',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: AppColors.secondaryGrey,
                        ),
                  ),
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
