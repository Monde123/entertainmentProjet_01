// view/screens/other_products_screen.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:entert_projet_01/model/product_model.dart';
import 'package:entert_projet_01/view/screens/add_products.dart';
import 'package:entert_projet_01/view/widgets/products_card.dart';

import 'package:entert_projet_01/viewModel/other_cart_provider.dart';
import 'package:entert_projet_01/viewModel/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsPageCopy extends StatefulWidget {
  const ProductsPageCopy({super.key});

  @override
  State<ProductsPageCopy> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPageCopy> {
  final Stream<QuerySnapshot<Map<String, dynamic>>> _firebase =
      FirebaseFirestore.instance.collection('Products').snapshots();

  @override
  Widget build(BuildContext context) {
    final cartItems = Provider.of<OtherCartProvider>(context);
      final changeColor = Provider.of<ChangeColor>(context);
    final primaryColor = changeColor.primaryColor;
    final textColor = changeColor.textColor;
    final backgroundColor = changeColor.background;
   

   
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text('Products', style: style(20, 3, textColor)),
        centerTitle: true,
        actions: [
          CircleAvatar(
            backgroundColor: changeColor.cardColor,
            child: Icon(Icons.search, color: primaryColor, size: 28),
          ),
        ],
        actionsPadding: EdgeInsets.all(20),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(height: 20),
            Expanded(
              child: SizedBox(
                child: StreamBuilder<QuerySnapshot>(
                  stream: _firebase,
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Erreur de chargement');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          backgroundColor: primaryColor,
                          strokeWidth: 2,
                        ),
                      );
                    }
                    if (snapshot.data!.docs.isEmpty) {
                      return Text('Aucune donnée disponible');
                    }
       
                    final produits =
                        snapshot.data!.docs
                            .map(
                              (doc) => ProductModel.fromMap(
                                doc.data() as Map<String, dynamic>,
                              ),
                            )
                            .toList();
                    return GridView.builder(
                      shrinkWrap: true,
                     // physics: const NeverScrollableScrollPhysics(),
                      itemCount: produits.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 16,
                          childAspectRatio: 0.72,
                      ),
                      itemBuilder: (context, index) {
                        return productsWidget(
                          //add function to add card widget
                          onPressed: () {
                            cartItems.toggleInCart(produits[index].id);
                          },
                         
                          produc: produits[index],
                          isInCart: cartItems.isInCart(produits[index].id),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return AddProducts();
              },
            ),
          );
        },
        backgroundColor: primaryColor,
        shape: CircleBorder(eccentricity: 1),
        elevation: 2,
        child: Icon(Icons.add, color: changeColor.cardColor),
      ),
    );
  }
}

