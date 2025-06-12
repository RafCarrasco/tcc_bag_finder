import 'package:tcc_bag_finder/app/presentation/user/auth/widgets/login_text_field.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_colors.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_dimensions.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_icons.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FindYourAccountPage extends StatelessWidget {
  const FindYourAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              child: Image.asset(
                'images/group-interrogation.png',
                filterQuality: FilterQuality.high,
              ),
            ),
            Text(
              AppLocalizations.of(context)!.loginPageTitle5,
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                LoginTextField(
                  suffixIcon: AppIconsSecondaryGrey.emailIcon,
                  hint:
                      AppLocalizations.of(context)!.emailForContactPlaceholder,
                  isPassword: false,
                  fieldType: 'email',
                  isRequired: true,
                ),
                const SizedBox(
                  height: AppDimensions.verticalSpaceLarge,
                ),
              ],
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  AppLocalizations.of(context)!.needHelpPageSend,
                  style: AppTextStyles.button,
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  child: Text(
                    AppLocalizations.of(context)!.comeBackToHomepage,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.primary,
                        ),
                  ),
                  onPressed: () => Modular.to.navigate(
                    '/login/sign-in',
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
