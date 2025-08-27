// pages/screens/products_screen.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:entert_projet_01/model/product_model.dart';
import 'package:entert_projet_01/pages/screens/add_products.dart';
import 'package:entert_projet_01/providers/cart_provider.dart';
import 'package:entert_projet_01/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final Stream<QuerySnapshot<Map<String, dynamic>>> _firebase =
      FirebaseFirestore.instance.collection('Products').snapshots();

  @override
  Widget build(BuildContext context) {
    final cartItems = Provider.of<CartProvider>(context, listen: false);
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
                          strokeWidth: 20,
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
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                      ),
                      itemBuilder: (context, index) {
                        return productsWidget(
                          //add function to add card widget
                          onPressed: () {
                            cartItems.addInCart(produits[index]);
                          },
                          height: 80,
                          produc: produits[index],
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
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

Widget productsWidget({
  GestureTapCallback? onPressed,
  GestureTapCallback? action,
  required double height,
  required ProductModel produc,
}) => GestureDetector(
  onTap: action,
  child: Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      color: Colors.white,
    ),
    child: Column(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(10),
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: NetworkImage(
                  produc.produitUrl!.isEmpty
                      ? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcScUfdvt0l4tq5x51ysl8s0-QWdSzEdrgAxjg&s'
                      : produc.produitUrl.toString(),
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: onPressed ?? () {},
                child: CircleAvatar(
                  backgroundColor: backgroundColor,
                  child: Icon(Icons.shopping_cart, color: primaryColor),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
        SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      produc.name,
                      style: style(14, 2),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8),
                    Text('\$ ${produc.price}', style: style(12, 1)),
                  ],
                ),
              ),
              Text(produc.quality),
            ],
          ),
        ),
      ],
    ),
  ),
);
