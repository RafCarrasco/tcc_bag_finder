import 'package:tcc_bag_finder/app/presentation/admin/add_collaborator/controller/add_collaborator_controller.dart';
import 'package:tcc_bag_finder/app/presentation/admin/add_collaborator/widgets/add_collaborator_text_field.dart';
import 'package:tcc_bag_finder/app/presentation/admin/add_collaborator/widgets/passoword_display_field.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_text_styles.dart';
import 'package:tcc_bag_finder/domain/entity/admin_entity.dart';
import 'package:uuid/uuid.dart';
import 'package:tcc_bag_finder/app/shared/themes/functions/global_snackbar.dart';
import 'package:tcc_bag_finder/domain/entity/collaborator_entity.dart';
import 'package:tcc_bag_finder/domain/entity/user_avatar_entity.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_colors.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_dimensions.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_icons.dart';
import 'package:tcc_bag_finder/app/presentation/user/stores/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AddCollaboratorPage extends StatefulWidget {
  const AddCollaboratorPage({
    super.key,
  });

  @override
  State<AddCollaboratorPage> createState() => _AddCollaboratorPageState();
}

class _AddCollaboratorPageState extends State<AddCollaboratorPage> {
  AddCollaboratorController addCollaboratorController =
      Modular.get<AddCollaboratorController>();
  var provider = Modular.get<UserProvider>();
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
                  Icons.emoji_people_rounded,
                  size: AppDimensions.iconLarge,
                  color: AppColors.secondary,
                ),
                Text(
                  'Adicionar Colaboradores',
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Form(
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
                              'os dados do colaborador...',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                        AddCollaboratorTextField(
                          prefixIcon: AppIconsSecondaryGrey.personIcon,
                          hintText:
                              AppLocalizations.of(context)!.fullNamePlaceholder,
                          isPassword: false,
                          onChanged: (value) {
                            addCollaboratorController.setFullName(
                              value: value,
                            );
                          },
                          fieldType: 'fullName',
                          isRequired: true,
                        ),
                        AddCollaboratorTextField(
                          prefixIcon: AppIconsSecondaryGrey.emailIcon,
                          hintText:
                              AppLocalizations.of(context)!.emailPlaceholder,
                          isPassword: false,
                          onChanged: (value) {
                            addCollaboratorController.setEmail(
                              value: value,
                            );
                          },
                          fieldType: 'email',
                          isRequired: true,
                        ),
                        AddCollaboratorTextField(
                          prefixIcon: AppIconsSecondaryGrey.phoneIcon,
                          hintText: '(00) 00000-0000',
                          isPassword: false,
                          onChanged: (value) {
                            addCollaboratorController.setPhone(
                              value: value,
                            );
                          },
                          fieldType: 'phone',
                          isRequired: true,
                        ),
                        PasswordDisplayField(
                          onPasswordRefresh: (newPassword) {
                            setState(() {
                              addCollaboratorController.setPassword(
                                value: newPassword,
                              );
                            });
                          },
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              foregroundColor:
                                  addCollaboratorController.areFieldsValid()
                                      ? WidgetStateProperty.all(
                                          Colors.white,
                                        )
                                      : WidgetStateProperty.all(
                                          Colors.white70,
                                        ),
                              backgroundColor:
                                  addCollaboratorController.areFieldsValid()
                                      ? WidgetStateProperty.all(
                                          AppColors.primary,
                                        )
                                      : WidgetStateProperty.all(
                                          AppColors.primary.withOpacity(
                                            0.5,
                                          ),
                                        ),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                await provider.createUser(
                                  user: CollaboratorEntity(
                                    avatar: UserAvatarEntity.empty(),
                                    fullName:
                                        addCollaboratorController.fullName!,
                                    email: addCollaboratorController.email!,
                                    password:
                                        addCollaboratorController.password!,
                                    dateOfBirth: '',
                                    phone: '',
                                    updatedAt: null,
                                    company:
                                        (provider.user! as AdminEntity).company,
                                    responsibleId: provider.user!.id,
                                  ),
                                );

                                Modular.to.navigate(
                                  '/admin/${provider.user!.id}/home',
                                );
                              } else {
                                GlobalSnackBar.error(
                                  'Por favor, preencha todos os campos',
                                );
                              }
                            },
                            child: Text(
                              AppLocalizations.of(context)!
                                  .signUpPageButtonSignUp,
                              style: AppTextStyles.button,
                            ),
                          ),
                        ),
                      ],
                    ),
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
