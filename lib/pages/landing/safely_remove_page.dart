import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../controller/landing_page_step_progess.dart';
import '../../core/utils/app_dimensions.dart';
import '../../core/utils/app_text_styles.dart';
import '../../core/widgets/progress_indicator.dart';

class SafelyRemovePage extends StatelessWidget {
  const SafelyRemovePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Modular.get<LandingPageStepProgess>();

    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: AppDimensions.paddingMedium),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            child: Image.asset(
              'images/two-persons.png',
              filterQuality: FilterQuality.high,
            ),
          ),
          ProgressIndicatorWidget(
            controller: controller,
          ),
          Text(
            AppLocalizations.of(context)!.landingPageThirdTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingSmall,
            ),
            child: Text(
              AppLocalizations.of(context)!.landingPageThirdText,
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Modular.to.navigate(
                  '/login/sign-in',
                );
              },
              child: Text(
                AppLocalizations.of(context)!.landingPageButtonTextStart,
                style: AppTextStyles.button,
              ),
            ),
          )
        ],
      ),
    );
  }
}
