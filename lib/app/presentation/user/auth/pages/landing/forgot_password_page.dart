import 'package:tcc_bag_finder/app/presentation/user/auth/widgets/login_text_field.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_colors.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_icons.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
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
            LoginTextField(
              suffixIcon: AppIconsSecondaryGrey.emailIcon,
              hint: "E-mail",
              isPassword: false,
              fieldType: 'email',
              isRequired: true,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  'oi',
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
                    'oi',
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
