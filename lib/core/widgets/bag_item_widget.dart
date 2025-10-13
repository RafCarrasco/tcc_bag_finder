// lib/core/widgets/bag_item_widget.dart

import 'package:bag_finder/core/entity/bag_status_entity.dart';
import 'package:bag_finder/core/enums/bag_status_enum.dart';
import 'package:bag_finder/core/utils/app_colors.dart';
import 'package:bag_finder/core/utils/app_dimensions.dart';
import 'package:bag_finder/core/widgets/bag_tracking_timeline.dart';
import 'package:bag_finder/core/widgets/dialogs/bag_confirmation_dialog.dart';
import 'package:bag_finder/core/widgets/dialogs/edit_bag_description_dialog.dart';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';

class BagItemWidget extends StatefulWidget {
  final BagStatusEntity bagStatus;
  final VoidCallback onToggleExpansion;
  final bool isExpanded; 

  const BagItemWidget({
    super.key,
    required this.bagStatus,
    required this.onToggleExpansion,
    required this.isExpanded,       
  });

  @override
  State<BagItemWidget> createState() => _BagItemWidgetState();
}

BagStatusEnum bagStatusFromString(String? status) {
  switch (status?.toUpperCase()) {
    case 'CHECKED_IN':
      return BagStatusEnum.CHECKED_IN;
    case 'IN_TRANSIT':
      return BagStatusEnum.IN_TRANSIT;
    case 'ARRIVED_AT_CONNECTION':
      return BagStatusEnum.ARRIVED_AT_CONNECTION;
    case 'IN_TRANSIT_CONNECTION':
      return BagStatusEnum.IN_TRANSIT_CONNECTION;
    case 'ARRIVED':
      return BagStatusEnum.ARRIVED;
    case 'READY_FOR_PICKUP':
      return BagStatusEnum.READY_FOR_PICKUP;
    case 'COLLECTED':
      return BagStatusEnum.COLLECTED;
    default:
      return BagStatusEnum.NAO_CADASTRADA;
  }
}

class _BagItemWidgetState extends State<BagItemWidget> {
  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isCompactScreen = screenWidth < 600;

    final printedCode = widget.bagStatus.printedCode ?? widget.bagStatus.id;
    final fullBagId = widget.bagStatus.id; 

    // Obtém o estilo do título para usar no botão de toggle
    final titleMediumStyle = Theme.of(context).textTheme.titleMedium;

    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. HEADER CLICÁVEL (Barra verde com PrintedCode)
          GestureDetector(
            // O cabeçalho verde AGORA TEM apenas o código e o ícone, sem a seta
            onTap: widget.onToggleExpansion,
            child: Container(
              padding: const EdgeInsets.all(AppDimensions.paddingSmall),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 🔹 ÍCONE DA BAGAGEM E PRINTED CODE
                  Flexible(
                    flex: isCompactScreen ? 3 : 2,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.luggage, color: Colors.white),
                        const SizedBox(width: 8), 
                        Flexible(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              printedCode, // PrintedCode no header
                              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // 🔹 REMOVIDA A SETA DA EXPANSÃO DO HEADER
                  const SizedBox.shrink(),
                ],
              ),
            ),
          ),

          // Título 'Ciclo de Viagem' e botão 'Ver/Ocultar Ciclo' em Row
          Padding(
            padding: const EdgeInsets.only(left: AppDimensions.paddingSmall, right: AppDimensions.paddingSmall, top: AppDimensions.paddingSmall),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Ciclo de Viagem',
                  style: titleMediumStyle!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary, // Cor verde/primária
                  ),
                ),
                
                // Botão de toggle (sem layout de botão, seta circular)
                GestureDetector( 
                  onTap: widget.onToggleExpansion,
                  child: Row( 
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.isExpanded 
                            ? 'Ocultar Ciclo' 
                            : 'Ver Ciclo', 
                        style: titleMediumStyle.copyWith( // Usa o mesmo estilo do título
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                          fontSize: titleMediumStyle.fontSize, // Garante o mesmo tamanho de fonte
                        ),
                      ),
                      const SizedBox(width: 4), 
                      // Seta envolta em um círculo
                      Container(
                        width: isCompactScreen ? 20 : 24, 
                        height: isCompactScreen ? 20 : 24, 
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.primary, width: 1), // Borda verde
                        ),
                        child: Icon(
                          widget.isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                          color: AppColors.primary,
                          size: isCompactScreen ? 16 : 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 2. TIMELINE (Compacta ou Completa)
          Padding(
            padding: const EdgeInsets.all(AppDimensions.paddingSmall),
            child: BagTrackingTimeline(
              currentStatus: bagStatusFromString(widget.bagStatus.status),
              showFullTimeline: widget.isExpanded, 
            ),
          ),
          
          // 💡 REMOVIDO: BLOCO DE ESTADO ATUAL (AMARELO) DUPLICADO
          // Este bloco foi movido e corrigido DENTRO de BagTrackingTimeline -> _buildCompactView
          // para evitar duplicação e garantir que o ícone e a cor estejam corretos.
          
          // 3. BLOCO DE INFORMAÇÕES BÁSICAS E BOTÕES (Sempre visível)
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingMedium,
              vertical: AppDimensions.paddingSmall,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔹 Coluna de informações (Status, ID COMPLETO, Hora)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow(
                      'Status:',
                      widget.bagStatus.status,
                      context,
                      isCompactScreen,
                    ),
                    const SizedBox(height: 4),
                    _buildInfoRow(
                      'ID:', // ID completo abaixo
                      fullBagId,
                      context,
                      isCompactScreen,
                    ),
                    const SizedBox(height: 4),
                    _buildInfoRow(
                      'Última alteração:',
                      widget.bagStatus.createdAt != null
                          ? DateFormat('HH:mm').format(
                                widget.bagStatus.createdAt!.toLocal(),
                              )
                          : 'Nenhuma alteração encontrada!',
                      context,
                      isCompactScreen,
                    ),
                  ],
                ),
                
                // 🔹 Botões de Ação / Confirmação de Entrega (NOVA ROW ABAIXO - Evita conflito com ID)
                const SizedBox(height: 12),
                
                widget.bagStatus.status != BagStatusEnum.COLLECTED.name 
                    ? Row(
                        children: [
                          // 🔹 Botão Editar
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                  elevation: 8,
                                  padding: EdgeInsets.symmetric(horizontal: isCompactScreen ? 8 : 12, vertical: isCompactScreen ? 10 : 12),
                                ),
                                onPressed: () async {
                                  showDialog(context: context, builder: (BuildContext context) {
                                    return EditBagDescriptionDialog(bagStatus: widget.bagStatus, onEditConfirmation: (text) async {}, onNotArrived: () {Modular.to.pop();},);
                                  },);
                                  setState(() {_isProcessing = false;});
                                },
                                child: _isProcessing 
                                    ? FittedBox(fit: BoxFit.scaleDown, child: Text('Processando...', style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: AppColors.secondary)),)
                                    : Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.edit, color: Colors.white, size: isCompactScreen ? 18 : AppDimensions.iconSmall),
                                            SizedBox(width: isCompactScreen ? 4 : 8),
                                            FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: Text('Editar', style: TextStyle(color: Colors.white, fontSize: isCompactScreen ? 14 : AppDimensions.fontSmall, fontWeight: FontWeight.bold)),
                                            ),
                                          ],
                                        ),
                              ),
                            ),
                          ),
                          // 🔹 Botão Confirmar
                          Expanded(
                            child: TextButton(
                              style: TextButton.styleFrom(
                                  backgroundColor: widget.bagStatus.status == BagStatusEnum.ARRIVED.name ? AppColors.primary : AppColors.secondaryGrey,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                  elevation: 8,
                                  padding: EdgeInsets.symmetric(horizontal: isCompactScreen ? 8 : 12, vertical: isCompactScreen ? 10 : 12),
                                ),
                              onPressed: _isProcessing ? null : () async {
                                  if (widget.bagStatus.status == BagStatusEnum.ARRIVED.name) {
                                    setState(() {_isProcessing = true;});
                                    showDialog(context: context, builder: (BuildContext context) {
                                      return BagConfirmationDialog(bagStatus: widget.bagStatus, onConfirmArrival: () async {}, onNotArrived: () {Modular.to.pop();},);
                                    },);
                                    setState(() {_isProcessing = false;});
                                  }
                                },
                              child: _isProcessing 
                                  ? FittedBox(fit: BoxFit.scaleDown, child: Text('Processando...', style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: AppColors.secondary)),)
                                  : Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.check, color: Colors.white, size: isCompactScreen ? 18 : AppDimensions.iconSmall),
                                          SizedBox(width: isCompactScreen ? 4 : 8),
                                          FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text('Confirmar', style: TextStyle(color: Colors.white, fontSize: isCompactScreen ? 14 : AppDimensions.fontSmall, fontWeight: FontWeight.bold)),
                                          ),
                                        ],
                                      ),
                            ),
                          ),
                        ],
                      )
                    : Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                            // 🔹 Entrega Confirmada
                            padding: EdgeInsets.all(isCompactScreen ? 4 : 8),
                            decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(12),),
                            child: Column(
                              children: [
                                FittedBox(fit: BoxFit.scaleDown, child: Text('Entrega', style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold, color: AppColors.secondary, fontSize: isCompactScreen ? 14 : 16)),),
                                FittedBox(fit: BoxFit.scaleDown, child: Text('Confirmada', style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold, color: AppColors.secondary, fontSize: isCompactScreen ? 14 : 16)),),
                              ],
                            ),
                          ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, BuildContext context, bool isCompactScreen) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label ',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.secondaryGrey,
                fontSize: isCompactScreen ? 13 : null,
              ),
        ),
        Expanded(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: AppColors.secondaryGrey,
                    fontSize: isCompactScreen ? 13 : null,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}