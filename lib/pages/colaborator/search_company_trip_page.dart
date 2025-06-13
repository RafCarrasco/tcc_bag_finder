import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';
import '../../core/entity/trip_entity.dart';
import '../../core/provider/collaborator_provider.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/app_dimensions.dart';
import '../../core/utils/app_icons.dart';
import '../../core/widgets/trip_pagination_widget.dart';
import '../../core/widgets/trip_panel_search_bar_widget.dart';

class SearchCompanyTripPage extends StatefulWidget {
  final String collaboratorId;
  const SearchCompanyTripPage({
    super.key,
    required this.collaboratorId,
  });

  @override
  State<SearchCompanyTripPage> createState() => _SearchCompanyTripPageState();
}

class _SearchCompanyTripPageState extends State<SearchCompanyTripPage> {
  final collaboratorProvider = Modular.get<CollaboratorProvider>();

  List<TripEntity> trips = [];

  @override
  void initState() {
    super.initState();
    getTrips();
  }

  void getTrips() async {
    trips = await collaboratorProvider.getAllTripsByResponsible(
      responsibleId: widget.collaboratorId,
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
                  'Consultar viagens',
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
                const SizedBox(
                  height: AppDimensions.paddingMedium,
                ),
                const TripPanelSearchBarWidget(),
                Expanded(
                  child: Consumer<CollaboratorProvider>(
                    builder: (context, collaboratorProvider, _) {
                      if (collaboratorProvider.isLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return TripPaginationWidget(
                        trips: collaboratorProvider.trips ?? [],
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
