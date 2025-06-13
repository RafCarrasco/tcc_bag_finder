import 'package:flutter/material.dart';
import 'package:tcc_bag_finder/domain/enums/bag_status_enum.dart';
import 'package:tcc_bag_finder/domain/entity/bag_entity.dart';


class BagTrackingTimeline extends StatelessWidget {
  final BagStatusEnum currentStatus;

  const BagTrackingTimeline({super.key, required this.currentStatus});

  @override
  Widget build(BuildContext context) {
    final List<_StatusStep> steps = [
      _StatusStep(BagStatusEnum.CHECKED_IN, Icons.home),
      _StatusStep(BagStatusEnum.IN_TRANSIT, Icons.flight_takeoff),
      _StatusStep(BagStatusEnum.ARRIVED, Icons.flight_land),
      _StatusStep(BagStatusEnum.READY_FOR_PICKUP, Icons.luggage),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: steps.map((step) {
        final isCompleted = currentStatus.index > step.status.index;
        final isCurrent = currentStatus == step.status;
        final color = isCompleted
            ? Colors.green
            : isCurrent
                ? Colors.orange
                : Colors.grey;

        return Column(
          children: [
            Icon(step.icon, color: color, size: 20),
            const SizedBox(height: 4),
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              step.status.toLiteral(),
              style: TextStyle(fontSize: 10, color: color),
              textAlign: TextAlign.center,
            ),
          ],
        );
      }).toList(),
    );
  }
}

class _StatusStep {
  final BagStatusEnum status;
  final IconData icon;

  _StatusStep(this.status, this.icon);
}

// USO:
// BagTrackingTimeline(currentStatus: BagStatusEnum.ARRIVED),
