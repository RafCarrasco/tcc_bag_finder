import 'package:tcc_bag_finder/app/presentation/profile/widgets/profile_banner_widget.dart';
import 'package:tcc_bag_finder/app/presentation/profile/widgets/profile_info_field_widget.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_colors.dart';
import 'package:tcc_bag_finder/app/shared/themes/app_dimensions.dart';
import 'package:tcc_bag_finder/app/presentation/user/stores/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    super.key,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final provider = Modular.get<UserProvider>();
    return Scaffold(
      body: SafeArea(
        child: 
            Column(
              children: [
                AppBar(
                  title: const Text(
                    'MEU PERFIL',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  centerTitle: true,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () {
                      Modular.to.navigate(
                        '/login/sign-in',
                      );
                    },
                  ),
                  backgroundColor: Colors.white,
                  elevation: 0, 
                ),
                const Divider(
                  height: 1,
                  thickness: 1,
                  color: Colors.grey,
                ),
                const SizedBox(
                  height: 100,
                ),
                Text(
                    AppLocalizations.of(context)!.signUpPagePersonalDataField,
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0), 
                  child: InfoField(
                    title: 'CPF',
                    content: provider.user!.id.isEmpty
                      ? 'Não informado'
                      : provider.user!.id,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0), 
                  child: InfoField(
                    title: 'Nome Completo',
                    content: provider.user!.fullName.isEmpty
                      ? 'Não informado'
                      : provider.user!.fullName,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0), 
                  child: InfoField(
                    title: 'Data de Nascimento',
                    content: provider.user!.dateOfBirth.isEmpty
                      ? 'Não informado'
                      : provider.user!.dateOfBirth,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0), 
                  child: InfoField(
                    title: 'Número de celular',
                    content: provider.user!.phone.isEmpty
                      ? 'Não informado'
                      : provider.user!.phone,
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                Text(
                  AppLocalizations.of(context)!.signUpPageAccessDataField,
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0), 
                  child: InfoField(
                    title: 'E-mail',
                    content: provider.user!.email,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0), 
                  child: InfoField(
                    title: 'Senha',
                    content: '•' * provider.user!.password.length,
                  ),
                ),
                const SizedBox(
                    height: 75,
                  ),
                ElevatedButton(
                      onPressed: () {
                        Modular.to.pushNamed(
                        '/profile/edit',
                      );
                    },
                    child: Text(
                      'Editar Perfil',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: AppColors.secondary,
                        fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
        ),
      );                      
  }
}
