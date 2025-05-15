import 'package:tcc_bag_finder/app/presentation/user/auth/widgets/login_text_field.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_colors.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_dimensions.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_icons.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({
    super.key,
  });

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
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
              AppLocalizations.of(context)!.loginPageTitle3,
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                LoginTextField(
                  prefixIcon: AppIconsSecondaryGrey.emailIcon,
                  hint:
                      AppLocalizations.of(context)!.emailForContactPlaceholder,
                  isPassword: false,
                  fieldType: 'email',
                  isRequired: true,
                ),
                const SizedBox(
                  height: AppDimensions.verticalSpaceLarge,
                ),
                LoginTextField(
                  prefixIcon: AppIconsSecondaryGrey.messageIcon,
                  hint: AppLocalizations.of(context)!
                      .contactUsYourProblemPlaceholder,
                  isPassword: false,
                  fieldType: 'email',
                  isRequired: false,
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
                  onPressed: () => Modular.to.navigate('/login/sign-in'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
