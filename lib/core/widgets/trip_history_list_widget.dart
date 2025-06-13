import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../entity/trip_entity.dart';
import '../provider/traveler_provider.dart';
import '../utils/app_colors.dart';
import '../utils/app_dimensions.dart';
import 'trip_history_header_widget.dart';
import 'trip_history_pagination_widget.dart';

class TripHistoryListPage extends StatefulWidget {
  final String travelerId;
  final List<TripEntity> trips;
  final List<String> collaboratorsNames;

  const TripHistoryListPage({
    super.key,
    required this.travelerId,
    required this.trips,
    required this.collaboratorsNames,
  });

  @override
  State<TripHistoryListPage> createState() => _TripHistoryListPageState();
}

class _TripHistoryListPageState extends State<TripHistoryListPage> {
  final travelerProvider = Modular.get<TravelerProvider>();

  DateTime get date =>
      travelerProvider.currentTrip?.createdAt ?? DateTime.now();
  String get airportDestination =>
      travelerProvider.currentTrip?.description.airportDestination ?? '';
  String get airportOrigin =>
      travelerProvider.currentTrip?.description.airportOrigin ?? '';

  @override
  void initState() {
    super.initState();
    getTrips();
  }

  void getTrips() async {
    await travelerProvider.getTripsByStatus(
      travelerId: widget.travelerId,
      isDone: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (travelerProvider.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingMedium,
          ),
          child: TripHistoryHeaderWidget(
            activeTripsCount: travelerProvider.currentTrip != null ? 1 : 0,
            tripsCount: widget.trips.length,
          ),
        ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 10.0,
          ),
          child: Divider(
            color: AppColors.secondaryGrey.withOpacity(
              0.3,
            ),
            thickness: 4,
          ),
        ),
        Expanded(
          child: TripHistoryPaginationWidget(
            trips: travelerProvider.trips ?? [],
            collaboratorsNames: widget.collaboratorsNames,
            airportOriginCode: airportOrigin,
            airportDestinationCode: airportDestination,
          ),
        ),
      ],
    );
  }
}
