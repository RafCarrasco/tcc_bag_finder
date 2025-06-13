import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';

import '../entity/bag_entity.dart';
import '../provider/traveler_provider.dart';
import '../utils/app_colors.dart';
import '../utils/app_dimensions.dart';
import 'bag_pagination_widget.dart';
import 'trip_header_widget.dart';

class TripListWidget extends StatefulWidget {
  final String travelerId;
  final List<BagEntity> bags;
  final String collaboratorName;

  const TripListWidget({
    super.key,
    required this.travelerId,
    required this.bags,
    required this.collaboratorName,
  });

  @override
  State<TripListWidget> createState() => _TripListWidgetState();
}

class _TripListWidgetState extends State<TripListWidget> {
  final travelerProvider = Modular.get<TravelerProvider>();

  DateTime get date => travelerProvider.currentTrip!.createdAt;
  String get airportDestination =>
      travelerProvider.currentTrip!.description.airportDestination;
  String get airportOrigin =>
      travelerProvider.currentTrip!.description.airportOrigin;

  @override
  void initState() {
    super.initState();
    travelerProvider.checkIsTripDone(
      trip: travelerProvider.currentTrip!,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingMedium,
          ),
          child: Selector<TravelerProvider, int>(
            selector: (_, provider) => provider.checkedBags,
            builder: (context, checkedBags, child) {
              if (checkedBags == widget.bags.length) {
                travelerProvider.checkTripCompletion();
              }

              return TripHeaderWidget(
                airportDestination: airportDestination,
                airportOrigin: airportOrigin,
                tripId: travelerProvider.currentTrip!.id,
                date: date,
                collaboratorName: widget.collaboratorName,
                checkedBags: checkedBags,
                bags: widget.bags.length,
              );
            },
          ),
        ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 10.0,
          ),
          child: Divider(
            color: AppColors.secondaryGrey.withOpacity(0.3),
            thickness: 4,
          ),
        ),
        Consumer<TravelerProvider>(
          builder: (context, provider, child) {
            if (provider.isTripComplete) {
              return Expanded(
                child: Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: AppColors.primary,
                        size: 100,
                      ),
                      Text(
                        'Todos os bagagens foram entregues',
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Expanded(
                child: BagPaginationWidget(
                  bags: widget.bags,
                  airportOriginCode:
                      travelerProvider.currentTrip!.description.airportOrigin,
                  airportDestinationCode: travelerProvider
                      .currentTrip!.description.airportDestination,
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
