// lib/core/widgets/bag_tracking_timeline.dart
import 'package:flutter/material.dart';
import 'package:bag_finder/core/enums/bag_status_enum.dart';
import 'package:bag_finder/core/utils/app_dimensions.dart';

class BagTrackingTimelineVertical extends StatelessWidget {
  final List<BagStatusEnum> statuses;
  final BagStatusEnum? current;

  const BagTrackingTimelineVertical({
    super.key,
    required this.statuses,
    this.current,
  });

  Color _colorFor(BagStatusEnum status, BagStatusEnum? current) {
    if (current == null) return Colors.grey;
    if (status == current) return Colors.orange;
    if (status.index < current.index) return Colors.green;
    return Colors.grey;
  }

  IconData _iconFor(BagStatusEnum status) {
    switch (status) {
      case BagStatusEnum.CHECKED_IN:
        return Icons.home;
      case BagStatusEnum.IN_TRANSIT:
        return Icons.flight_takeoff;
      case BagStatusEnum.ARRIVED:
        return Icons.flight_land;
      case BagStatusEnum.READY_FOR_PICKUP:
        return Icons.luggage;
      default:
        return Icons.adjust;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (statuses.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: List.generate(statuses.length, (i) {
        final status = statuses[i];
        final color = _colorFor(status, current);
        final isLast = i == statuses.length - 1;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // descrição à esquerda
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10, horizontal: AppDimensions.paddingSmall),
                child: Text(
                  status.toLiteral(),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight:
                        status == current ? FontWeight.bold : FontWeight.w600,
                    color: color,
                  ),
                ),
              ),
            ),

            // conector + ícone à direita
            Column(
              children: [
                // ícone
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _iconFor(status),
                    size: 20,
                    color: color,
                  ),
                ),
                // conector vertical (se não for o último)
                if (!isLast)
                  Container(
                    width: 2,
                    height: 36,
                    margin: const EdgeInsets.only(top: 4),
                    color: Colors.grey.shade300,
                  ),
              ],
            ),
          ],
        );
      }),
    );
  }
}
