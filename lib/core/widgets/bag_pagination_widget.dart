// lib/core/widgets/bag_pagination_widget.dart

import 'package:bag_finder/core/entity/bag_status_entity.dart';
import 'package:flutter/material.dart';
import '../utils/app_dimensions.dart';
import 'bag_item_widget.dart';

// 1. Mudar para StatefulWidget
class BagPaginationWidget extends StatefulWidget {
  final List<BagStatusEntity> bags;
  final String airportOriginCode;
  final String airportDestinationCode;

  const BagPaginationWidget({
    super.key,
    required this.bags,
    required this.airportOriginCode,
    required this.airportDestinationCode,
  });

  @override
  State<BagPaginationWidget> createState() => _BagPaginationWidgetState();
}

class _BagPaginationWidgetState extends State<BagPaginationWidget> {
  // 2. Mapa para rastrear o estado de expansão de cada bagagem
  // A chave será o ID ou PrintedCode da bagagem.
  final Map<String, bool> _isBagExpanded = {};

  // 3. Função para obter o estado de expansão
  bool _getIsExpanded(String bagId) {
    // Retorna o valor atual, ou false se não existir.
    return _isBagExpanded.putIfAbsent(bagId, () => false); 
  }

  // 4. Função para alternar o estado de expansão
  void _toggleExpansion(String bagId) {
    setState(() {
      _isBagExpanded[bagId] = !(_isBagExpanded[bagId] ?? false);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.bags.isEmpty) {
      return const Center(
        child: Text(
          // 💡 Ajuste de texto: "Nenhuma bagagem encontrada" faz mais sentido
          "Nenhuma bagagem encontrada",
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
      itemCount: widget.bags.length,
      itemBuilder: (context, index) {
        final bag = widget.bags[index];
        // Usamos o ID da bagagem ou um índice como fallback
        final bagId = bag.id; 
        final isExpanded = _getIsExpanded(bagId);

        // 5. Passar os parâmetros obrigatórios
        return BagItemWidget(
          bagStatus: bag,
          isExpanded: isExpanded, // 👈 Parâmetro agora fornecido
          onToggleExpansion: () => _toggleExpansion(bagId), // 👈 Parâmetro agora fornecido
        );
      },
    );
  }
}