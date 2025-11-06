import 'package:bag_finder/infra/repositories/bag_repository_impl.dart';
import 'package:bag_finder/shared/providers/bag_status_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class QrScannerPage extends StatefulWidget {
  final String travelerId;

  const QrScannerPage({super.key, required this.travelerId});

  @override
  State<QrScannerPage> createState() => _QrScannerPageState();
}

class _QrScannerPageState extends State<QrScannerPage> {
  final MobileScannerController cameraController = MobileScannerController();
  bool _isProcessing = false;
  bool _isReady = false; // controla se o provider foi inicializado
  late final RfidBagProvider _rfidProvider;

  @override
  void initState() {
    super.initState();
    inicializatedPage();
  }

  Future<void> inicializatedPage() async {
    try {
      final baseUrl = dotenv.env['BASE_URL']!;
      final wsUrl = baseUrl.replaceFirst('http', 'ws');
      final channel = WebSocketChannel.connect(Uri.parse(wsUrl));
      final bagRepository = Modular.get<BagRepositoryImpl>();

      _rfidProvider = RfidBagProvider(
        channel: channel,
        baseUrl: baseUrl,
        bagRepository: bagRepository,
        userId: widget.travelerId,
      );

      // Caso precise carregar dados antes de começar o scanner
      if (mounted) {
        setState(() => _isReady = true);
      }

      debugPrint('✅ RfidBagProvider inicializado com sucesso.');
    } catch (e) {
      debugPrint('Erro ao inicializar página QR: $e');
    }
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  Future<void> _onDetect(BarcodeCapture capture) async {
    if (!_isReady) {
      debugPrint('⚠️ Ignorado: Provider ainda não inicializado.');
      return;
    }

    if (_isProcessing) return;

    final barcode = capture.barcodes.firstOrNull;
    if (barcode == null || barcode.rawValue == null) return;

    final code = barcode.rawValue!;
    debugPrint('📷 QR lido: $code');

    setState(() => _isProcessing = true);

    try {
      final bagId = await _rfidProvider.getBagsIdByEpc(code, widget.travelerId);

      if (bagId == null) {
        debugPrint('❌ Nenhuma bag encontrada para o EPC $code');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Nenhuma bag encontrada para este código.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } else {
        debugPrint('✅ Bag encontrada: $bagId');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Bag encontrada com ID: $bagId'),
              backgroundColor: Colors.green,
            ),
          );
        }

        await _rfidProvider.confirmBagCollection(bagId);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Bag confirmada com sucesso!'),
              backgroundColor: Colors.green,
            ),
          );
        }
      }
    } catch (e) {
      debugPrint('Erro ao processar QR: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao processar QR: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      await Future.delayed(const Duration(seconds: 2));
      if (mounted) {
        setState(() => _isProcessing = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isReady) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Leitor de QR Code'),
        actions: [
          IconButton(
            icon: const Icon(Icons.cameraswitch),
            onPressed: () => cameraController.switchCamera(),
          ),
          IconButton(
            icon: const Icon(Icons.flash_on),
            onPressed: () => cameraController.toggleTorch(),
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          MobileScanner(
            controller: cameraController,
            onDetect: _onDetect,
          ),
          Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 3),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ],
      ),
    );
  }
}
