// pages/screens/profile_page.dart
import 'package:entert_projet_01/providers/user_provider.dart';
import 'package:entert_projet_01/theme/colors.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<Map<String, dynamic>> buildInfo = [
    {'icon': FontAwesomeIcons.userPen, 'buildName': 'Edit Profile'},
    {'icon': Icons.notifications, 'buildName': 'Notifications'},
    {'icon': Icons.settings, 'buildName': 'Settings'},
    {'icon': Icons.lock, 'buildName': 'Change PassWord'},
  ];
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
  

    final user = userProvider.user;
    if (user == null) {
      return Scaffold(body: Center(child: Text('Aucun utilisateur connecté')));
    }
    return Scaffold(
      backgroundColor: backgroundColor,

      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text('Profile', style: style(24, 3)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 5,
                        style: BorderStyle.solid,
                        color: Colors.green,
                        strokeAlign: BorderSide.strokeAlignInside,
                      ),
                      shape: BoxShape.circle,
                      color: Colors.white,
                      // backgroundBlendMode: BlendMode.color,
                      image: DecorationImage(
                        image: NetworkImage(faker.image.loremPicsum()),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Icon(
                        FontAwesomeIcons.solidPenToSquare,
                        color: textColor,
                        size: 24,
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(user.displayName, style: style(18, 3)),
                ],
              ),
            ),
            SizedBox(height: 18),
            Expanded(
              child: SizedBox(
                child: ListView.builder(
                  itemCount: buildInfo.length,
                  itemBuilder: (context, indice) {
                    return buildProfileWidget(
                      buildInfo[indice]['icon'],
                      buildInfo[indice]['buildName'],
                    );
                  },
                ),
              ),
            ),

            GestureDetector(
              onTap: () async {
                await userProvider.signOut();
              },
              child: Container(
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.only(left: 16, right: 16, top: 10),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.logout, size: 24, color: Colors.red),
                  ),
                  title: Text(
                    'Log Out',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildProfileWidget(
  IconData icon,
  String buildName,

  ///  CallbackAction? action,
) => Container(
  padding: EdgeInsets.all(7),
  margin: EdgeInsets.only(left: 16, right: 16, top: 10),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20),
  ),
  child: ListTile(
    leading: CircleAvatar(
      backgroundColor: textColor,
      child: Icon(icon, size: 24, color: Colors.white),
    ),
    title: Text(buildName, style: style(16, 2)),
    trailing: CircleAvatar(
      backgroundColor: backgroundColor,
      child: Icon(Icons.arrow_right, size: 24, color: textColor),
    ),
  ),
);
