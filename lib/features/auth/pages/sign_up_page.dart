import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:bag_finder/l10n/app_localizations.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_dimensions.dart';
import '../../../core/utils/app_icons.dart';
import '../../../core/utils/app_text_styles.dart';
import '../../../core/widgets/sign_up_text_field.dart';
import '../controller/sign_up_controller.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final SignUpController signUpController = Modular.get<SignUpController>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _cpfController.dispose();
    _fullNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _onSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    await signUpController.signUp(context);
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 450),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'images/bagfinder-sign-up.png',
                      height: 220,
                      filterQuality: FilterQuality.high,
                    ),
                    const SizedBox(height: AppDimensions.verticalSpaceLarge),
                    Text(
                      localization.loginPageTitle2,
                      style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      localization.loginPageTitle2SecondLine,
                      style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppDimensions.verticalSpaceExtraLarge),

                    // CPF
                    SignUpTextField(
                      controller: _cpfController,
                      prefixIcon: (AppIconsSecondaryGrey.personIcon.icon),
                      hint: localization.cpfPlaceholder,
                      isPassword: false,
                      fieldType: 'cpf',
                      isRequired: true,
                      keyboardType: TextInputType.number,
                      onChanged: (value) => signUpController.setCpf(value),
                    ),
                    const SizedBox(height: AppDimensions.verticalSpaceMedium),

                    // Nome
                    SignUpTextField(
                      controller: _fullNameController,
                      prefixIcon: (AppIconsSecondaryGrey.personIcon.icon),
                      hint: localization.fullNamePlaceholder,
                      isPassword: false,
                      fieldType: 'fullName',
                      isRequired: true,
                      onChanged: (value) => signUpController.setFullName(value),
                    ),
                    const SizedBox(height: AppDimensions.verticalSpaceMedium),

                    // Telefone
                    SignUpTextField(
                      controller: _phoneController,
                      prefixIcon: (AppIconsSecondaryGrey.phoneIcon.icon),
                      hint: localization.cellPhonePlaceholder,
                      isPassword: false,
                      fieldType: 'cellPhone',
                      isRequired: true,
                      keyboardType: TextInputType.phone,
                      onChanged: (value) => signUpController.setPhone(value),
                    ),
                    const SizedBox(height: AppDimensions.verticalSpaceMedium),

                    // E-mail
                    SignUpTextField(
                      controller: _emailController,
                      prefixIcon: (AppIconsSecondaryGrey.emailIcon.icon),
                      hint: localization.emailPlaceholder,
                      isPassword: false,
                      fieldType: 'email',
                      isRequired: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Informe o e-mail';
                        }
                        if (!value.contains('@') || !value.contains('.')) {
                          return 'E-mail inválido';
                        }
                        return null;
                      },
                      onChanged: (value) => signUpController.setEmail(value),
                    ),
                    const SizedBox(height: AppDimensions.verticalSpaceMedium),

                    // Senha
                    SignUpTextField(
                      controller: _passwordController,
                      prefixIcon: (AppIconsSecondaryGrey.passwordIcon.icon),
                      hint: localization.passwordPlaceholder,
                      isPassword: true,
                      fieldType: 'password',
                      isRequired: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Digite uma senha';
                        }
                        if (value.length < 6) {
                          return 'A senha deve ter pelo menos 6 caracteres';
                        }
                        return null;
                      },
                      onChanged: (value) => signUpController.setPassword(value),
                    ),
                    const SizedBox(height: 80),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _isLoading ? null : _onSubmit,
                        icon: _isLoading
                            ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Icon(Icons.person_add),
                        label: Text(
                          localization.signUpPageButtonSignUp,
                          style: AppTextStyles.button,
                        ),
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
                          onPressed: () => Modular.to.navigate('/login/sign-in'),
                          child: Text(
                            localization.loginPageClickHere,
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                  decorationColor: AppColors.primary,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
