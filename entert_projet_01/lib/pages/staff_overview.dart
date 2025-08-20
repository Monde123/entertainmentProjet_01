// pages/staff_overview.dart
import 'package:entert_projet_01/theme/colors.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
        'profession': faker.job,
        'etoile': random.decimal(min: 3, scale: 5),
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

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text('Staff Overview', style: style(18, 2)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          branchCard(widget.index, widthScreen*0.33),
          SizedBox(height: 10,),
          ListTile(
            title: Text('Employee', style: style(18, 2)),
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
                    padding: EdgeInsets.only(left: 24, right: 24, bottom: 8),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.white,
                        foregroundImage: NetworkImage(
                          users[index]['image'],
                        ),
                      ),
                      title: Text(
                        '${users[index]['nom']} ',
                        style: style(16, 3),
                      ),

                      subtitle: Text(
                        users[index]['profession'],
                        style: style(12, 1),
                      ),
                      trailing: Text(
                        '${users[index]['etoile']}',
                        style: style(16, 3),
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

Widget branchCard(int index, double height) => Container(
  padding: EdgeInsets.all(20),
  margin: EdgeInsets.only(left: 24),
  height: height,
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
  ),
  child: Row(
    //mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Column(
          children: [
            Text('Branch ($index)', style: style(20, 3)),
            SizedBox(height: 10),
            SizedBox(
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundImage: NetworkImage(faker.image.loremPicsum()),
                  ),
                  SizedBox(width: 4),
                  SizedBox(
                    child: Column(
                      children: [
                        Text('Brandon Agoua', style: style(16, 3)),
                        SizedBox(height: 4),
                        Text('Head Office', style: style(12, 1)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      
      SizedBox(width: 20),
      Expanded(
        child: Container(
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
