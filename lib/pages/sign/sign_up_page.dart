import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../controller/auth/sign_up_controller.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/app_dimensions.dart';
import '../../core/utils/app_icons.dart';
import '../../core/utils/app_text_styles.dart';
import '../../core/widgets/login_text_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final SignUpController signUpController = Modular.get<SignUpController>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(width: 300, height: 200),
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
                children: [
                  LoginTextField(
                    prefixIcon: AppIconsSecondaryGrey.personIcon,
                    hint: AppLocalizations.of(context)!.fullNamePlaceholder,
                    isPassword: false,
                    onChanged: signUpController.setFullName,
                    fieldType: 'fullName',
                    isRequired: true,
                  ),
                  const SizedBox(height: AppDimensions.verticalSpaceLarge),
                  LoginTextField(
                    prefixIcon: AppIconsSecondaryGrey.emailIcon,
                    hint: AppLocalizations.of(context)!.emailPlaceholder,
                    isPassword: false,
                    fieldType: 'email',
                    onChanged: signUpController.setEmail,
                    isRequired: true,
                  ),
                  const SizedBox(height: AppDimensions.verticalSpaceLarge),
                  LoginTextField(
                    prefixIcon: AppIconsSecondaryGrey.passwordIcon,
                    hint: AppLocalizations.of(context)!.passwordPlaceholder,
                    isPassword: true,
                    onChanged: signUpController.setPassword,
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
                      ? WidgetStateProperty.all(AppColors.primary)
                      : WidgetStateProperty.all(AppColors.primary.withOpacity(0.5)),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await signUpController.signUp(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Preencha todos os campos')),
                    );
                  }
                },
                child: Text(
                  AppLocalizations.of(context)!.signUpPageButtonSignUp,
                  style: AppTextStyles.button,
                ),
              ),
            ),
            const SizedBox(height: 5),
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
                    Modular.to.navigate('/login/sign-in');
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
