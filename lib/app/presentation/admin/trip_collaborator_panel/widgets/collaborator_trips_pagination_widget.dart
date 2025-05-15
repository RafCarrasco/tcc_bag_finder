import 'package:tcc_bag_finder/app/presentation/admin/stores/admin_provider.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_colors.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_dimensions.dart';
import 'package:tcc_bag_finder/domain/entity/trip_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CollaboratorTripsPaginationWidget extends StatefulWidget {
  final List<TripEntity> trips;

  const CollaboratorTripsPaginationWidget({
    super.key,
    required this.trips,
  });

  @override
  State<CollaboratorTripsPaginationWidget> createState() =>
      _CollaboratorTripsPaginationWidgetState();
}

class _CollaboratorTripsPaginationWidgetState
    extends State<CollaboratorTripsPaginationWidget> {
  Future<void> getCollaboratorTrips({
    required String collaboratorId,
  }) async {
    await Modular.get<AdminProvider>().getCollaboratorTripsByCollaboratorId(
      collaboratorId: collaboratorId,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.trips.isEmpty) {
      return const Center(
        child: Text("Nenhuma viagem encontrada"),
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
          title: Text(
            'ID: ${trip.id}',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          subtitle: buildTripTripsDetails(
            context,
            trip,
          ),
        );
      },
    );
  }

  Widget buildTripTripsDetails(
    BuildContext context,
    TripEntity trip,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildInfoRow(
          context,
          'Bagagens Criadas: ',
          trip.bags == null ? 0.toString() : trip.bags!.length.toString(),
        ),
        buildInfoRow(
          context,
          'Data de Criação: ',
          trip.createdAt.toString(),
        ),
        buildInfoRow(
          context,
          'Viagem Concluída: ',
          trip.isDone ? "Sim" : "Não",
        ),
      ],
    );
  }

  Widget buildInfoRow(
    BuildContext context,
    String label,
    String value,
  ) {
    return Row(
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: AppColors.secondaryGrey,
              ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: AppColors.secondaryGrey,
              ),
        ),
      ],
    );
  }
}
