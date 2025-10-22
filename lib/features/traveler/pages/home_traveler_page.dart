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
import '../../../core/widgets/appbar/home_app_bar_widget.dart';

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

  late final WebSocketChannel _channel;
  late final RfidBagProvider _rfidProvider;
  final Map<String, bool> _isBagExpanded = {};

  @override
  void initState() {
    super.initState();
    _initializePage();
  }

  Future<void> _initializePage() async {
    final baseUrl = dotenv.env['BASE_URL']!;
    final wsUrl = baseUrl.replaceFirst('http', 'ws');
    _channel = WebSocketChannel.connect(Uri.parse(wsUrl));

    final bagRepository = Modular.get<BagRepositoryImpl>();

    _rfidProvider = RfidBagProvider(
      channel: _channel,
      baseUrl: baseUrl,
      bagRepository: bagRepository,
    );

    await _rfidProvider.loadUserBags(widget.travelerId);

    setState(() => isLoading = false);
  }

  bool _getIsExpanded(String bagId) {
    return _isBagExpanded.putIfAbsent(bagId, () => false);
  }

  void _toggleExpansion(String bagId) {
    setState(() {
      _isBagExpanded[bagId] = !(_isBagExpanded[bagId] ?? false);
    });
  }

  @override
  void dispose() {
    _channel.sink.close();
    _rfidProvider.dispose();
    super.dispose();
    _rfidProvider.loadUserBags(widget.travelerId);
  }

@override
Widget build(BuildContext context) {
  if (isLoading || userProvider.user == null) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }

  return ChangeNotifierProvider<RfidBagProvider>.value(
    value: _rfidProvider,
    child: Scaffold(
      extendBody: true,
      backgroundColor: const Color(0xFFF5F7FA),
      body: SafeArea(
        child: Column(
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
                userId: widget.travelerId,
                userName: userProvider.user!.fullName,
                hint: 'Procure sua bagagem...',
              ),
            ),

            const SizedBox(height: 10),

            // 🔹 O Consumer cuida apenas da parte que depende do provider
            Expanded(
              child: Consumer<RfidBagProvider>(
                builder: (context, provider, child) {
                  return Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 400),
                      child: provider.isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : provider.bags.isEmpty
                              ? const Center(
                                  child: Text(
                                    'Nenhuma bagagem encontrada.',
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                )
                              : ListView.builder(
                                  padding: const EdgeInsets.all(12),
                                  itemCount: provider.bags.length,
                                  itemBuilder: (context, index) {
                                    final bag = provider.bags[index];
                                    final isExpanded =
                                        _getIsExpanded(bag.id);
                                    return BagItemWidget(
                                      bagStatus: bag,
                                      isExpanded: isExpanded,
                                      onToggleExpansion: () =>
                                          _toggleExpansion(bag.id),
                                    );
                                  },
                                ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

}
