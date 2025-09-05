// view/screens/products_screen.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:entert_projet_01/model/product_model.dart';
import 'package:entert_projet_01/repository/product_repository.dart';
import 'package:entert_projet_01/view/screens/add_products.dart';
import 'package:entert_projet_01/view/widgets/products_card.dart';
import 'package:entert_projet_01/viewModel/cart_provider.dart';
import 'package:entert_projet_01/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  Widget build(BuildContext context) {
    final cartItems = Provider.of<CartProvider>(context, listen: true);
     ProductRepository ? prod;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text('Products', style: style(20, 3)),
        centerTitle: true,
        actions: [
          CircleAvatar(
            backgroundColor: Colors.white,
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
              child: StreamBuilder<QuerySnapshot>(
                stream: prod!.allProducts(),
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
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: produits.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.72,
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 16,
                    ),
                    itemBuilder: (context, index) {
                      return productsWidget(
                        //add function to add card widget
                        onPressed: () {
                          cartItems.toggleProduct(produits[index]);
                        },

                        produc: produits[index],
                        isInCart: cartItems.isInCart(produits[index]),
                      );
                    },
                  );
                },
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
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
