import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';
import '../../../shared/providers/user_provider.dart';
import 'package:bag_finder/core/widgets/appbar/profile_app_bar_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  static const Color _primaryColor = Color(0xFF4CAF50);
  static const double _avatarRadius = 48.0;

  @override
  void initState() {
    super.initState();
    final provider = Modular.get<UserProvider>();
    final travelerId = Modular.args.params['travelerId'];
    if (provider.user == null && travelerId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        provider.getUserById(travelerId);
      });
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

        final userName = user.fullName.isEmpty ? "Usuário" : user.fullName;
        final displayName =
            user.fullName.split(' ').isNotEmpty ? user.fullName.split(' ')[0] : "Usuário";

        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ProfileTravelerAppBarWidget(
                  userName: userName,
                  hint: '',
                ),
                Expanded(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 400),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 24),
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Center(
                                  child: CircleAvatar(
                                    radius: _avatarRadius,
                                    backgroundColor: Colors.grey,
                                    child: const Icon(Icons.person, size: 60, color: Colors.white),
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  top: _avatarRadius - (_avatarRadius / 2),
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Modular.to.pushNamed(
                                            '/traveler/${user.id}/profile/edit',
                                          );
                                        },
                                        child: Container(
                                          width: _avatarRadius,
                                          height: _avatarRadius,
                                          decoration: BoxDecoration(
                                            color: _primaryColor,
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(0.2),
                                                spreadRadius: 1,
                                                blurRadius: 4,
                                                offset: const Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          child: const Icon(
                                            Icons.settings,
                                            color: Colors.white,
                                            size: 24,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      const Text(
                                        'Editar',
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              "Olá, $displayName",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 24),
                            _buildSectionTitle("Dados pessoais", _primaryColor),
                            _buildInfo("CPF", _formatCpf(user.cpf ?? "")),
                            _buildInfo(
                              "Nome Completo",
                              user.fullName.isEmpty ? "Não informado" : user.fullName,
                            ),
                            _buildInfo(
                              "Número de celular",
                              user.phone?.isEmpty ?? true 
                                ? "Não informado" 
                                : _formatPhone(user.phone!),
                            ),
                            _buildInfo("Cargo", user.role.isEmpty ? "Não informado" : user.role),
                            const SizedBox(height: 12),
                            _buildSectionTitle("Dados de acesso", _primaryColor),
                            _buildInfo("E-mail", user.email),
                            _buildInfo("Senha", "********"),
                            const SizedBox(height: 12),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSectionTitle(String title, Color color) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 12.0),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: 18,
          color: color,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildInfo(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          content,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Divider(height: 20, thickness: 1, color: Colors.green),
      ],
    );
  }

  String _formatCpf(String cpf) {
    final cleanCpf = cpf.replaceAll(RegExp(r'\D'), '');
    if (cleanCpf.length == 11) {
      return cleanCpf.replaceAllMapped(
        RegExp(r'(\d{3})(\d{3})(\d{3})(\d{2})'),
        (match) =>
            '${match.group(1)}.${match.group(2)}.${match.group(3)}-${match.group(4)}',
      );
    }
    return cpf.isEmpty ? "Não informado" : cpf;
  }

  String _formatPhone(String phone) {
    final clean = phone.replaceAll(RegExp(r'\D'), '');
    if (clean.length == 11) {
      return '(${clean.substring(0, 2)}) ${clean.substring(2, 7)}-${clean.substring(7)}';
    } else if (clean.length == 10) {
      return '(${clean.substring(0, 2)}) ${clean.substring(2, 6)}-${clean.substring(6)}';
    }
    return phone;
  }
}
