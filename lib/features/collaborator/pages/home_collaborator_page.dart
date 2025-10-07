import 'package:bag_finder/core/entity/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../core/entity/collaborator_entity.dart';
import '../../../shared/providers/user_provider.dart';
import '../../../core/utils/app_dimensions.dart';
import '../../../core/widgets/collaborator_actions_widget.dart';
import '../../../core/widgets/home_collaborator_app_bar_widget.dart';
import '../../../features/auth/controller/auth_controller.dart';

class HomeCollaboratorPage extends StatefulWidget {
  const HomeCollaboratorPage({
    super.key,
  });

  @override
  State<HomeCollaboratorPage> createState() => _HomeCollaboratorPageState();
}

class _HomeCollaboratorPageState extends State<HomeCollaboratorPage> {
  var provider = Modular.get<UserProvider>();
  var auth_provider = Modular.get<AuthService>();

  @override
  Widget build(BuildContext context) {
    auth_provider.saveUserToStorage(provider.user!);
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
            company: (provider.user! as CollaboratorEntity).company_id,
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
