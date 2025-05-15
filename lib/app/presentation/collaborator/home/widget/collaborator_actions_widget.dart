import 'package:tcc_bag_finder/app/presentation/admin/home/widget/action_button_widget.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CollaboratorActionsWidget extends StatelessWidget {
  final String collaboratorId;

  const CollaboratorActionsWidget({
    super.key,
    required this.collaboratorId,
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
                      '/collaborator/$collaboratorId/init-user-trip',
                    );
                  },
                  child: const ActionButtonWidget(
                    icon: Icons.airplanemode_active_sharp,
                    text1: 'Iniciar Nova',
                    text2: 'Viagem',
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
                      '/collaborator/$collaboratorId/search-company-trips',
                    );
                  },
                  child: const ActionButtonWidget(
                    icon: Icons.content_paste_search_sharp,
                    text1: 'Consultar Viagens',
                    text2: 'da Companhia',
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
