import 'package:flutter/material.dart';
import 'package:bag_finder/l10n/app_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../controller/sign_in_controller.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_dimensions.dart';
import '../../../core/utils/app_icons.dart';
import '../../../core/utils/app_text_styles.dart';
import '../../../core/widgets/login_text_field.dart';
import '../../../shared/providers/user_provider.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final SignInController signInController = Modular.get<SignInController>();
  final UserProvider provider = Modular.get<UserProvider>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isLoginButtonEnabled() {
    return signInController.email?.isNotEmpty == true &&
        signInController.password?.isNotEmpty == true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 350,
            child: Image.asset(
              'images/bagfinder-login.png',
              filterQuality: FilterQuality.high,
              fit: BoxFit.fitWidth,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            AppLocalizations.of(context)!.loginPageTitle,
            style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: AppDimensions.verticalSpaceMedium),
          SizedBox(
            height: 30,
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  width: 400,
                  child: LoginTextField(
                    onChanged: signInController.setEmail,
                    suffixIcon: AppIconsSecondaryGrey.emailIcon,
                    hint: AppLocalizations.of(context)!.emailPlaceholder,
                    isPassword: false,
                    fieldType: 'email',
                    isRequired: true,
                  ),
                ),
                const SizedBox(height: AppDimensions.verticalSpaceLarge),
                SizedBox(
                  width: 400,
                  child: LoginTextField(
                  onChanged: signInController.setPassword,
                  suffixIcon: AppIconsSecondaryGrey.passwordIcon,
                  hint: AppLocalizations.of(context)!.passwordPlaceholder,
                  isPassword: true,
                  fieldType: '',
                  isRequired: true,
                ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 50,
          ),
          SizedBox(
            width: 400,
            child: ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  final result = await provider.login(
                    email: signInController.email!,
                    password: signInController.password!,
                  );
                  result.fold(
                    (failure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Erro: ${failure.toString()}')),
                      );
                    },
                    (user) {
                      if (user != null) {
                        Modular.to.navigate(
                          '/${user.role.toLowerCase()}/${user.id}/home',
                        );
                      }
                    },
                  );
                }
              },
              child: Text(
                AppLocalizations.of(context)!.loginPageButtonLogin,
                style: AppTextStyles.button,
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey,
                      endIndent: 20,
                      indent: 20,
                    ),
                  ),
                  Text(
                    'ou',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: AppColors.secondaryGrey,
                        ),
                  ),
                  const Expanded(
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey,
                      endIndent: 20,
                      indent: 20,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.loginPageDoesntHaveAccount,
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: AppColors.secondaryGrey,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Modular.to.navigate(
                            '/login/find-your-account',
                          );
                        },
                        child: Text(
                          AppLocalizations.of(context)!.signUpPageButtonSignUp,
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                fontWeight: FontWeight.bold,
                                decorationColor: AppColors.primary,
                                decorationThickness: 2,
                              ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.loginPageTitle5,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: AppColors.secondaryGrey,
                            ),
                      ),
                      TextButton(
                        onPressed: () {
                          Modular.to.navigate('/login/sign-up');
                        },
                        child: Text(
                          AppLocalizations.of(context)!.loginPageRecoverAccess,
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                fontWeight: FontWeight.bold,
                                decorationColor: AppColors.primary,
                                decorationThickness: 2,
                              ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          )
        ],
      ),
      )
    );
  }
}