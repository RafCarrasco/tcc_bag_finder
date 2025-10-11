import 'package:bag_finder/core/enums/bag_status_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../shared/providers/traveler_provider.dart';
import '../../../shared/providers/bag_status_provider.dart';
import '../../../shared/providers/user_provider.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_dimensions.dart';
import '../../../core/widgets/appbar/history_app_bar_widget.dart';
import '../../../core/widgets/trip_list_widget.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../collaborator/controllers/init_user_trip_controller.dart';
import '../../../core/utils/global_snackbar.dart';
import 'dart:convert';

class HomeTravelerPage extends StatefulWidget {
  final String travelerId;

  const HomeTravelerPage({
    super.key,
    required this.travelerId,
  });

  @override
  State<HomeTravelerPage> createState() => _HomeTravelerPageState();
}

class _HomeTravelerPageState extends State<HomeTravelerPage> {
  final travelerProvider = Modular.get<TravelerProvider>();
  var provider = Modular.get<UserProvider>();
  late String? collaboratorName;
  late WebSocketChannel _channel;
  bool isLoading = true;
  final _controller = Modular.get<InitUserTripController>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late RfidBagProvider _rfidProvider;
  final _tagControllers = <TextEditingController>[];
  final _printedCodeControllers = <TextEditingController>[];
  int _currentBagCount = 0;

  @override
  void initState() {
    super.initState();
    init();
    final baseUrl = dotenv.env['BASE_URL']!;
    final wsUrl = baseUrl.replaceFirst('http', 'ws');
    _channel = WebSocketChannel.connect(
      Uri.parse(wsUrl),
      );
    _channel.stream.listen((message) {
      _handleRfidMessage(message.toString());
    });
  }

  void init() async {
    await travelerProvider.getBagsByUserId(widget.travelerId);
    await travelerProvider.getBagsStatusById(widget.travelerId);
    
    if (travelerProvider.currentTrip == null) {
      setState(() {
        isLoading = false;
      });

      return;
    }
    final collaborator = await provider.getUser(
      userId: travelerProvider.currentTrip!.responsibleCollaboratorId,
    );

    setState(() {
      collaboratorName = collaborator?.fullName;
      isLoading = false;
    });
  }
  void _handleRfidMessage(String message) {
    try {
      final data = jsonDecode(message);
      final epc = data['epc'] as String?;

      if (epc != null && data['status'] == 'NAO_CADASTRADA') {
        if (_controller.codeTags.contains(epc)) {
          GlobalSnackBar.warning(
              'TAG ${epc.substring(0, 8)}... já foi lida e adicionada!');
          return;
        }
        setState(() {
          _addBagSlot(epc);
        });
        GlobalSnackBar.success(
            'Nova bagagem adicionada e TAG lida: ${epc.substring(0, 8)}...');
      } else if (epc != null && data['status'] != 'NAO_CADASTRADA') {
        GlobalSnackBar.error(
            'Erro: A TAG ${epc.substring(0, 8)}... já está vinculada e em trânsito.');
      }
    } catch (e) {
      GlobalSnackBar.error('Erro ao processar mensagem do WebSocket: $e');
    }
  }

  void _addBagSlot(String epc) {
    _controller.addTagCodeAtIndex(_currentBagCount, epc);
    _controller.addPrintedCodeAtIndex(_currentBagCount, '');
    _tagControllers.add(TextEditingController(text: epc));
    _printedCodeControllers.add(TextEditingController());
    _currentBagCount++;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RfidBagProvider>.value(
      value: _rfidProvider,
      child: Scaffold(
        appBar: AppBar(title: const Text('Minhas Malas')),
        body: Consumer<RfidBagProvider>(
          builder: (context, provider, _) {
            final bags = provider.bags;

            if (bags.isEmpty) {
              return const Center(child: Text('Nenhuma bagagem lida ainda.'));
            }

            return ListView.builder(
              itemCount: bags.length,
              itemBuilder: (context, index) {
                final bag = bags[index];

                if (bag.status == BagStatusEnum.NAO_CADASTRADA) {
                  return const SizedBox.shrink();
                }

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: _getStatusIcon(BagStatusEnum.values.firstWhere((e) => e.toString() == 'BagStatusEnum.${bag.status}')),
                    title: Text('Código: ${bag.printedCode}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Status: ${BagStatusEnum.values.firstWhere((e) => e.toString() == 'BagStatusEnum.${bag.status}').toLiteral()}'),
                      ],
                    ),
                    trailing: bag.status == BagStatusEnum.READY_FOR_PICKUP
                        ? ElevatedButton(
                            onPressed: () {
                              GlobalSnackBar.success(
                                  'Mala ${bag.printedCode} coletada!');
                              setState(() {
                                bag.status = 'COLLECTED';
                              });
                            },
                            child: const Text('Coletar'),
                          )
                        : null,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Icon _getStatusIcon(BagStatusEnum status) {
    switch (status) {
      case BagStatusEnum.CHECKED_IN:
        return const Icon(Icons.assignment, color: Colors.blue);
      case BagStatusEnum.IN_TRANSIT:
      case BagStatusEnum.IN_TRANSIT_CONNECTION:
        return const Icon(Icons.airplane_ticket, color: Colors.orange);
      case BagStatusEnum.ARRIVED:
      case BagStatusEnum.ARRIVED_AT_CONNECTION:
        return const Icon(Icons.location_on, color: Colors.green);
      case BagStatusEnum.READY_FOR_PICKUP:
        return const Icon(Icons.shopping_bag, color: Colors.purple);
      case BagStatusEnum.COLLECTED:
        return const Icon(Icons.check_circle, color: Colors.grey);
      case BagStatusEnum.NAO_CADASTRADA:
        return const Icon(Icons.error, color: Colors.red);
    }
  }
}
