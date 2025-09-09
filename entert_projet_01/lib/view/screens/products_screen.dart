// view/screens/products_screen.dart

import 'package:entert_projet_01/view/screens/add_products.dart';
import 'package:entert_projet_01/view/screens/produits_details.dart';
import 'package:entert_projet_01/view/widgets/products_card.dart';
import 'package:entert_projet_01/viewModel/cart_provider.dart';
import 'package:entert_projet_01/viewModel/product_provider.dart';
import 'package:entert_projet_01/viewModel/theme_provider.dart';
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
    final produits = Provider.of<ProductProvider>(context, listen: true);
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
              child: Builder(
                builder: (_) {
                  if (produits.loading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (produits.error != null) {
                    return Center(child: Text(produits.error.toString()));
                  }
                  if (produits.listProduits.isEmpty) {
                    return Center(child: Text('Aucune données disponibles', style:style(16, 2, textColor),));
                  }
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: produits.listProduits.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.72,
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 16,
                    ),
                    itemBuilder: (context, index) {
                      return productsWidget(
                        action: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return ProductsDetails(
                                  product: produits.listProduits[index],
                                );
                              },
                            ),
                          );
                        },
                        //add function to add card widget
                        onPressed: () {
                          cartItems.toggleProduct(produits.listProduits[index]);
                        },

                        produc: produits.listProduits[index],
                        isInCart: cartItems.isInCart(
                          produits.listProduits[index],
                        ),
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
        child: Icon(Icons.add, color: changeColor.cardColor),
      ),
    );
  }
}
