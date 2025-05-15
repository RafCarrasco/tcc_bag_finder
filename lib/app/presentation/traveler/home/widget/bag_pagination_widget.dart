import 'package:tcc_bag_finder/app/presentation/traveler/home/widget/bag_item_widget.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_dimensions.dart';
import 'package:tcc_bag_finder/domain/entity/bag_entity.dart';
import 'package:flutter/material.dart';

class BagPaginationWidget extends StatelessWidget {
  final List<BagEntity> bags;
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
          bag: bag,
        );
      },
    );
  }
}
