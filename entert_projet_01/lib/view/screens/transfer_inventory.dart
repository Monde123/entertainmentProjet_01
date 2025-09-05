// view/screens/transfer_inventory.dart
import 'package:entert_projet_01/view/screens/staff_overview.dart';
import 'package:entert_projet_01/viewModel/theme_provider.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class TransferInventory extends StatefulWidget {
  const TransferInventory({super.key, required this.index});
  final int index;

  @override
  State<TransferInventory> createState() => _TransferInventoryState();
}

class _TransferInventoryState extends State<TransferInventory> {
  @override
  Widget build(BuildContext context) {
    double largeur = MediaQuery.of(context).size.width;
    double hauteur = MediaQuery.of(context).size.height;
    final changeColor = Provider.of<ChangeColor>(context);

    return Scaffold(
      backgroundColor:changeColor.background,
      appBar: AppBar(
        centerTitle: true,
        actionsPadding: EdgeInsets.all(20),
        title: Text('Transfert Inventory', style: style(16, 2, changeColor.textColor)),
        actions: [Icon(FontAwesomeIcons.circleH, color: changeColor.textColor)],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
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
                      height: hauteur * 0.55,
                      width: largeur,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/image.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: ListTile(
                        title: Text(
                          'Branch(${widget.index})',
                          style: style(20, 3, changeColor.textColor),
                        ),
                        subtitle: Text(
                          faker.address.city(),
                          style: style(12, 1, changeColor.textColor),
                        ),
                        trailing: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: changeColor.primaryColor,
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
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 60,
                      width: largeur,
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      decoration: BoxDecoration(
                        color: changeColor.background,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(20),
                            height: 60,
                            width: largeur * 0.58,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                bottomLeft: Radius.circular(12),
                              ),
                              color: changeColor.secodaryColor,
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.white,
                                child: Icon(
                                  FontAwesomeIcons.heart,
                                  //color: primaryColor,
                                  size: 24,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Text('125%', style: style(12, 2, changeColor.textColor)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return StaffOverview(index: widget.index);
                      },
                    ),
                  );
                },
                title: Text(
                  'Staff Inventory',
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
