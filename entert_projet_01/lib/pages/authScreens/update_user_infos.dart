// pages/authScreens/update_user_infos.dart
import 'package:entert_projet_01/pages/authScreens/register_screen.dart';
import 'package:entert_projet_01/providers/user_provider.dart';
import 'package:entert_projet_01/utils/colors.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateUserInfosScreens extends StatefulWidget {
  const UpdateUserInfosScreens({super.key});

  @override
  State<UpdateUserInfosScreens> createState() => _UpdateUserInfosScreensState();
}

class _UpdateUserInfosScreensState extends State<UpdateUserInfosScreens> {
  final _form = GlobalKey<FormState>();
  late var _nameCtrl = TextEditingController();
  late var _surNameCtrl = TextEditingController();
  late UserProvider user;

  @override
  void initState() {
    super.initState();
    user = context.read<UserProvider>();

    final userDisplayName = user.user?.displayName ?? '';
    final parts = userDisplayName.split(' ');
    final name = parts.isNotEmpty ? parts[0] : '';
    final surName = parts.length > 1 ? parts[1] : '';

    _nameCtrl.text = name;
    _surNameCtrl = TextEditingController(text: surName);
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _surNameCtrl.dispose();

    super.dispose();
  }

  void saveUpdate(UserProvider user) async {
    try {
      if (_form.currentState!.validate()) {
        await user.updateProfile(
          name: _nameCtrl.text,
          surName: _surNameCtrl.text,
        );
        //  _form.currentState?.reset();
        //        _nameCtrl.text = user.user!.displayName.split(' ')[0];
        //  _surNameCtrl.text = user.user!.displayName.split(' ')[1];
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Données mise à jour avec succès')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erreur $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text('Modifier les informations'),
        centerTitle: true,
      ),
      body: Form(
        key: _form,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(height: 12),
              Text(
                textAlign: TextAlign.center,
                'Vous êtes sur le point de modifier vos informations de profile',
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _nameCtrl,

                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(Icons.person),
                  prefixIconColor: primaryColor,
                  label: Text(
                    'name',
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
                  ),

                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                validator: validateName,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _surNameCtrl,

                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(Icons.person),
                  prefixIconColor: primaryColor,
                  label: Text(
                    'surName',
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
                  ),

                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                validator: validateName,
              ),
              SizedBox(height: 24),
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
                  onPressed: () => saveUpdate(user),

                  child: Text(
                    'Enregistrer',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
