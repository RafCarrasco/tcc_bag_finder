import 'package:bag_finder/core/widgets/bag_item_widget.dart';
import 'package:bag_finder/features/collaborator/controllers/init_user_trip_controller.dart';
import 'package:bag_finder/infra/repositories/bag_repository_impl.dart';
import 'package:bag_finder/shared/providers/bag_status_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../../shared/providers/user_provider.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_dimensions.dart';
import '../../../core/widgets/appbar/history_app_bar_widget.dart';
import '../../../core/widgets/trip_list_widget.dart';

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
  final userProvider = Modular.get<UserProvider>();
  late WebSocketChannel _channel;
  bool isLoading = true;
  late RfidBagProvider _rfidProvider;

  @override
  void initState() {
    super.initState();
    _initializePage();
  }

  Future<void> _initializePage() async {
    final baseUrl = dotenv.env['BASE_URL']!;
    final wsUrl = baseUrl.replaceFirst('http', 'ws');
    final channel = WebSocketChannel.connect(Uri.parse(wsUrl));

    // inicializa o provider com repositório injetado
    final bagRepository = Modular.get<BagRepositoryImpl>();

    _rfidProvider = RfidBagProvider(
      channel: channel,
      baseUrl: baseUrl,
      bagRepository: bagRepository,
    );

    // carrega bags do usuário
    await _rfidProvider.loadUserBags(widget.travelerId);

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return ChangeNotifierProvider.value(
      value: _rfidProvider,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.circular(AppDimensions.radiusExtraLarge),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: HomeTravelerAppBarWidget(
              userName: userProvider.user!.fullName,
              hint: 'Procure sua bagagem...',
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: _rfidProvider.bags.isEmpty
                ? const Center(
                    child: Text(
                      'Nenhuma bagagem encontrada.',
                      style: TextStyle(color: Colors.black54),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: _rfidProvider.bags.length,
                    itemBuilder: (context, index) {
                      final bag = _rfidProvider.bags[index];
                      return BagItemWidget(bagStatus: bag);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}