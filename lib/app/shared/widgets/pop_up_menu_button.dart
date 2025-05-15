import 'package:tcc_bag_finder/app/presentation/user/stores/user_provider.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_colors.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_dimensions.dart';
import 'package:tcc_bag_finder/app/shared/themes/dialogs/app_version_dialog.dart';
import 'package:tcc_bag_finder/app/shared/themes/dialogs/report_problem_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PopUpMenuButton extends StatelessWidget {
  const PopUpMenuButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      color: AppColors.secondary,
      icon: Icon(
        Icons.more_vert,
        color: AppColors.secondary,
        size: AppDimensions.iconLarge,
      ),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'versao',
          child: ListTile(
            leading: Icon(
              Icons.info_outline,
              color: AppColors.primary,
              size: AppDimensions.iconMedium,
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const AppVersionDialog(
                    appVersion: '1.0.0',
                  );
                },
              );
            },
            title: Text(
              'Versão do App',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ),
        PopupMenuItem<String>(
          value: 'relatar',
          child: ListTile(
            leading: Icon(
              Icons.report_problem,
              color: AppColors.primary,
              size: AppDimensions.iconMedium,
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return ReportProblemDialog(
                    onConfirm: (value) {},
                  );
                },
              );
            },
            title: Text(
              'Relatar Problema',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ),
        PopupMenuItem<String>(
          value: 'logout',
          onTap: () => Modular.get<UserProvider>().logout(),
          child: ListTile(
            leading: Icon(
              Icons.logout,
              color: AppColors.primary,
              size: AppDimensions.iconMedium,
            ),
            title: Text(
              'Logout',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ),
      ],
    );
  }
}
