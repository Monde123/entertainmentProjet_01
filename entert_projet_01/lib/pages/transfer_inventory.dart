// pages/transfer_inventory.dart
import 'package:entert_projet_01/theme/colors.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TransferInventory extends StatefulWidget {
  const TransferInventory({super.key, required this.index});
  final int index;

  @override
  State<TransferInventory> createState() => _TransferInventoryState();
}

class _TransferInventoryState extends State<TransferInventory> {
  @override
  Widget build(BuildContext context) {
    double hauteur = MediaQuery.of(context).size.height;
    double largeur = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Transfert Inventory', style: style(16, 2)),
        actions: [Icon(Icons.circle, fill: 0.5, color: textColor)],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: hauteur * 0.8,
              width: largeur,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    height: largeur * 0.45,
                    width: largeur,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/image.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  ListTile(
                   
                    title: Text('Branch(${widget.index})', style: style(20, 3)),
                    subtitle: Text(faker.address.city(), style: style(12, 1)),
                    trailing: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Icon(Icons.check, color: Colors.white, size: 24),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: largeur,
                    padding: EdgeInsets.only(left: 28, right: 28),
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          
                          height: 40,
                          width: largeur * 0.58,
                          decoration: BoxDecoration(
                            color: secondaryColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              bottomLeft: Radius.circular(12),
                            ),
                          ),
                          child:  CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(FontAwesomeIcons.gem, color:primaryColor),
                          )
                          
                        ),
                        Text('125%', style: style(10, 1)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 10 ),
              child: ListTile(
                title: Text(
                  'Request Inventory',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                trailing: Icon(Icons.arrow_right_alt, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
