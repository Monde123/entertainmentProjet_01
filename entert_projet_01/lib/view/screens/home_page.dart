// view/screens/home_page.dart
import 'package:entert_projet_01/view/screens/details_analytics.dart';
import 'package:entert_projet_01/view/screens/inventory.dart';
import 'package:entert_projet_01/viewModel/user_provider.dart';
import 'package:entert_projet_01/utils/colors.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    final user = userProvider.user;

    String userName= user ==null ? 'John Doe': user.displayName;

    List<Icon> iconData = [
      Icon(FontAwesomeIcons.shirt, color: primaryColor, size: 28),
      Icon(FontAwesomeIcons.shoePrints, color: Colors.amber, size: 28),
      Icon(Icons.favorite_rounded, color: Colors.amber, size: 28),
      Icon(FontAwesomeIcons.gem, color: primaryColor, size: 28),
    ];
    double largeurEcran = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        actionsPadding: EdgeInsets.only(right: 20),
        title: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Morning',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: textColor,
                ),
              ),
              SizedBox(height: 5),
              Text(
               userName,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
        actions: [
          CircleAvatar(
            radius: 24,
            backgroundColor: backgroundColor,
            foregroundImage: NetworkImage(faker.image.loremPicsum()),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: largeurEcran - 40,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    width: largeurEcran - 40,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.change_circle_rounded, color: textColor),
                            Icon(Icons.more_horiz_sharp, color: textColor),
                          ],
                        ),

                        const SizedBox(height: 10),
                        //widget de la carte analytics
                        Container(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Net Income',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: textColor,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    '\$74000',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: textColor,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    '+25.22% (\$5.00)',
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),

                              CircularPercentIndicator(
                                radius: 40.0,
                                lineWidth: 12.0,
                                percent: 0.78,
                                center: Text(
                                  "78%",
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                progressColor: Colors.blue,
                                backgroundColor: Colors.grey[200]!,
                                circularStrokeCap: CircularStrokeCap.round,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return DetailsAnalytics();
                          },
                        ),
                      );
                    },
                    title: const Text(
                      'View more information',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    trailing: const Icon(Icons.add_circle, color: Colors.white),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),
            ListTile(
              title: Text('Branch', style: TextStyle(color: textColor)),
              trailing: Text(
                'Add new +',
                style: TextStyle(decoration: TextDecoration.underline),
              ),
            ),
            Expanded(
              child: SizedBox(
                width: largeurEcran,

                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: 4,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return InventoryScreen(index: index + 1);
                            },
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.only(top: 25, bottom: 25),
                        width: largeurEcran / 2 - 22,
                        // height: ,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            CircleAvatar(
                              backgroundColor: backgroundColor,
                              child: iconData[index],
                            ),
                            SizedBox(height: 12),
                            Text(
                              'Branch(${index + 1})',
                              style: TextStyle(color: textColor, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
