import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';
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
    return Consumer<UserProvider>(
      builder: (context, provider, _) {
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
                    'SEUS DADOS',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  centerTitle: true,
                  backgroundColor: Colors.white,
                  elevation: 0,
                ),
                const Divider(height: 1, thickness: 1, color: Colors.grey),
                const SizedBox(height: 24),
                const CircleAvatar(
                  radius: 48,
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, size: 64, color: Colors.white),
                ),
                const SizedBox(height: 12),
                Text(
                  "Olá, ${user.fullName.isEmpty ? "Usuário" : user.fullName}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Dados pessoais",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _buildInfo("CPF", user.cpf ?? "Não informado"),
                        _buildInfo(
                            "Nome Completo",
                            user.fullName.isEmpty
                                ? "Não informado"
                                : user.fullName),
                        _buildInfo("Número de celular",
                            user.phone.isEmpty ? "Não informado" : user.phone),
                        _buildInfo("Cargo",
                            user.role.isEmpty ? "Não informado" : user.role),
                        const SizedBox(height: 24),
                        const Text(
                          "Dados de acesso",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _buildInfo("E-mail", user.email),
                        _buildInfo("Senha", "********"),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          onPressed: () {
                            Modular.to.pushNamed(
                                '/traveler/${user.id}/profile/edit');
                          },
                          child: const Text(
                            "Editar Perfil",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red.shade700,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          onPressed: () {
                            provider.logout();
                            Modular.to.navigate('/login');
                          },
                          child: const Text(
                            "Logout",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfo(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          content,
          style: const TextStyle(fontSize: 16, color: Colors.black),
        ),
        const Divider(height: 20, thickness: 1),
      ],
    );
  }
}
