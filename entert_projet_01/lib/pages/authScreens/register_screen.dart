// pages/authScreens/register_screen.dart

import 'package:entert_projet_01/pages/authScreens/login_screen.dart';
import 'package:entert_projet_01/providers/user_provider.dart';
import 'package:entert_projet_01/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});
  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  //declaration des variables necessaires pour auth
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mdpController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _mdpConfirmController = TextEditingController();

  bool isObscure = false;

  //fonction pour inscription
  void _register(UserProvider auth) async {
    if (!_formKey.currentState!.validate()) return;

    await auth.signIn(
      mail: _emailController.text.trim(),
      passWord: _mdpController.text.trim(),
      name: _nameController.text.trim(),
      surName: _surnameController.text.trim(),
    );
    if (auth.errorMessage != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(auth.errorMessage!)));
      return;
    }

    // 🎯 Redirection vers page login
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return LoginScreen();
        },
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _mdpController.dispose();
    _nameController.dispose();
    _surnameController.dispose();
    _mdpConfirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<UserProvider>();

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
          Align(
            alignment: Alignment.center,
            child:   Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Inscription', style: style(20, 3)),
                SizedBox(height: 12),

                Text(
                  "Remplissez vos informations ci-dessous",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),),
            SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Icon(Icons.person),
                      prefixIconColor: primaryColor,
                      label: Text('name', style: TextStyle(fontWeight: FontWeight.w400,fontSize: 12),),

                      hintText: "Entrer votre nom",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black12),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    validator: validateName,
                  ),
                  SizedBox(height: 16),

                  //prenom validation
                  TextFormField(
                    controller: _surnameController,
                    decoration: InputDecoration(
                      label: Text('firstName', style: TextStyle(fontWeight: FontWeight.w400,fontSize: 12),),

                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Icon(Icons.person),
                      prefixIconColor: primaryColor,
                      hintText: "Entrer votre prénom",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black12),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Ce champ ne peut pas être vide";
                      }

                      // Regex autorisant lettres, accents, espaces et tirets
                      final nameExp = RegExp(r"^[A-Za-zÀ-ÖØ-öø-ÿ \-']+$");
                      if (!nameExp.hasMatch(value.trim())) {
                        return "Le prénom contient des caractères invalides";
                      }

                      if (value.trim().length < 2) {
                        return "Le prénom est trop court";
                      }

                      if (value.trim().length > 30) {
                        return "Le prénom est trop long";
                      }

                      return null;
                    },
                  ),

                  SizedBox(height: 16),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      label: Text('mail', style: TextStyle(fontWeight: FontWeight.w400,fontSize: 12),),

                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Icon(Icons.mail),
                      prefixIconColor: primaryColor,
                      hintText: "Entrer votre email",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black12),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    validator: validateEmail,
                  ),
                  SizedBox(height: 16),

                  //password validation
                  TextFormField(
                    controller: _mdpController,
                    obscureText: isObscure,

                    decoration: InputDecoration(
                      label: Text('passWord', style: TextStyle(fontWeight: FontWeight.w400,fontSize: 12),),

                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Icon(Icons.password),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isObscure = !isObscure;
                          });
                        },
                        icon: Icon(
                          isObscure ? Icons.visibility : Icons.visibility_off,
                        ),
                      ),
                      prefixIconColor: primaryColor,
                      suffixIconColor: primaryColor,
                      hintText: "Entrer votre mot de passe",

                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black12),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "ce champs ne peut pas être vide";
                      }
                      if (value.length < 8) {
                        return "Le mot de passe doit contenir au moins 8 caractères";
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 16),

                  //verifiacation du mot de passe
                  TextFormField(
                    controller: _mdpConfirmController,
                    obscureText: isObscure,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Icon(Icons.password),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isObscure = !isObscure;
                          });
                        },
                        icon: Icon(
                          isObscure ? Icons.visibility : Icons.visibility_off,
                        ),
                      ),
                      prefixIconColor: primaryColor,
                      label: Text('passWord', style: TextStyle(fontWeight: FontWeight.w400,fontSize: 12),),
                      suffixIconColor: primaryColor,
                      hintText: "Confirmez votre mot de passe",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black12),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Ce champ ne peut pas être vide";
                      }
                      if (value != _mdpController.text) {
                        return "Les mots de passe ne correspondent pas";
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 24),
                ],
              ),
            ),

            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                onPressed: auth.isLoading ? null : () => _register(auth),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child:
                    auth.isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                          "S'inscrire",
                          style: TextStyle(fontSize: 18),
                        ),
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Déjà un compte ?"),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  child: Text(
                    "Se connecter",
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
    );
  }
}

String? validateName(String? value) {
  if (value == null || value.trim().isEmpty) {
    return "Ce champ ne peut pas être vide";
  }

  // Regex autorisant lettres, accents, espaces et tirets
  final nameExp = RegExp(r"^[A-Za-zÀ-ÖØ-öø-ÿ \-']+$");
  if (!nameExp.hasMatch(value.trim())) {
    return "Le nom contient des caractères invalides";
  }

  if (value.trim().length < 2) {
    return "Le nom est trop court";
  }

  if (value.trim().length > 30) {
    return "Le nom est trop long";
  }

  return null;
}
// Validation du mail

String? validateEmail(String? value) {
  if (value == null || value.trim().isEmpty) {
    return "Ce champ ne peut pas être vide";
  }

  // Regex simple pour validation d'email
  final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  if (!emailRegExp.hasMatch(value.trim())) {
    return "Entrez un email valide";
  }

  return null;
}
