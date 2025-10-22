import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:bag_finder/l10n/app_localizations.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_dimensions.dart';
import '../../../core/utils/app_icons.dart';
import '../../../core/utils/app_text_styles.dart';
import '../../../core/widgets/forgot_password_text_field.dart';
import '../../../shared/providers/user_provider.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final userProvider = Modular.get<UserProvider>();

  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    _cpfController.dispose();
    _emailController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _onSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final verificationResult = await userProvider.verifyTravelerCredentials(
      email: _emailController.text,
      cpf: _cpfController.text,
    );

    await verificationResult.fold(
      (failure) async {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(failure.errorMessage), backgroundColor: Colors.red),
        );
      },
      (userEntity) async {
        final resetResult = await userProvider.resetPassword(
          email: _emailController.text,
          cpf: _cpfController.text,
          newPassword: _newPasswordController.text,
        );

        setState(() => _isLoading = false);

        resetResult.fold(
          (failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(failure.errorMessage),
                  backgroundColor: Colors.red),
            );
          },
          (_) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Senha redefinida com sucesso!'),
                backgroundColor: Colors.green,
              ),
            );
            Modular.to.navigate('/login/sign-in');
          },
        );
      },
    );
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
                      'assets/images/group-interrogation.png',
                      height: 220,
                      filterQuality: FilterQuality.high,
                    ),
                    const SizedBox(height: AppDimensions.verticalSpaceLarge),
                    Text(
                      localization.loginPageTitle5,
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppDimensions.verticalSpaceLarge),

                    // CPF
                    ForgotPasswordTextField(
                      controller: _cpfController,
                      prefixIcon: AppIconsPrimary.personIcon,
                      hint: 'Digite seu CPF',
                      isPassword: false,
                      fieldType: 'cpf',
                      isRequired: true,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        MaskTextInputFormatter(
                          mask: '###.###.###-##',
                          filter: {"#": RegExp(r'[0-9]')},
                        ),
                      ],
                    ),
                    const SizedBox(height: AppDimensions.verticalSpaceMedium),

                    // E-mail
                    ForgotPasswordTextField(
                      controller: _emailController,
                      prefixIcon: AppIconsPrimary.emailIcon,
                      hint: localization.emailForContactPlaceholder,
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
                    ),
                    const SizedBox(height: AppDimensions.verticalSpaceMedium),

                    // Nova senha
                    ForgotPasswordTextField(
                      controller: _newPasswordController,
                      prefixIcon: AppIconsPrimary.passwordIcon,
                      hint: 'Nova senha',
                      isPassword: true,
                      fieldType: '',
                      isRequired: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Digite uma nova senha';
                        }
                        if (value.length < 6) {
                          return 'A senha deve ter pelo menos 6 caracteres';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: AppDimensions.verticalSpaceMedium),

                    // Confirmar senha
                    ForgotPasswordTextField(
                      controller: _confirmPasswordController,
                      prefixIcon: AppIconsPrimary.passwordIcon,
                      hint: 'Confirmar senha',
                      isPassword: true,
                      fieldType: '',
                      isRequired: true,
                      validator: (value) {
                        if (value != _newPasswordController.text) {
                          return 'As senhas não coincidem';
                        }
                        return null;
                      },
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
                            : const Icon(Icons.send),
                        label: Text(
                          localization.needHelpPageSend,
                          style: AppTextStyles.button,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppDimensions.verticalSpaceMedium),

                    TextButton(
                      onPressed: () => Modular.to.navigate('/login/sign-in'),
                      child: Text(
                        localization.comeBackToHomepage,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              decorationColor: AppColors.primary,
                            ),
                      ),
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
