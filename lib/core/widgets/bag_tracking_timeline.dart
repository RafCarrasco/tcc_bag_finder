import 'package:bag_finder/core/entity/bag_status_entity.dart';
import 'package:flutter/material.dart';
import '../../../core/enums/bag_status_enum.dart';
import '../../../core/utils/app_colors.dart';

class BagTrackingTimeline extends StatefulWidget {
  final BagStatusEntity? bagStatus;
  final BagStatusEnum currentStatus;
  final bool hasConnection;
  final bool showFullTimeline;

  const BagTrackingTimeline({
    super.key,
    required this.bagStatus,
    required this.currentStatus,
    this.hasConnection = false,
    required this.showFullTimeline,
  });

  @override
  State<BagTrackingTimeline> createState() => _BagTrackingTimelineState();
}

class _BagTrackingTimelineState extends State<BagTrackingTimeline> {
  
  List<_TimelineStep> get _steps {
    if (widget.bagStatus == null) {
      return [
        _TimelineStep("Registrada", Icons.home, BagStatusEnum.CHECKED_IN),
        _TimelineStep("Em Trânsito (1º Trecho)", Icons.flight_takeoff, BagStatusEnum.IN_TRANSIT),
        _TimelineStep("Chegada (Conexão)", Icons.flight_land, BagStatusEnum.ARRIVED_AT_CONNECTION),
        _TimelineStep("Em Trânsito (2º Trecho)", Icons.flight_takeoff, BagStatusEnum.IN_TRANSIT_CONNECTION),
        _TimelineStep("Chegada no Destino", Icons.flight_land, BagStatusEnum.ARRIVED),
        _TimelineStep("Retirada", Icons.check_circle, BagStatusEnum.COLLECTED),
        _TimelineStep("Pronta para Retirada", Icons.luggage, BagStatusEnum.READY_FOR_PICKUP),
      ];
    } else {
      return [
        _TimelineStep("Registrada", Icons.home, BagStatusEnum.CHECKED_IN),
        _TimelineStep("Em Trânsito", Icons.flight_takeoff, BagStatusEnum.IN_TRANSIT),
        _TimelineStep("Chegada (Conexão)", Icons.flight_land, BagStatusEnum.ARRIVED_AT_CONNECTION),
        _TimelineStep("Em Trânsito (2º Trecho)", Icons.flight_takeoff, BagStatusEnum.IN_TRANSIT_CONNECTION),
        _TimelineStep("Chegada no Destino", Icons.flight_land, BagStatusEnum.ARRIVED),
        _TimelineStep("Pronta para Retirada", Icons.luggage, BagStatusEnum.READY_FOR_PICKUP),
      ];
    }
  }

  int _getCurrentIndex() {
    return _steps.indexWhere((s) => s.status == widget.currentStatus);
  }

  Color _getColor(int index, int currentIndex) {
    const Color amberColor = Color.fromARGB(255, 255, 193, 7); 
    
    final Color primaryColor = AppColors.primary;

    if (index < currentIndex) return primaryColor;
    if (index == currentIndex) return amberColor; 
    return Colors.grey;
  }

  String _getSubtitle(int index, int currentIndex, bool isLastGreen) {
    if (index < currentIndex) {
      if (currentIndex == _steps.length - 1 && index == currentIndex - 1) {
        return "Última localização";
      }
      return "Ponto verificado";
    }
    if (index == currentIndex) return "Próxima localização";
    return "Ponto ainda não verificado";
  }


  @override
  Widget build(BuildContext context) {
    final currentIndex = _getCurrentIndex();
    final screenWidth = MediaQuery.of(context).size.width;
    final isCompactScreen = screenWidth < 600;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        AnimatedCrossFade(
          duration: const Duration(milliseconds: 300),
          crossFadeState: widget.showFullTimeline
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          firstChild: Column(
            children: List.generate(_steps.length, (index) {
              final step = _steps[index];
              final color = _getColor(index, currentIndex);
              final subtitle = _getSubtitle(index, currentIndex, currentIndex > 0);

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(step.icon, color: color, size: isCompactScreen ? 20 : 24),
                    const SizedBox(width: 10),
                    Expanded( 
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FittedBox( 
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              step.title,
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: color, fontSize: isCompactScreen ? 13 : 14),
                            ),
                          ),
                          FittedBox( 
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              subtitle,
                              style: TextStyle(fontSize: isCompactScreen ? 11 : 12, color: Colors.black54),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
          secondChild: _buildCompactView(currentIndex, isCompactScreen),
        ),
      ],
    );
  }

  Widget _buildCompactView(int currentIndex, bool isCompactScreen) {
    final step = _steps.isEmpty || currentIndex < 0 ? _TimelineStep("Status Indefinido", Icons.help_outline, BagStatusEnum.NAO_CADASTRADA) : _steps[currentIndex];
    final color = _getColor(currentIndex, currentIndex);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color, width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible( 
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: color,
                    fontSize: isCompactScreen ? 14 : 16,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Estado atual: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: step.title,
                      style: TextStyle(fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Icon(step.icon, color: color, size: isCompactScreen ? 22 : 26),
        ],
      ),
    );
  }
}

class _TimelineStep {
  final String title;
  final IconData icon;
  final BagStatusEnum status;

  _TimelineStep(this.title, this.icon, this.status);
}
