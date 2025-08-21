// pages/authentificationScreens/login_screen.dart
import 'package:entert_projet_01/theme/colors.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _passWord = TextEditingController();
  final _formKey = GlobalKey();
  Widget textFormField(
    TextEditingController controller,
    String type,
    IconData icon,
  ) => TextFormField(
    controller: controller,
    decoration: InputDecoration(
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
      if (value == null || value.isEmpty) {
        return '$type ne peut être vide';
      }
      if (type == 'mail') {
        if (value.contains(
              RegExp('r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}'),
            ) ==
            false) {
          return 'Entrez un mail valide';
        }
      }
      if (type == 'passWorld') {
        if (value.length < 6) {
          return 'entrez un mot de passe valide';
        }
      }
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(backgroundColor: backgroundColor),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
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
                textFormField(_email, 'mail', Icons.mail),
                SizedBox(height: 18),
                textFormField(_passWord, 'passWord', Icons.password),
                SizedBox(height: 26),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Container(
                      padding: EdgeInsets.only(
                        left: 30,
                        right: 30,
                        top: 12,
                        bottom: 12,
                      ),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Se Connecter',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Center(child: Text('''Pas encore de Compte ?\t S'inscrire''')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
