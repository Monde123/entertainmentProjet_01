// pages/inventory.dart
import 'package:entert_projet_01/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key, required this.index});
  final int index;

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  int _selectedCategory = 0;
  List<String> categoryList = [
    'All Product',
    'Shoes',
    'Shocks',
    'Hat',
    'Diamond',
    'Golden',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text('Inventory', style: style(18, 2)),
        centerTitle: true,
        actions: [
          CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(FontAwesomeIcons.upRightFromSquare, size: 28),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            banchInventory(widget.index),
            Container(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: ListView.builder(
                itemCount: categoryList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCategory = index;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                      child: Text(
                        categoryList[index],
                        style: TextStyle(
                          color: textColor,
                          fontSize: index == _selectedCategory ? 22 : 20,
                          fontWeight:
                              index == _selectedCategory
                                  ? FontWeight.bold
                                  : FontWeight.w400,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: SizedBox(
                child: ListView.builder(
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.all(20),
                      //   margin: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.black,
                          child: Text(
                            'ML',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        title: Text('Market Louis', style: style(16, 2)),
                        trailing: Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: const <Widget>[
                            Text(
                              '43',
                              style: TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey,
                              ),
                            ),
                            Text(
                              '/100',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.normal,
                                color: Colors.blueGrey,
                              ),
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

Widget banchInventory(int index) => Container(
  padding: EdgeInsets.only(left: 20, right: 20),
  margin: EdgeInsets.all(20),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16),
  ),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      SizedBox(
        child: Column(
          children: [
            Text('Wall Wolf St', style: style(12, 1)),
            SizedBox(height: 8),
            Text('Branch ($index)', style: style(20, 3)),
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.all(6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: backgroundColor,
        ),
        child: Row(
          children: [
            Icon(Icons.arrow_drop_down, color: Colors.red),
            SizedBox(width: 3),
            Text('Low stock', style: TextStyle(color: Colors.red)),
          ],
        ),
      ),
    ],
  ),
);
