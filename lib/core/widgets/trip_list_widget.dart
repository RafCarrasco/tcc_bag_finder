// lib/pages/home_traveler_page.dart

import 'package:bag_finder/core/widgets/bag_item_widget.dart';
import 'package:bag_finder/infra/repositories/bag_repository_impl.dart';
import 'package:bag_finder/shared/providers/bag_status_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../../shared/providers/user_provider.dart';
import '../../../core/utils/app_dimensions.dart';
import '../../../core/widgets/appbar/history_app_bar_widget.dart'; // Assumindo este é o HomeTravelerAppBarWidget

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
  bool isLoading = true;
  late RfidBagProvider _rfidProvider; 

  final Map<String, bool> _isBagExpanded = {};

  @override
  void initState() {
    super.initState();
    _initializePage();
  }

  Future<void> _initializePage() async {
    final baseUrl = dotenv.env['BASE_URL']!;
    final wsUrl = baseUrl.replaceFirst('http', 'ws');
    final channel = WebSocketChannel.connect(Uri.parse(wsUrl));

    final bagRepository = Modular.get<BagRepositoryImpl>();

    _rfidProvider = RfidBagProvider(
      channel: channel,
      baseUrl: baseUrl,
      bagRepository: bagRepository,
    );

    await _rfidProvider.loadUserBags(widget.travelerId);

    setState(() => isLoading = false);
  }

  bool _getIsExpanded(String bagId) {
    // Usa o ID da bagagem para rastrear a expansão.
    return _isBagExpanded.putIfAbsent(bagId, () => false); 
  }

  void _toggleExpansion(String bagId) {
    setState(() {
      _isBagExpanded[bagId] = !(_isBagExpanded[bagId] ?? false);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading || userProvider.user == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return ChangeNotifierProvider.value(
      value: _rfidProvider,
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F7FA),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(AppDimensions.radiusExtraLarge),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                // Assumindo que HomeTravelerAppBarWidget é o widget correto para a AppBar.
                child: HomeTravelerAppBarWidget(
                  userName: userProvider.user!.fullName, 
                  hint: 'Procure sua bagagem...',
                ),
              ),

              const SizedBox(height: 10),

              // 💡 NOVO: Centraliza e limita a largura da lista de cards para 400px
              Expanded(
                child: Center( // Centraliza o conteúdo (em telas largas)
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 400, // Limita a largura a 400px
                    ),
                    child: Consumer<RfidBagProvider>(
                      builder: (context, provider, _) {
                        if (provider.bags.isEmpty) {
                          return const Center(
                            child: Text(
                              'Nenhuma bagagem encontrada.',
                              style: TextStyle(color: Colors.black54),
                            ),
                          );
                        }

                        return ListView.builder(
                          padding: const EdgeInsets.all(12),
                          itemCount: provider.bags.length,
                          itemBuilder: (context, index) {
                            final bag = provider.bags[index];
                            final bagId = bag.id; 
                            final isExpanded = _getIsExpanded(bagId);
                            
                            // Passa os parâmetros de expansão para o BagItemWidget.
                            return BagItemWidget(
                              bagStatus: bag,
                              isExpanded: isExpanded,
                              onToggleExpansion: () => _toggleExpansion(bagId),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}