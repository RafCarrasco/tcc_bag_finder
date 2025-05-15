import 'package:tcc_bag_finder/app/shared/themes/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_colors.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_dimensions.dart';
import 'package:tcc_bag_finder/domain/entity/trip_entity.dart';

class GetDescriptionDialogWidget extends StatelessWidget {
  final TripEntity trip;

  const GetDescriptionDialogWidget({
    super.key,
    required this.trip,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingMedium,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          AppDimensions.radiusLarge,
        ),
      ),
      titlePadding: EdgeInsets.zero,
      contentPadding: const EdgeInsets.only(
        bottom: AppDimensions.paddingSmall,
      ),
      title: Container(
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(
              AppDimensions.radiusLarge,
            ),
            topRight: Radius.circular(
              AppDimensions.radiusLarge,
            ),
          ),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: AppDimensions.paddingMedium,
        ),
        alignment: Alignment.center,
        width: double.infinity,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppIconsSecondary.descriptionIcon,
            const SizedBox(
              width: 5,
            ),
            Text(
              'Detalhes da Viagem',
              style: TextStyle(
                fontSize: AppDimensions.fontLarge,
                fontWeight: FontWeight.bold,
                color: AppColors.secondary,
              ),
            ),
          ],
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildRoundedInfoContainer(
            label: 'ID',
            value: trip.id,
          ),
          _buildRoundedInfoContainer(
            label: 'Colaborador Responsável',
            value: trip.responsibleCollaboratorId,
          ),
          _buildRoundedInfoContainer(
            label: 'Aeroporto de Origem',
            value: trip.description.airportOrigin,
          ),
          _buildRoundedInfoContainer(
            label: 'Aeroporto de Destino',
            value: trip.description.airportDestination,
          ),
          _buildRoundedInfoContainer(
            label: 'Data e Hora',
            value: trip.time.toString(),
          ),
          _buildRoundedInfoContainer(
            label: 'Malas',
            value: trip.bags != null ? trip.bags!.length.toString() : '0',
          ),
          _buildRoundedInfoContainer(
            label: 'Status',
            value: trip.isDone ? "Concluído" : "Pendente",
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'Fechar',
          ),
        ),
      ],
    );
  }

  Widget _buildRoundedInfoContainer({
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingLarge,
        vertical: AppDimensions.paddingSmall,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: AppDimensions.paddingSmall,
          horizontal: AppDimensions.paddingMedium,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            AppDimensions.radiusSmall,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.secondaryGrey,
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(
                0,
                3,
              ),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              '$label: ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
                fontSize: AppDimensions.fontSmall,
              ),
            ),
            Expanded(
              child: Text(
                value,
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: AppDimensions.fontSmall,
                  color: AppColors.secondaryGrey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
