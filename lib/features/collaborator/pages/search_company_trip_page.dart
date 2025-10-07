import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';

import '../../../shared/providers/collaborator_provider.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_dimensions.dart';
import '../../../core/utils/app_icons.dart';
import '../../../core/widgets/trip_pagination_widget.dart';
import '../../../core/widgets/trip_panel_search_bar_widget.dart';

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

  @override
  void initState() {
    super.initState();
    getTrips();
  }

  Future<void> getTrips() async {
    await collaboratorProvider.getAllTripsByResponsible(
      responsibleId: widget.collaboratorId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.paddingMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    AppDimensions.radiusExtraLarge,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Container(
                  width: double.infinity,
                  color: AppColors.primary,
                  padding: const EdgeInsets.symmetric(
                    vertical: AppDimensions.paddingSmall,
                    horizontal: AppDimensions.paddingMedium,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppIconsSecondary.airPlaneModeIcon,
                      const SizedBox(width: 8),
                      Text(
                        'Consultar viagens',
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(
                              color: AppColors.secondary,
                              fontSize: AppDimensions.fontLarge,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: AppDimensions.paddingMedium),

              const TripPanelSearchBarWidget(),

              const SizedBox(height: AppDimensions.paddingMedium),

              Expanded(
                child: Consumer<CollaboratorProvider>(
                  builder: (context, collaboratorProvider, _) {
                    if (collaboratorProvider.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final trips = collaboratorProvider.trips ?? [];

                    if (trips.isEmpty) {
                      return const Center(
                        child: Text(
                          'Nenhuma viagem encontrada.',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                      );
                    }

                    return TripPaginationWidget(trips: trips);
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
