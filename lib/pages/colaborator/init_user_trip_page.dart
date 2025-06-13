import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../controller/auth/sign_up_controller.dart';
import '../../controller/init_user_trip_controller.dart';
import '../../core/entity/bag_entity.dart';
import '../../core/entity/collaborator_entity.dart';
import '../../core/entity/trip_description_entity.dart';
import '../../core/entity/trip_entity.dart';
import '../../core/enums/bag_status_enum.dart';
import '../../core/provider/collaborator_provider.dart';
import '../../core/provider/trip_provider.dart';
import '../../core/provider/user_provider.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/app_dimensions.dart';
import '../../core/utils/app_icons.dart';
import '../../core/utils/app_text_styles.dart';
import '../../core/utils/global_snackbar.dart';
import '../../core/widgets/fields/init_user_trip_dropdown_field.dart';
import '../../core/widgets/fields/init_user_trip_text_field.dart';
import '../../core/widgets/fields/luggage_quantity_dropdown_field.dart';

class InitUserTripPage extends StatefulWidget {
  const InitUserTripPage({super.key});

  @override
  State<InitUserTripPage> createState() => _InitUserTripPageState();
}

class _InitUserTripPageState extends State<InitUserTripPage> {
  SignUpController signUpController = Modular.get<SignUpController>();
  var provider = Modular.get<CollaboratorProvider>();
  var tripProvider = Modular.get<TripProvider>();
  var userProvider = Modular.get<UserProvider>();
  final _controller = Modular.get<InitUserTripController>();

  var uuid = const Uuid();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                Icon(
                  Icons.airplanemode_active_sharp,
                  size: AppDimensions.iconLarge,
                  color: AppColors.secondary,
                ),
                Text(
                  'Iniciar Viagem',
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
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Comece preenchendo',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: AppDimensions.fontExtraLarge,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                            Text(
                              'os dados para adicionar uma bagagem...',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: AppDimensions.fontExtraLarge,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                        LuggageQuantityDropdownField(
                          initialQuantity: 10,
                          hintText: 'Quantidade de bagagem',
                          isRequired: true,
                          fieldType: '',
                          onChanged: (
                            bagQuantity,
                          ) {
                            _controller.setBagageQuantity(
                              bagageQuantity: bagQuantity,
                            );
                          },
                        ),
                        InitUserTripDropdownField(
                          hintText: 'Buscar passageiro por nome',
                          onChanged: (
                            user,
                          ) {
                            _controller.setUser(
                              user: user,
                            );
                          },
                          isRequired: true,
                          fieldType: '',
                        ),
                        InitUserTripTextField(
                          prefixIcon: AppIconsSecondaryGrey.airPlaneModeIcon,
                          hintText: 'Destino',
                          onChanged: (
                            destination,
                          ) {
                            _controller.setDestination(
                              destination: destination,
                            );
                          },
                          isPassword: false,
                          fieldType: 'destination',
                          isRequired: true,
                        ),
                        InitUserTripTextField(
                          prefixIcon:
                              AppIconsSecondaryGrey.connectingAirportsIcon,
                          hintText: 'Aeroporto de origem',
                          onChanged: (
                            airportOrigin,
                          ) {
                            _controller.setAirportOrigin(
                              airportOrigin: airportOrigin,
                            );
                          },
                          isPassword: false,
                          fieldType: 'airport',
                          isRequired: true,
                        ),
                        InitUserTripTextField(
                          prefixIcon:
                              AppIconsSecondaryGrey.connectingAirportsIcon,
                          hintText: 'Aeroporto de destino',
                          onChanged: (
                            airportDestination,
                          ) {
                            _controller.setAirportDestination(
                              airportDestination: airportDestination,
                            );
                          },
                          isPassword: false,
                          fieldType: 'airport',
                          isRequired: true,
                        ),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            vertical: AppDimensions.paddingMedium,
                          ),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
                                AppColors.primary,
                              ),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                await tripProvider.addTrip(
                                  trip: TripEntity(
                                    responsibleCollaboratorId:
                                        userProvider.user!.id,
                                    travelerEntity: _controller.user,
                                    description: TripDescriptionEntity(
                                      airportOrigin: _controller.airportOrigin,
                                      airportDestination:
                                          _controller.airportDestination,
                                    ),
                                    bags: List.generate(
                                      _controller.bagageQuantity ?? 0,
                                      (index) => BagEntity(
                                        description: null,
                                        status: BagStatusEnum.CHECKED_IN,
                                        ownerId: _controller.user.id,
                                      ),
                                    ),
                                    time: DateTime.now(),
                                  ),
                                );

                                int count =
                                    (userProvider.user! as CollaboratorEntity)
                                        .tripsCreated;

                                await userProvider.updateUser(
                                  user:
                                      (userProvider.user! as CollaboratorEntity)
                                          .copyWith(
                                    tripsCreated: count++,
                                  ),
                                  showSnackBar: false,
                                );

                                Modular.to.pushNamed(
                                  '/collaborator/${userProvider.user!.id}/home',
                                );
                              } else {
                                GlobalSnackBar.error(
                                  'Por favor, preencha todos os campos',
                                );
                              }
                            },
                            child: Text(
                              'Gerar viagem',
                              style: AppTextStyles.button,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
