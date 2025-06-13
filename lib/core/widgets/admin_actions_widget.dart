import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../utils/app_dimensions.dart';
import 'action_button_widget.dart';

class AdminActionsWidget extends StatelessWidget {
  final String adminId;

  const AdminActionsWidget({
    super.key,
    required this.adminId,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingLarge,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Modular.to.navigate(
                      '/admin/$adminId/add-collaborator',
                    );
                  },
                  child: const ActionButtonWidget(
                    icon: Icons.directions_run_sharp,
                    text1: 'Adicionar',
                    text2: 'colaborador',
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Modular.to.navigate(
                      '/admin/$adminId/collaborator-panel',
                    );
                  },
                  child: const ActionButtonWidget(
                    icon: Icons.content_paste_search_sharp,
                    text1: 'Consultar',
                    text2: 'colaborador',
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Modular.to.navigate(
                      '/admin/$adminId/trip-collaborator-panel',
                    );
                  },
                  child: const ActionButtonWidget(
                    icon: Icons.airplanemode_active_sharp,
                    text1: 'Consultar',
                    text2: 'Viagens do colaborador',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
