import 'package:bag_finder/core/widgets/edit_profile_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../core/widgets/appbar/profile_app_bar_widget.dart';
import '../../../shared/providers/user_provider.dart';
import '../../../core/utils/global_snackbar.dart';
import '../../../core/entity/user_entity.dart';
import '../../../core/utils/app_colors.dart';


class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _cpfController;
  late TextEditingController _passwordController;

  bool _obscurePassword = true;

  // A cor primária será acessada via AppColors.primary, removendo a variável local _primaryColor

  @override
  void initState() {
    super.initState();
    // Acessa o UserProvider para pré-popular os campos
    final provider = Modular.get<UserProvider>();
    final user = provider.user!;

    _nameController = TextEditingController(text: user.fullName);
    _emailController = TextEditingController(text: user.email);
    _phoneController = TextEditingController(text: user.phone);
    _cpfController = TextEditingController(text: user.cpf ?? '');
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _cpfController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile(UserProvider provider) async {
    if (_formKey.currentState!.validate()) {
      final user = provider.user!;
      final updatedUser = user.copyWith(
        fullName: _nameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        cpf: _cpfController.text,
      );

      // Aqui, você deve incluir a lógica para atualizar a senha se _passwordController.text não estiver vazio
      // Por enquanto, atualizamos apenas os dados do UserEntity
      await provider.updateUser(user: updatedUser);

      if (mounted) {
        GlobalSnackBar.info('Perfil atualizado com sucesso!');
        Modular.to.pop();
      }
    } else {
      GlobalSnackBar.error('Por favor, preencha todos os campos obrigatórios.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Modular.get<UserProvider>();
    final user = provider.user!;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ProfileTravelerAppBarWidget(
              userName: user.fullName.isEmpty ? "Usuário" : user.fullName,
              hint: '',
            ),
            Expanded(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          // Avatar
                          Center(
                            child: CircleAvatar(
                              radius: 48,
                              backgroundColor: AppColors.primary.withOpacity(0.5),
                              child: Text(
                                user.fullName.isNotEmpty ? user.fullName[0] : "U",
                                style: const TextStyle(fontSize: 40, color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(height: 28),

                          // DADOS PESSOAIS
                          _buildSectionTitle("Dados pessoais"),
                          EditProfileTextField(
                            label: "Nome completo",
                            controller: _nameController,
                            icon: Icons.person,
                            hint: "Digite seu nome completo",
                            validator: (value) => value!.isEmpty ? 'O nome é obrigatório' : null,
                          ),
                          // EditProfileField já inclui SizedBox(height: 16) no final
                          EditProfileTextField(
                            label: "CPF",
                            controller: _cpfController,
                            icon: Icons.badge,
                            hint: "Digite seu CPF",
                            keyboardType: TextInputType.number,
                            validator: (value) => value!.isEmpty ? 'O CPF é obrigatório' : null,
                          ),
                          EditProfileTextField(
                            label: "Telefone",
                            controller: _phoneController,
                            icon: Icons.phone,
                            hint: "Digite seu número de telefone",
                            keyboardType: TextInputType.phone,
                          ),

                          const SizedBox(height: 8), 
                          // DADOS DE ACESSO
                          _buildSectionTitle("Dados de acesso"),
                          EditProfileTextField(
                            label: "E-mail",
                            controller: _emailController,
                            icon: Icons.email,
                            hint: "Digite seu e-mail",
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) => value!.isEmpty ? 'O e-mail é obrigatório' : null,
                          ),
                          // Campo de Senha usando o toggle de visibilidade
                          EditProfileTextField(
                            label: "Senha",
                            controller: _passwordController,
                            icon: Icons.lock,
                            hint: "Deixe em branco para manter a senha atual",
                            isPassword: _obscurePassword, // Passa o estado atual para o widget
                            onTogglePassword: () { // Callback para alternar o estado
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                            // Não adicionamos validador aqui, permitindo que a senha seja opcional
                          ),

                          const SizedBox(height: 24),
                          // BOTÕES
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () => _saveProfile(provider),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primary, // Usando AppColors.primary
                                    padding: const EdgeInsets.symmetric(vertical: 18),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: const Text(
                                    'Salvar',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () => Modular.to.pop(), // Pop é suficiente se a navegação já trouxe para cá
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(vertical: 18),
                                    side: BorderSide(color: AppColors.primary), // Usando AppColors.primary
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: Text(
                                    'Cancelar',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primary, // Usando AppColors.primary
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Mantendo _buildSectionTitle, mas usando AppColors.primary
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: 18,
          color: AppColors.primary,
        ),
      ),
    );
  }
  
  // A função _buildEditableField foi removida.
}
