// view/screens/cart_screens.dart
import 'package:entert_projet_01/model/product_model.dart';
import 'package:entert_projet_01/view/widgets/cart_products_card.dart';
import 'package:entert_projet_01/viewModel/cart_provider.dart';
import 'package:entert_projet_01/viewModel/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreens extends StatefulWidget {
  const CartScreens({super.key});

  @override
  State<CartScreens> createState() => _CartScreensState();
}

class _CartScreensState extends State<CartScreens> {
  @override
  Widget build(BuildContext context) {
    final cartItems = Provider.of<CartProvider>(context, listen: true);
      final changeColor = Provider.of<ChangeColor>(context);
    final primaryColor = changeColor.primaryColor;
    final textColor = changeColor.textColor;
    final backgroundColor = changeColor.background;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text('Mon panier', style: style(20, 3, textColor)),
        centerTitle: true,
        actionsPadding: EdgeInsets.all(20),
        actions: [
          cartItems.isCart
              ? GestureDetector(
                onTap: cartItems.clear,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.delete, color: Colors.red),
                ),
              )
              : SizedBox(),
        ],
      ),
      body:
          !cartItems.isCart
              ? Center(child: Text('Aucun produit dans le panier'))
              : Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Expanded(
                      child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: cartItems.cartLenght,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 0.72,

                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 20,
                        ),
                        itemBuilder: (context, index) {
                          final ProductModel prod = cartItems.cartItems[index];
                          return cartProductsWidget(
                            onPressed: () => cartItems.removeInCart(prod),

                            produc: prod,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
      bottomNavigationBar:
          !cartItems.isCart
              ? null
              : Container(
                height: 70,
                margin: EdgeInsets.symmetric(horizontal: 20),

                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 60),
                    SizedBox(
                      child: Align(
                        child: Text(
                          '${cartItems.priceTotal()}',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      '\$',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    SizedBox(width: 60),
                    Expanded(
                      child: Container(
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.shopping_cart, color: primaryColor),
                            SizedBox(width: 10),
                            Text(
                              'Payer',
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
    );
  }
}
