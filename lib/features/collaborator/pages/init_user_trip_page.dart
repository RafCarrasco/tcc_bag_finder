import 'package:bag_finder/core/entity/tag_entity.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../auth/controller/sign_up_controller.dart';
import '../controllers/init_user_trip_controller.dart';
import '../../../core/entity/bag_entity.dart';
import '../../../core/entity/trip_description_entity.dart';
import '../../../core/entity/trip_entity.dart';
import '../../../core/enums/bag_status_enum.dart';
import '../../../shared/providers/collaborator_provider.dart';
import '../../../shared/providers/trip_provider.dart';
import '../../../shared/providers/traveler_provider.dart';
import '../../../shared/providers/user_provider.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_dimensions.dart';
import '../../../core/utils/app_icons.dart';
import '../../../core/utils/app_text_styles.dart';
import '../../../core/utils/global_snackbar.dart';
import '../../../core/widgets/fields/init_user_trip_dropdown_field.dart';
import '../../../core/widgets/fields/init_user_trip_text_field.dart';
import '../../../core/widgets/fields/luggage_quantity_dropdown_field.dart';
import '../../../usecase/bag/add_bag_usecase.dart';

class InitUserTripPage extends StatefulWidget {
  const InitUserTripPage({super.key});

  @override
  State<InitUserTripPage> createState() => _InitUserTripPageState();
}

class _InitUserTripPageState extends State<InitUserTripPage> {
  final signUpController = Modular.get<SignUpController>();
  final provider = Modular.get<CollaboratorProvider>();
  final addBagUsecase = Modular.get<AddBagUsecase>();
  final tripProvider = Modular.get<TripProvider>();
  final travelerProvider = Modular.get<TravelerProvider>();
  final userProvider = Modular.get<UserProvider>();
  final _controller = Modular.get<InitUserTripController>();

  final uuid = const Uuid();
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
            borderRadius: BorderRadius.circular(AppDimensions.radiusExtraLarge),
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
                        // Quantidade de bagagens
                        LuggageQuantityDropdownField(
                          initialQuantity: 10,
                          hintText: 'Quantidade de bagagem',
                          isRequired: true,
                          fieldType: '',
                          onChanged: (bagQuantity) {
                            setState(() {
                              _controller.setBagageQuantity(
                                  bagageQuantity: bagQuantity);
                            });
                          },
                        ),
                        InitUserTripTextField(
                          prefixIcon: AppIconsSecondaryGrey.idCardIcon,
                          hintText: 'CPF',
                          onChanged: (cpf) {
                            _controller.setCpf(cpf: cpf);
                          },
                          isPassword: false,
                          fieldType: 'cpf',
                          isRequired: true,
                        ),
                        InitUserTripTextField(
                          prefixIcon: AppIconsSecondaryGrey.airPlaneModeIcon,
                          hintText: 'Destino',
                          onChanged: (destination) {
                            _controller.setDestination(destination: destination);
                          },
                          isPassword: false,
                          fieldType: 'destination',
                          isRequired: true,
                        ),
                        // Campos dinâmicos de aeroportos (por bagagem)
                        ...List.generate(
                          _controller.bagageQuantity ?? 0,
                          (index) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 16),
                              Text(
                                'Bagagem ${index + 1}',
                                style: TextStyle(
                                  fontSize: AppDimensions.fontLarge,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                              ),
                              InitUserTripTextField(
                                prefixIcon: AppIconsSecondaryGrey.connectingAirportsIcon,
                                hintText: 'TAG-RFID (Bagagem ${index + 1})',
                                onChanged: (code) {
                                  _controller.addTagCodeAtIndex(index, code);
                                },
                                isPassword: false,
                                fieldType: 'rfid',
                                isRequired: true,
                              ),
                            ],
                          ),
                        ),
                        // Botão de gerar viagem
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            vertical: AppDimensions.paddingMedium,
                          ),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  WidgetStateProperty.all(AppColors.primary),
                            ),
                            onPressed: () async {
                              final tripId=uuid.v4();
                              final bags = List.generate(
                                _controller.bagageQuantity ?? 0,
                                  (index) => BagEntity(
                                    id:uuid.v4(),
                                    description: "Mala do passageiro ${_controller.cpf}",
                                    status: BagStatusEnum.CHECKED_IN,
                                    cpf: _controller.cpf,
                                    tripId: tripId,
                                  ),
                                );
                              if (_formKey.currentState!.validate()) {
                                await tripProvider.addTrip(
                                  trip: TripEntity(
                                    id: tripId,
                                    cpf: _controller.cpf,
                                    responsibleCollaboratorId:
                                      userProvider.user!.id,
                                    description: TripDescriptionEntity(
                                      airportOrigin: "_controller.airportOrigin",
                                      airportDestination:"_controller.airportDestination",
                                    ),
                                    bags: bags
                                  ),
                                );
                                await Future.delayed(const Duration(milliseconds: 400));
                                int cont = 0;
                                for (final bag in bags) {
                                  await addBagUsecase.call(
                                    bag: bag);
                                  await provider.insertTag(
                                    TagEntity(
                                      code: _controller.codeTags[cont],
                                      createdAt: DateTime.now(),
                                      bagId: bag.id
                                    )
                                  );
                                  cont =cont+1;
                                }
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