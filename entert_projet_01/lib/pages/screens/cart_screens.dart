// pages/screens/cart_screens.dart
import 'package:entert_projet_01/model/product_model.dart';
import 'package:entert_projet_01/providers/cart_provider.dart';
import 'package:entert_projet_01/utils/colors.dart';
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
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text('Mon panier', style: style(20, 3)),
        centerTitle: true,
        actionsPadding: EdgeInsets.all(20),
        actions: [
          cartItems.isCart
              ? ElevatedButton(
                onPressed: cartItems.clear,

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: CircleBorder(),
                ),
                child: Icon(Icons.delete, color: Colors.red),
              )
              : SizedBox(),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: SizedBox(
                child: GridView.builder(
                  itemCount: cartItems.cartLenght,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                  ),
                  itemBuilder: (context, index) {
                    final ProductModel prod = cartItems.cartItems[index];
                    return cartProductsWidget(
                      onPressed: () => cartItems.removeInCart(prod),
                      height: 100,
                      produc: prod,
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

//widget for cart product

Widget cartProductsWidget({
  Function? onPressed,
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
              child: ElevatedButton(
                onPressed: () {
                  onPressed!();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: backgroundColor,
                  shape: OvalBorder(),
                ),
                child: Icon(Icons.delete, color: Colors.red),
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
