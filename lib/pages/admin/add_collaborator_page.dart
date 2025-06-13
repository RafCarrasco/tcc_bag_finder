import 'package:uuid/uuid.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../controller/add_collaborator_controler.dart';
import '../../core/entity/admin_entity.dart';
import '../../core/entity/collaborator_entity.dart';
import '../../core/enums/user_role_enum.dart';
import '../../core/provider/user_provider.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/app_dimensions.dart';
import '../../core/utils/app_icons.dart';
import '../../core/utils/app_text_styles.dart';
import '../../core/utils/global_snackbar.dart';
import '../../core/widgets/admin/add_collaborator_text_field.dart';
import '../../core/widgets/admin/passoword_display_field.dart';

class AddCollaboratorPage extends StatefulWidget {
  const AddCollaboratorPage({super.key});

  @override
  State<AddCollaboratorPage> createState() => _AddCollaboratorPageState();
}

class _AddCollaboratorPageState extends State<AddCollaboratorPage> {
  final _formKey = GlobalKey<FormState>();
  final addCollaboratorController = Modular.get<AddCollaboratorController>();
  final provider = Modular.get<UserProvider>();

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
                Icon(Icons.emoji_people_rounded,
                    size: AppDimensions.iconLarge, color: AppColors.secondary),
                Text(
                  'Adicionar Colaboradores',
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
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingMedium,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Comece preenchendo',
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
                    hintText: AppLocalizations.of(context)!.fullNamePlaceholder,
                    isPassword: false,
                    onChanged: (value) {
                      addCollaboratorController.setFullName(value: value);
                    },
                    fieldType: 'fullName',
                    isRequired: true,
                  ),
                  AddCollaboratorTextField(
                    prefixIcon: AppIconsSecondaryGrey.emailIcon,
                    hintText: AppLocalizations.of(context)!.emailPlaceholder,
                    isPassword: false,
                    onChanged: (value) {
                      addCollaboratorController.setEmail(value: value);
                    },
                    fieldType: 'email',
                    isRequired: true,
                  ),
                  AddCollaboratorTextField(
                    prefixIcon: AppIconsSecondaryGrey.phoneIcon,
                    hintText: '(00) 00000-0000',
                    isPassword: false,
                    onChanged: (value) {
                      addCollaboratorController.setPhone(value: value);
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
                        foregroundColor: WidgetStateProperty.all(
                          addCollaboratorController.areFieldsValid()
                              ? Colors.white
                              : Colors.white70,
                        ),
                        backgroundColor: WidgetStateProperty.all(
                          addCollaboratorController.areFieldsValid()
                              ? AppColors.primary
                              : AppColors.primary.withOpacity(0.5),
                        ),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final currentUser = provider.user;
                          if (currentUser == null ||
                              currentUser is! AdminEntity) {
                            GlobalSnackBar.error('Administrador inválido.');
                            return;
                          }

                          final collaborator = CollaboratorEntity(
                            id: '',
                            fullName: addCollaboratorController.fullName!,
                            email: addCollaboratorController.email!,
                            phone: addCollaboratorController.phone!,
                            role: UserRoleEnum.COLLABORATOR.toLiteral(),
                            isActive: true,
                            company: currentUser.company,
                            responsibleId: currentUser.id,
                            createdAt: DateTime.now(),
                          );

                          final newUser = await provider.registerNewUser(
                            user: collaborator,
                            password: addCollaboratorController.password!,
                          );

                          if (newUser != null) {
                            Modular.to
                                .navigate('/admin/${currentUser.id}/home');
                          }
                        } else {
                          GlobalSnackBar.error(
                              'Por favor, preencha todos os campos');
                        }
                      },
                      child: Text(
                        AppLocalizations.of(context)!.signUpPageButtonSignUp,
                        style: AppTextStyles.button,
                      ),
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
