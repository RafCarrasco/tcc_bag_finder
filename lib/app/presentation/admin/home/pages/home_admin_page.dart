import 'package:tcc_bag_finder/app/presentation/admin/home/widget/admin_actions_widget.dart';
import 'package:tcc_bag_finder/app/presentation/admin/home/widget/appbar/home_admin_app_bar_widget.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_dimensions.dart';
import 'package:tcc_bag_finder/app/presentation/user/stores/user_provider.dart';
import 'package:tcc_bag_finder/domain/entity/admin_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeAdminPage extends StatefulWidget {
  final String adminId;

  const HomeAdminPage({
    super.key,
    required this.adminId,
  });

  @override
  State<HomeAdminPage> createState() => _HomeAdminPageState();
}

class _HomeAdminPageState extends State<HomeAdminPage> {
  var provider = Modular.get<UserProvider>();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              AppDimensions.radiusExtraLarge,
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 5,
                offset: Offset(
                  0,
                  3,
                ),
              ),
            ],
          ),
          child: HomeAdminAppBarWidget(
            userName: provider.user!.fullName,
            company: (provider.user! as AdminEntity).company,
          ),
        ),
        Expanded(
          child: AdminActionsWidget(
            adminId: widget.adminId,
          ),
        ),
      ],
    );
  }
}
