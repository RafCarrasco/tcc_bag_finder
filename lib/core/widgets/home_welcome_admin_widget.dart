import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../utils/app_dimensions.dart';
import 'pop_up_menu_button.dart';

class HomeWelcomeAdminWidget extends StatelessWidget {
  final String userName;
  final String companyName;

  const HomeWelcomeAdminWidget({
    super.key,
    required this.userName,
    required this.companyName,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Console Admin',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: AppDimensions.fontMedium,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Text(
              '${AppLocalizations.of(context)!.helloUserHomepage}$userName',
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: AppDimensions.fontMedium,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Text(
              'Bem vindo ao console de administrador',
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            ),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PopUpMenuButton(),
            Text(
              companyName,
              style: const TextStyle(
                fontSize: AppDimensions.fontMedium,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        )
      ],
    );
  }
}
