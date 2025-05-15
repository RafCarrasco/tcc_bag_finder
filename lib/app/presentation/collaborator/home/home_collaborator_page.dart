import 'package:tcc_bag_finder/app/presentation/collaborator/home/widget/appbar/home_collaborator_app_bar_widget.dart';
import 'package:tcc_bag_finder/app/presentation/collaborator/home/widget/collaborator_actions_widget.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_dimensions.dart';
import 'package:tcc_bag_finder/app/presentation/user/stores/user_provider.dart';
import 'package:tcc_bag_finder/domain/entity/collaborator_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeCollaboratorPage extends StatefulWidget {
  const HomeCollaboratorPage({
    super.key,
  });

  @override
  State<HomeCollaboratorPage> createState() => _HomeCollaboratorPageState();
}

class _HomeCollaboratorPageState extends State<HomeCollaboratorPage> {
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
          child: HomeCollaboratorAppBarWidget(
            userName: provider.user!.fullName,
            company: (provider.user! as CollaboratorEntity).company,
          ),
        ),
        Expanded(
          child: CollaboratorActionsWidget(
            collaboratorId: provider.user!.id,
          ),
        ),
      ],
    );
  }
}
