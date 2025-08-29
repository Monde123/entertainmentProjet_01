// pages/screens/other_cart_screens.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:entert_projet_01/model/product_model.dart';
import 'package:entert_projet_01/pages/screens/cart_screens.dart';
import 'package:entert_projet_01/providers/other_cart_provider.dart';
import 'package:entert_projet_01/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OtherCartScreens extends StatefulWidget {
  const OtherCartScreens({super.key});

  @override
  createState() => _OtherCartScreensState();
}

class _OtherCartScreensState extends State<OtherCartScreens> {


  @override
  Widget build(BuildContext context) {
    final otherCartItems = Provider.of<OtherCartProvider>(
      context,
      listen: true,
    );
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text('Mon panier', style: style(20, 3)),
        centerTitle: true,
        actionsPadding: EdgeInsets.all(20),
        actions: [
          !otherCartItems.isCart()
              ? GestureDetector(
                onTap: otherCartItems.clear,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.delete, color: Colors.red),
                ),
              )
              : SizedBox(),
        ],
      ),
      body:
          otherCartItems.isCart()
              ? Center(child: Text('Aucun produit dans le pnier'))
              : FutureBuilder(
                future: fetchProducts(otherCartItems),
                builder: (context, snap) {
                  if (snap.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snap.hasError) {
                    return Center(child: Text("Erreur : ${snap.error}"));
                  }

                  if (snap.data!.isEmpty) {
                    return const Center(child: Text("Aucun produit trouvé"));
                  }

                  final produits = snap.data!;
                  return Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Expanded(
                          child: SizedBox(
                            child: GridView.builder(
                              itemCount: produits.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 16,
                                  ),
                              itemBuilder: (context, index) {
                                final ProductModel prod = produits[index];
                                return cartProductsWidget(
                                  onPressed:
                                      () => otherCartItems.removeInCart(
                                        prod.id,
                                      ),
                                  height: 100,
                                  produc: prod,
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
    );
  }
}

Future<List<ProductModel>> fetchProduicts(OtherCartProvider cart) async {
  List<ProductModel> prodModel = [];
  cart.loadData();
  for (String pIds in cart.cartItems) {
    final docProduit =
        await FirebaseFirestore.instance.collection('Products').doc(pIds).get();
    if (docProduit.exists) {
      final produit = ProductModel.fromMap(docProduit.data()!);
      prodModel.add(produit);
    }
  }
  return prodModel;
} // requete non optimisé

//requête optimisée
Future<List<ProductModel>> fetchProducts(OtherCartProvider cart) async {
 
  if (cart.cartItems.isEmpty) return [];

  final querySnapshot =
      await FirebaseFirestore.instance
          .collection('Products')
          .where(
            FieldPath.documentId,
            whereIn: cart.cartItems.take(10).toList(),
          )
          .get();

  return querySnapshot.docs
      .map((doc) => ProductModel.fromMap(doc.data()))
      .toList();
}
