// pages/authScreens/login_screen.dart
import 'package:entert_projet_01/main.dart';
import 'package:entert_projet_01/pages/authScreens/register_screen.dart';
import 'package:entert_projet_01/providers/user_provider.dart';
import 'package:entert_projet_01/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passWordController = TextEditingController();

  Widget textFormField(
    TextEditingController controller,
    String type,
    IconData icon,
  ) => TextFormField(
    controller: controller,
    decoration: InputDecoration(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        gapPadding: 16,
      ),
      label: Text(
        type,
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
      ),
      hintText: 'Entrez votre $type',
      prefixIcon: Icon(icon, size: 22, color: primaryColor),
    ),
    validator: (value) {
      if (value?.trim() == null || value!.isEmpty) {
        return '$type ne peut être vide';
      }
      if (type == 'mail') {
        if (value.contains(
              RegExp('r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}'),
            ) ==
            false) {
          return 'Entrez un mail valide';
        }
      }
      if (type == 'passWord') {
        if (value.length < 6) {
          return 'entrez un mot de passe valide';
        }
      }
      return null;
    },
  );

  void _login(UserProvider auth) async {
    if (!_formKey.currentState!.validate()) return;

    await auth.login(
      _emailController.text.trim(),
      _passWordController.text.trim(),
    );
    if (auth.errorMessage != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(auth.errorMessage!)));
      return;
    }

    // 🎯 Redirection vers page login
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => NavigationPage()),
      (route) => false,
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passWordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<UserProvider>();
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(backgroundColor: backgroundColor),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 24),
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Text(
                        'Connexion',
                        style: style(24, 3),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Veuillez remplir les informations pour continuer',
                        style: style(12, 1),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                textFormField(_emailController, 'mail', Icons.mail),
                SizedBox(height: 18),
                textFormField(_passWordController, 'passWord', Icons.password),
                SizedBox(height: 26),
                SizedBox(
                  width: double.infinity,

                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: auth.isLoading ? null : () => _login(auth),

                    child:
                        auth.isLoading
                            ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                            : Text(
                              'Se Connecter',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Pas de compte ?", style: style(12, 2)),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignInPage()),
                        );
                      },
                      child: Text(
                        "S'inscrire",
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
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
    );
  }
}
