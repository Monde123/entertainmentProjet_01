// view/screens/profile_page.dart
import 'package:entert_projet_01/view/authScreens/login_screen.dart';
import 'package:entert_projet_01/view/authScreens/update_user_infos.dart';
import 'package:entert_projet_01/viewModel/theme_provider.dart';
import 'package:entert_projet_01/viewModel/user_provider.dart';
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
  late List<Map<String, dynamic>> buildInfo;
  @override
  void initState() {
    super.initState();
    buildInfo = [
      {
        'icon': FontAwesomeIcons.userPen,
        'buildName': 'Edit Profile',
        'action': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return UpdateUserInfosScreens();
              },
            ),
          );
        },
      },
      {
        'icon': Icons.notifications,
        'buildName': 'Notifications',
        'action': () {},
      },
      {'icon': Icons.settings, 'buildName': 'Settings', 'action': () {}},
      {'icon': Icons.lock, 'buildName': 'Change PassWord', 'action': () {}},
    ];
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.read<UserProvider>();
    final changeColor = Provider.of<ChangeColor>(context);
    final textColor = changeColor.textColor;
    final backgroundColor = changeColor.background;

    final user = userProvider.user;
    if (user == null) {
      return Scaffold(body: Center(child: Text('Aucun utilisateur connecté')));
    }
    return Scaffold(
      backgroundColor: backgroundColor,

      appBar: AppBar(
    
        backgroundColor: backgroundColor,
        title: Text('Profile', style: style(24, 3, textColor)),
        centerTitle: true,
        actionsPadding: EdgeInsets.only(right: 20),
        actions: [
          Consumer<ChangeColor>(
            builder: (context, theme, child) {
              return IconButton(
              
                icon: Icon(
                  theme.isDark ? Icons.dark_mode : Icons.light_mode,
                  color: theme.textColor,
                  size: 28,
                ),
                onPressed: () {
                  theme.toggleTheme();
                },
              );
            },
          ),
        ],
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
                        width: 6,
                        style: BorderStyle.solid,
                        color: changeColor.cardColor,
                        strokeAlign: BorderSide.strokeAlignInside,
                      ),
                      shape: BoxShape.circle,
                      color: changeColor.cardColor,

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
                  Consumer<UserProvider>(
                    builder: (context, user, child) {
                      return Text(
                        user.user!.displayName,
                        style: style(20, 3, textColor),
                      );
                    },
                  ),
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
                      buildInfo[indice]['action'] as VoidCallback,
                    );
                  },
                ),
              ),
            ),

            GestureDetector(
              onTap: () async {
                await userProvider.signOut();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
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
                    backgroundColor: changeColor.cardColor,
                    child: Icon(Icons.logout, size: 24, color: Colors.red),
                  ),
                  title: Text(
                    'Log Out',
                    style: TextStyle(
                      color: changeColor.textColor,
                      fontSize: 16,
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
}

Widget buildProfileWidget(
  IconData icon,
  String buildName,

  VoidCallback? action,
) => ChangeNotifierProvider(
  create: (_) => ChangeColor(),
  child: Consumer<ChangeColor>(
    builder: (context, color, _) {
      return GestureDetector(
        onTap: () {
          action!.call();
        },
        child: Container(
          padding: EdgeInsets.all(7),
          margin: EdgeInsets.only(left: 16, right: 16, top: 10),
          decoration: BoxDecoration(
            color: color.cardColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: color.textColor,
              child: Icon(icon, size: 24, color: color.cardColor),
            ),
            title: Text(buildName, style: style(16, 2, color.textColor)),
            trailing: CircleAvatar(
              backgroundColor: color.background,
              child: Icon(Icons.arrow_right, size: 24, color: color.textColor),
            ),
          ),
        ),
      );
    },
  ),
);
