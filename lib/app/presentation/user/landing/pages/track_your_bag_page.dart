import 'package:tcc_bag_finder/app/presentation/user/landing/controller/landing_page_step_progess.dart';
import 'package:tcc_bag_finder/app/presentation/user/landing/widgets/progress_indicator.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_dimensions.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';

class TrackYourBagPage extends StatelessWidget {
  const TrackYourBagPage({super.key});

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
              'images/flying-around.png',
              filterQuality: FilterQuality.high,
            ),
          ),
          ProgressIndicatorWidget(
            controller: controller,
          ),
          Text(
            AppLocalizations.of(context)!.landingPageFirstTitle,
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
              AppLocalizations.of(context)!.landingPageFirstText,
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
                controller.nextPage();
              },
              child: Text(
                AppLocalizations.of(context)!.landingPageButtonTextNext,
                style: AppTextStyles.button,
              ),
            ),
          )
        ],
      ),
    );
  }
}
