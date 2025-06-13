import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';
import '../../core/provider/admin_provider.dart';
import '../../core/provider/user_provider.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/app_dimensions.dart';
import '../../core/utils/app_icons.dart';
import '../../core/widgets/collaborator_trips_pagination_widget.dart';

class CollaboratorTripsPanelPage extends StatefulWidget {
  final String collaboratorId;
  const CollaboratorTripsPanelPage({
    super.key,
    required this.collaboratorId,
  });

  @override
  State<CollaboratorTripsPanelPage> createState() =>
      _CollaboratorTripsPanelPageState();
}

class _CollaboratorTripsPanelPageState
    extends State<CollaboratorTripsPanelPage> {
  final adminProvider = Modular.get<AdminProvider>();

  @override
  void initState() {
    super.initState();
    getTrips();
  }

  void getTrips() async {
    await adminProvider.getCollaboratorTripsByCollaboratorId(
      collaboratorId: widget.collaboratorId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              AppDimensions.radiusExtraLarge,
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 5,
                offset: Offset(
                  0,
                  3,
                ),
              ),
            ],
          ),
          child: Container(
            width: double.infinity,
            color: AppColors.primary,
            padding: const EdgeInsets.only(
              top: AppDimensions.paddingMedium,
              left: AppDimensions.paddingSmall,
              right: AppDimensions.paddingSmall,
              bottom: AppDimensions.paddingSmall,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppIconsSecondary.airPlaneModeIcon,
                Text(
                  'Viagens do Colaborador',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: AppColors.secondary,
                        fontSize: AppDimensions.fontLarge,
                        fontWeight: FontWeight.bold,
                      ),
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingMedium,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    UserProvider provider = Modular.get<UserProvider>();
                    Modular.to.pushNamed(
                      '/admin/:${provider.user!.id}/trip-collaborator-panel',
                    );
                  },
                  child: const Text(
                    'Retornar ao Painel Principal',
                  ),
                ),
                Expanded(
                  child: Consumer<AdminProvider>(
                    builder: (context, adminProvider, _) {
                      if (adminProvider.isLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return CollaboratorTripsPaginationWidget(
                        trips: adminProvider.collaboratorTrips ?? [],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
