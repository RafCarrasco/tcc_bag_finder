import 'package:tcc_bag_finder/app/presentation/user/auth/controller/sign_up_controller.dart';
import 'package:tcc_bag_finder/app/presentation/user/auth/mixins/user_validation_mixin.dart';
import 'package:tcc_bag_finder/app/presentation/user/auth/widgets/login_text_field.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_colors.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_dimensions.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_icons.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_text_styles.dart';
import 'package:tcc_bag_finder/app/shared/themes/functions/global_snackbar.dart';
import 'package:tcc_bag_finder/app/presentation/user/stores/user_provider.dart';
import 'package:tcc_bag_finder/domain/entity/traveler_entity.dart';
import 'package:tcc_bag_finder/domain/entity/user_avatar_entity.dart';
import 'package:tcc_bag_finder/domain/entity/user_entity.dart';
import 'package:tcc_bag_finder/domain/enums/user_role_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with ValidationMixin {
  SignUpController signUpController = Modular.get<SignUpController>();
  UserProvider provider = Modular.get<UserProvider>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isFormValid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(
              width: 300,
              height: 200,
            ),
            Text(
              AppLocalizations.of(context)!.loginPageTitle2,
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Text(
              AppLocalizations.of(context)!.loginPageTitle2SecondLine,
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LoginTextField(
                    prefixIcon: AppIconsSecondaryGrey.personIcon,
                    hint: AppLocalizations.of(context)!.fullNamePlaceholder,
                    isPassword: false,
                    onChanged: (value) {
                      signUpController.setFullName(
                        value,
                      );
                    },
                    fieldType: 'fullName',
                    isRequired: true,
                  ),
                  const SizedBox(
                    height: AppDimensions.verticalSpaceLarge,
                  ),
                  LoginTextField(
                    prefixIcon: AppIconsSecondaryGrey.emailIcon,
                    hint: AppLocalizations.of(context)!.emailPlaceholder,
                    isPassword: false,
                    fieldType: 'email',
                    onChanged: (value) {
                      signUpController.setEmail(
                        value,
                      );
                    },
                    isRequired: true,
                  ),
                  const SizedBox(
                    height: AppDimensions.verticalSpaceLarge,
                  ),
                  LoginTextField(
                    prefixIcon: AppIconsSecondaryGrey.passwordIcon,
                    hint: AppLocalizations.of(context)!.passwordPlaceholder,
                    isPassword: true,
                    onChanged: (value) {
                      signUpController.setPassword(
                        value,
                      );
                    },
                    fieldType: 'password',
                    isRequired: true,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: signUpController.areFieldsValid()
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
                  UserEntity result;
                  if (_formKey.currentState!.validate()) {
                    result = await provider.createUser(
                      user: TravelerEntity(
                        avatar: UserAvatarEntity.empty(),
                        fullName: signUpController.fullName!,
                        email: signUpController.email!,
                        role: UserRoleEnum.TRAVELER,
                        password: signUpController.password!,
                        phone: '',
                        updatedAt: null,
                      ),
                      isSignUp: true,
                    );

                    Modular.to.navigate(
                      '/traveler/${result.id}/home',
                    );
                  } else {
                    GlobalSnackBar.error(
                      'Por favor, preencha todos os campos',
                    );
                  }
                },
                child: Text(
                  AppLocalizations.of(context)!.signUpPageButtonSignUp,
                  style: AppTextStyles.button,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context)!.loginPageAlreadyHaveAccount,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: AppColors.secondaryGrey,
                      ),
                ),
                TextButton(
                  onPressed: () {
                    Modular.to.navigate(
                      '/login/sign-in',
                    );
                  },
                  child: Text(
                    AppLocalizations.of(context)!.loginPageClickHere,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.primary,
                          decorationThickness: 2,
                        ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
