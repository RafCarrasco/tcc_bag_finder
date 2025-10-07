import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';
import '../../entity/bag_entity.dart';
import '../../../shared/providers/traveler_provider.dart';
import '../../utils/app_dimensions.dart';
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

  String? selectedPrintedCode;

  @override
  void initState() {
    super.initState();
    travelerProvider.checkIsTripDone(
      trip: travelerProvider.currentTrip!,
    );
  }

  String _mapStatus(String status) {
    switch (status) {
      case 'DELIVERED':
        return 'Entregue';
      case 'IN_TRANSIT':
        return 'Em trânsito';
      case 'CHECKED_IN':
        return 'Despachada';
      case 'CREATED':
        return 'Criada';
      default:
        return status;
    }
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'DELIVERED':
        return Colors.green;
      case 'IN_TRANSIT':
        return Colors.orange;
      case 'CHECKED_IN':
        return Colors.blue;
      case 'CREATED':
        return Colors.grey;
      default:
        return Colors.black87;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<BagEntity> filteredBags = widget.bags;
    if (selectedPrintedCode != null && selectedPrintedCode!.isNotEmpty) {
      filteredBags = widget.bags.where((bag) => bag.printedCode == selectedPrintedCode).toList();
    }

    return Column(
      children: [
        // Adiciona o Dropdown para selecionar o printedCode
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingMedium,
            vertical: AppDimensions.paddingSmall,
          ),
          child: DropdownButton<String>(
            hint: Text('Selecione uma mala'),
            value: selectedPrintedCode,
            onChanged: (String? newValue) {
              setState(() {
                selectedPrintedCode = newValue;
              });
            },
            items: widget.bags.map<DropdownMenuItem<String>>((BagEntity bag) {
              return DropdownMenuItem<String>(
                value: bag.printedCode,
                child: Text(bag.printedCode ?? "Sem código"),
              );
            }).toList(),
          ),
        ),

        const SizedBox(height: 8),

        // Exibe a lista de malas filtradas ou todas as malas
        Consumer<TravelerProvider>(
          builder: (context, provider, child) {
            if (filteredBags.isEmpty) {
              return const Center(
                child: Text(
                  "Nenhuma bagagem registrada nesta viagem.",
                  style: TextStyle(fontSize: 16),
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredBags.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final bag = filteredBags[index];

                bool isEmbarque = index % 2 == 0; 
                String title = isEmbarque ? "Embarque ${airportOrigin}" : "Desembarque ${airportDestination}";

                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading:
                        const Icon(Icons.luggage, color: Colors.blueGrey),
                    title: Text(title),
                    subtitle: Text(
                      "Status: ${_mapStatus(bag.status.name)}",
                      style: TextStyle(
                        color: _statusColor(bag.status.name),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onTap: () {                    
                    },
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
