import 'package:bag_finder/core/entity/bag_status_entity.dart';
import 'package:flutter/material.dart';
import '../utils/app_dimensions.dart';
import 'bag_item_widget.dart';

class BagPaginationWidget extends StatelessWidget {
  final List<BagStatusEntity> bags;
  final String airportOriginCode;
  final String airportDestinationCode;

  const BagPaginationWidget({
    super.key,
    required this.bags,
    required this.airportOriginCode,
    required this.airportDestinationCode,
  });

  @override
  Widget build(BuildContext context) {
    if (bags.isEmpty) {
      return const Center(
        child: Text(
          "Nenhum colaborador encontrado",
        ),
      );
    }

    return ListView.separated(
      separatorBuilder: (context, index) => const Divider(
        color: Colors.transparent,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: AppDimensions.paddingLarge,
        horizontal: AppDimensions.paddingMedium,
      ),
      itemCount: bags.length,
      itemBuilder: (context, index) {
        final bag = bags[index];
        return BagItemWidget(
          bagStatus: bag,
        );
      },
    );
  }
}
