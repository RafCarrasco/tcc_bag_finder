import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../shared/providers/user_provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    final provider = Modular.get<UserProvider>();
    final travelerId = Modular.args.params['travelerId'];
    if (provider.user == null && travelerId != null) {
      provider.getUserById(travelerId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Modular.get<UserProvider>();
    final user = provider.user;

    if (user == null || provider.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
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
                onPressed: () => Modular.to.pop(),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.logout, color: Colors.red),
                  tooltip: 'Sair',
                  onPressed: () {
                    provider.logout();
                    Modular.to.navigate('/login');
                  },
                ),
              ],
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            const Divider(height: 1, thickness: 1, color: Colors.grey),

            const SizedBox(height: 32),

            // Seção: Dados pessoais
            const Text(
              "Dados pessoais",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 12),
            _buildInfo("Nome Completo", user.fullName.isEmpty ? "Não informado" : user.fullName),
            _buildInfo("Número de celular", user.phone.isEmpty ? "Não informado" : user.phone),
            if (user.role != "TRAVELER") _buildInfo("Cargo", user.role),

            const SizedBox(height: 32),

            // Seção: Dados de acesso
            const Text(
              "Dados de acesso",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 12),
            _buildInfo("E-mail", user.email),
            _buildInfo("Status", user.isActive ? "Ativo" : "Inativo"),

            const Spacer(),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {
                  Modular.to.pushNamed('/traveler/${user.id}/profile/edit');
                },
                child: const Text(
                  "Editar Perfil",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfo(String title, String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
          const SizedBox(height: 4),
          Text(content, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
