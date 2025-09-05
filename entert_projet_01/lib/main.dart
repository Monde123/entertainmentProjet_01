// main.dart
import 'package:entert_projet_01/view/authScreens/login_screen.dart';
import 'package:entert_projet_01/view/screens/cart_screens.dart';
import 'package:entert_projet_01/view/screens/home_page.dart';
import 'package:entert_projet_01/view/screens/other_cart_screens.dart';
import 'package:entert_projet_01/view/screens/other_products_screen.dart';
import 'package:entert_projet_01/view/screens/products_screen.dart';
import 'package:entert_projet_01/view/screens/profile_page.dart';
import 'package:entert_projet_01/viewModel/cart_provider.dart';
import 'package:entert_projet_01/viewModel/other_cart_provider.dart';
import 'package:provider/provider.dart';
import 'viewModel/user_provider.dart';
import 'package:entert_projet_01/utils/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (m) => CartProvider()),
        ChangeNotifierProvider(create: (m) => OtherCartProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'first enttertainment',

      home:
          userProvider.isConnected
              ? const NavigationPage()
              : const LoginScreen(),
    );
  }
}

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    HomePage(),
    ProductsPage(),
    CartScreens(),

    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: _pages[_selectedIndex],

      bottomNavigationBar: Container(
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1)),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 4,
              activeColor: textColor,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              color: secondaryColor,
              tabs: [
                GButton(icon: FontAwesomeIcons.house, text: 'Home'),
                GButton(icon: FontAwesomeIcons.productHunt, text: 'Produits'),

                GButton(
                  icon: FontAwesomeIcons.cartShopping,
                  text: 'Panier',
                ),
                GButton(icon: FontAwesomeIcons.solidUser, text: 'Profi.'),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
