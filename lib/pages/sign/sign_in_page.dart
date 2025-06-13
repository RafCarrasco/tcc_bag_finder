import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../controller/auth/sign_in_controller.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/app_dimensions.dart';
import '../../core/utils/app_icons.dart';
import '../../core/utils/app_text_styles.dart';
import '../../core/widgets/login_text_field.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final SignInController signInController = Modular.get<SignInController>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isLoginButtonEnabled() {
    return signInController.email?.isNotEmpty == true &&
        signInController.password?.isNotEmpty == true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            child: Image.asset(
              'images/luggage-two-persons.png',
              filterQuality: FilterQuality.high,
            ),
          ),
          Text(
            AppLocalizations.of(context)!.loginPageTitle,
            style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: AppDimensions.verticalSpaceMedium),
          Form(
            key: _formKey,
            child: Column(
              children: [
                LoginTextField(
                  onChanged: signInController.setEmail,
                  prefixIcon: AppIconsSecondaryGrey.emailIcon,
                  hint: AppLocalizations.of(context)!.emailPlaceholder,
                  isPassword: false,
                  fieldType: 'email',
                  isRequired: true,
                ),
                const SizedBox(height: AppDimensions.verticalSpaceLarge),
                LoginTextField(
                  onChanged: signInController.setPassword,
                  prefixIcon: AppIconsSecondaryGrey.passwordIcon,
                  hint: AppLocalizations.of(context)!.passwordPlaceholder,
                  isPassword: true,
                  fieldType: '',
                  isRequired: true,
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: signInController.rememberMe,
                    onChanged: (value) {
                      setState(() {
                        signInController.setRememberMe(value);
                      });
                    },
                  ),
                  Text(
                    AppLocalizations.of(context)!.loginPageRememberMe,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: AppColors.secondaryGrey,
                        ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  Modular.to.navigate('/login/find-your-account');
                },
                child: Text(
                  AppLocalizations.of(context)!.loginPageForgotPassword,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.primary,
                        decorationThickness: 2,
                      ),
                ),
              ),
            ],
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  await signInController.signIn(context);
                }
              },
              child: Text(
                AppLocalizations.of(context)!.loginPageButtonLogin,
                style: AppTextStyles.button,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.loginPageDoesntHaveAccount,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: AppColors.secondaryGrey,
                        ),
                  ),
                  TextButton(
                    onPressed: () {
                      Modular.to.navigate('/login/sign-up');
                    },
                    child: Text(
                      AppLocalizations.of(context)!.signUpPageButtonSignUp,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.loginPageTitle3,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: AppColors.secondaryGrey,
                        ),
                  ),
                  TextButton(
                    onPressed: () {
                      Modular.to.navigate('/login/contact-us');
                    },
                    child: Text(
                      AppLocalizations.of(context)!.loginPageContactSupport,
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
          )
        ],
      ),
    );
  }
}
