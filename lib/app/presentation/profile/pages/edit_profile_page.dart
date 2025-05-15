import 'package:tcc_bag_finder/app/presentation/profile/controller/update_controller.dart';
import 'package:tcc_bag_finder/app/presentation/profile/widgets/custom_text_form_field_widget.dart';
import 'package:tcc_bag_finder/app/presentation/profile/widgets/profile_banner_widget.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_colors.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_dimensions.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_icons.dart';
import 'package:tcc_bag_finder/app/shared/themes/functions/global_snackbar.dart';
import 'package:tcc_bag_finder/app/presentation/user/stores/user_provider.dart';
import 'package:tcc_bag_finder/domain/entity/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({
    super.key,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  UpdateController updateController = Modular.get<UpdateController>();
  UserProvider provider = Modular.get<UserProvider>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
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
              IconButton(
                onPressed: () {
                  Modular.to.pushNamed(
                    '/profile/${provider.user!.id}',
                  );
                },
                padding: EdgeInsets.zero,
                icon: Icon(
                  Icons.arrow_back,
                  size: AppDimensions.iconLarge,
                  color: AppColors.secondary,
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    'Salvar Perfil',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: AppColors.secondary,
                          fontSize: AppDimensions.fontLarge,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ),
            ],
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
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Center(
                      child: UserAvatarWidget(
                        name: provider.user!.fullName,
                        isLarge: true,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomTextFormField(
                          hintText: provider.user!.fullName,
                          prefixIcon: AppIconsSecondaryGrey.personIcon,
                          isPassword: false,
                          onChanged: (value) {
                            updateController.setFullName(
                              fullName: value,
                            );
                          },
                          fieldType: 'fullname',
                          isRequired: false,
                        ),
                        CustomTextFormField(
                          hintText: provider.user!.email,
                          onChanged: (value) {
                            updateController.setEmail(
                              email: value,
                            );
                          },
                          prefixIcon: AppIconsSecondaryGrey.emailIcon,
                          isPassword: false,
                          fieldType: 'email',
                          isRequired: false,
                        ),
                        CustomTextFormField(
                          hintText: provider.user!.phone,
                          prefixIcon: AppIconsSecondaryGrey.phoneIcon,
                          isPassword: false,
                          fieldType: 'phone',
                          onChanged: (value) {
                            updateController.setPhone(
                              phone: value,
                            );
                          },
                          isRequired: false,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    UserEntity user = provider.user!;
                                    await provider.updateUser(
                                      user: user.copyWith(
                                        fullName: updateController.fullName,
                                        email: updateController.email,
                                        phone: updateController.phone,
                                        gender: updateController.gender,
                                        updatedAt: DateTime.now(),
                                      ),
                                    );
                                    GlobalSnackBar.info(
                                      'Perfil atualizado com sucesso!',
                                    );

                                    Modular.to.navigate(
                                      '/user/profile',
                                    );
                                  } else {
                                    GlobalSnackBar.error(
                                      'Por favor, preencha todos os campos',
                                    );
                                  }
                                },
                                child: Text(
                                  'Salvar Perfil',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        color: AppColors.secondary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: WidgetStatePropertyAll(
                                    AppColors.error,
                                  ),
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    provider.logout();
                                    GlobalSnackBar.info(
                                      'Logout realizado com sucesso!',
                                    );

                                    Modular.to.navigate(
                                      '/login/sign-in',
                                    );
                                  } else {
                                    GlobalSnackBar.error(
                                      'Erro ao sair. Por favor, tente novamente',
                                    );
                                  }
                                },
                                child: Text(
                                  'Logout',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        color: AppColors.secondary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                            ),
                          ],
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
