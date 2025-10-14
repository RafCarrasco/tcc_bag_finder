import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    final media = MediaQuery.of(context).size;
    const double horizontalPadding = 24.0;
    const double maxWidth = 400;

    return Scaffold(
      backgroundColor: Colors.white,
      
      // 1. AnnotatedRegion: Configura a barra de status para ter fundo e ícones corretos
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
        
        // 2. Container: Garante que o fundo total (incluindo área insegura) seja branco
        child: Container(
          color: Colors.white,
          width: double.infinity,
          height: double.infinity,
          
          child: SafeArea( 
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // --- IMAGEM DE TOPO (35% da tela) ---
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final isDesktop = constraints.maxWidth > 800;
                      return SizedBox(
                        width: isDesktop
                            ?400 
                            : double.infinity,
                        height: isDesktop
                            ? 350
                            : MediaQuery.of(context).size.height * 0.35,
                        child: Image.asset(
                          'assets/images/bagfinder-login.png',
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 30),

                  // 3. Conteúdo Principal Centralizado e com Padding
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: maxWidth),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.loginPageTitle,
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .copyWith(fontWeight: FontWeight.w700),
                            textAlign: TextAlign.center,
                          ),

                          const SizedBox(height: AppDimensions.verticalSpaceLarge),
                          
                          // --- FORMULÁRIO ---
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                LoginTextField(
                                  onChanged: signInController.setEmail,
                                  suffixIcon: AppIconsSecondaryGrey.emailIcon,
                                  hint: AppLocalizations.of(context)!.emailPlaceholder,
                                  isPassword: false,
                                  fieldType: 'email',
                                  isRequired: true,
                                ),
                                const SizedBox(height: AppDimensions.verticalSpaceLarge),
                                LoginTextField(
                                  onChanged: signInController.setPassword,
                                  suffixIcon: AppIconsSecondaryGrey.passwordIcon,
                                  hint: AppLocalizations.of(context)!.passwordPlaceholder,
                                  isPassword: true,
                                  fieldType: '',
                                  isRequired: true,
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 40),

                          // --- BOTÃO LOGIN ---
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: isLoginButtonEnabled() ? () async {
                                if (_formKey.currentState!.validate()) {
                                  final result = await provider.login(
                                    email: signInController.email!,
                                    password: signInController.password!,
                                  );
                                  result.fold(
                                    (failure) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('Erro: ${failure.errorMessage}'),
                                        ),
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
                              } : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                AppLocalizations.of(context)!.loginPageButtonLogin,
                                style: AppTextStyles.button,
                              ),
                            ),
                          ),
                          
                          const SizedBox(height: 30),

                          // --- LINKS (Rodapé) ---
                          Column(
                            children: [
                              // Cadastre-se
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.loginPageDoesntHaveAccount,
                                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: AppColors.secondaryGrey),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Modular.to.navigate('/login/sign-up');
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
                              
                              const SizedBox(height: 10),
                              
                              // Divisor 'ou'
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Expanded(child: Divider(thickness: 1, color: Colors.grey, endIndent: 10, indent: 10)),
                                  Text('ou', style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: AppColors.secondaryGrey)),
                                  const Expanded(child: Divider(thickness: 1, color: Colors.grey, endIndent: 10, indent: 10)),
                                ],
                              ),
                              
                              const SizedBox(height: 10),
                              
                              // Recuperar Acesso
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.loginPageAlreadyHaveAccount,
                                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: AppColors.secondaryGrey),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Modular.to.navigate('/login/forgot-password');
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
                          
                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
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