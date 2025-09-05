// view/screens/inventory.dart
import 'package:entert_projet_01/view/screens/transfer_inventory.dart';
import 'package:entert_projet_01/utils/colors.dart';
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
        actionsPadding: EdgeInsets.all(20),
        title: Text('Inventory', style: style(18, 2)),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return TransferInventory(index: widget.index);
                  },
                ),
              );
            },
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(FontAwesomeIcons.upRightFromSquare, size: 22),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            banchInventory(widget.index),
            SizedBox(height: 10),
            SizedBox(
              height: 80,
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
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(left: 16, bottom: 16),
                      child: Text(
                        categoryList[index],
                        style: TextStyle(
                          color: textColor,
                          fontSize: index == _selectedCategory ? 20 : 16,
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
                    return Padding(
                      padding: EdgeInsets.only(left: 24, right: 24),
                      child: Container(
                        padding: EdgeInsets.only(
                          left: 24,
                          right: 24,
                          top: 20,
                          bottom: 20,
                        ),
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              child: Row(
                                children: [
                                  CircleAvatar(
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
                                  SizedBox(width: 12),
                                  Text('Market Louis', style: style(16, 2)),
                                ],
                              ),
                            ),
                            SizedBox(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: const <Widget>[
                                  Text(
                                    '43',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    '/100',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.blueGrey,
                                    ),
                                  ),
                                ],
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
  height: 120,
  padding: EdgeInsets.only(left: 20, right: 20),
  margin: EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 20),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16),
  ),
  child: Align(
    alignment: Alignment.center,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: [
        SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Wall Wolf St', style: style(12, 1)),
              SizedBox(height: 8),
              Text('Branch ($index)', style: style(20, 3)),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.all(24),
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
  ),
);
