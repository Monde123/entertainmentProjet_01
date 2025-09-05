// view/screens/staff_overview.dart
import 'package:entert_projet_01/viewModel/theme_provider.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class StaffOverview extends StatefulWidget {
  const StaffOverview({super.key, required this.index});
  final int index;

  @override
  State<StaffOverview> createState() => _StaffOverviewState();
}

class _StaffOverviewState extends State<StaffOverview> {
  final List<Map<String, dynamic>> users = [];

  void initUser() {
    for (var i = 0; i < 10; i++) {
      users.add({
        'image': faker.image.loremPicsum(),

        'nom': '${faker.person.lastName()}  ${faker.person.firstName()}',
        'profession': faker.job.title(),
        'etoile': 4.0,
      });
    }
  }

  @override
  void initState() {
    super.initState();

    initUser();
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    final changeColor = Provider.of<ChangeColor>(context);
    final primaryColor = changeColor.primaryColor;
    final textColor = changeColor.textColor;
    final backgroundColor = changeColor.background;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text('Staff Overview', style: style(18, 2, textColor)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(padding: EdgeInsets.all(20), child: branchCard(widget.index)),

          SizedBox(height: 10),
          ListTile(
            title: Text(
              'Employee(${users.length})',
              style: style(18, 2, textColor),
            ),
            trailing: Icon(
              FontAwesomeIcons.ellipsisVertical,
              color: textColor,
              size: 28,
            ),
          ),
          Expanded(
            child: SizedBox(
              width: widthScreen,
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.only(left: 16, right: 16, bottom: 8),
                    margin: EdgeInsets.only(left: 20, right: 20, bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.white,
                        foregroundImage: NetworkImage(users[index]['image']),
                      ),
                      title: Text(
                        '${users[index]['nom']} ',
                        style: style(16, 3, textColor),
                      ),

                      subtitle: Text(
                        users[index]['profession'],
                        style: style(12, 1, textColor),
                      ),
                      trailing: Text(
                        '${users[index]['etoile'] + index / 10} ',
                        style: style(16, 3, textColor),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget branchCard(int index) => ChangeNotifierProvider(
  create: (_) => ChangeColor(),
  child: Consumer<ChangeColor>(
    builder: (context, color, _) {
      return Container(
        padding: EdgeInsets.only(left: 20),
        //  margin: EdgeInsets.only(left: 24),
        height: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  Text('Branch ($index)', style: style(20, 3,color.textColor)),
                  SizedBox(height: 10),
                  SizedBox(
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundImage: NetworkImage(
                            faker.image.loremPicsum(),
                          ),
                        ),
                        SizedBox(width: 4),
                        SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Brandon Agoua', style: style(16, 3, color.textColor)),
                              SizedBox(height: 4),
                              Text('Head Office', style: style(12, 1, color.textColor)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(width: 20),
            Expanded(
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),

                  image: DecorationImage(
                    image: NetworkImage(faker.image.loremPicsum()),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  ),
);
