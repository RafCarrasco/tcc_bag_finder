import 'package:flutter/material.dart';
import 'package:bag_finder/l10n/app_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../controller/sign_up_controller.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_dimensions.dart';
import '../../../core/utils/app_icons.dart';
import '../../../core/utils/app_text_styles.dart';
import '../../../core/widgets/login_text_field.dart';

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
    final localization = AppLocalizations.of(context)!;
    
    return Scaffold(
      body: SafeArea(
        child: Center( 
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                      'images/bagfinder-sign-up.png',

                      filterQuality: FilterQuality.high,
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
                  SizedBox(
                    height: AppDimensions.verticalSpaceExtraLarge,
                  ),
                  const SizedBox(height: AppDimensions.verticalSpaceExtraLarge), 
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        LoginTextField(
                          suffixIcon: AppIconsSecondaryGrey.passwordIcon,
                          hint: localization.cpfPlaceholder,
                          isPassword: false,
                          onChanged: (value) => signUpController.setCpf(value),
                          fieldType: 'cpf',
                          isRequired: true,
                        ),
                        const SizedBox(height: AppDimensions.verticalSpaceLarge),
                        LoginTextField(
                          suffixIcon: AppIconsSecondaryGrey.personIcon,
                          hint: localization.fullNamePlaceholder,
                          isPassword: false,
                          onChanged: (value) => signUpController.setFullName(value),
                          fieldType: 'fullName',
                          isRequired: true,
                        ),
                        const SizedBox(height: AppDimensions.verticalSpaceLarge),
                        LoginTextField(
                          suffixIcon: AppIconsSecondaryGrey.phoneIcon,
                          hint: localization.cellPhonePlaceholder,
                          isPassword: false,
                          onChanged: (value) {
                            signUpController.setPhone(value);
                          },
                          fieldType: 'cellPhone',
                          isRequired: true,
                        ),
                        const SizedBox(height: AppDimensions.verticalSpaceLarge),
                        LoginTextField(
                          suffixIcon: AppIconsSecondaryGrey.emailIcon,
                          hint: localization.emailPlaceholder,
                          isPassword: false,
                          fieldType: 'email',
                          onChanged: (value) => signUpController.setEmail(value),
                          isRequired: true,
                        ),
                        const SizedBox(height: AppDimensions.verticalSpaceLarge),
                        LoginTextField(
                          suffixIcon: AppIconsSecondaryGrey.passwordIcon,
                          hint: localization.passwordPlaceholder,
                          isPassword: true,
                          onChanged: (value) => signUpController.setPassword(value),
                          fieldType: 'password',
                          isRequired: true,
                        ),
                        const SizedBox(height: 50),
                      ],
                    ),
                  ),
                  
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.resolveWith<Color>(
                        (Set<WidgetState> states) {
                          if (signUpController.areFieldsValid() && !states.contains(WidgetState.disabled)) {
                            return AppColors.primary;
                          }
                          return AppColors.primary.withOpacity(0.5); 
                        },
                      ),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await signUpController.signUp(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(localization.loginPageAlreadyHaveAccount)), 
                        );
                      }
                    },
                    child: Text(
                      localization.signUpPageButtonSignUp,
                      style: AppTextStyles.button,
                    ),
                  ),

                  const SizedBox(height: AppDimensions.verticalSpaceMedium),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        localization.loginPageAlreadyHaveAccount,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: AppColors.secondaryGrey,
                            ),
                      ),
                      TextButton(
                        onPressed: () {
                          Modular.to.navigate('/login/sign-in');
                        },
                        child: Text(
                          localization.loginPageClickHere,
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
          ),
        ),
      ),
    );
  }
}