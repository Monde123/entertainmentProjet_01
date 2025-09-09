// view/screens/produits_details.dart
import 'package:entert_projet_01/model/product_model.dart';
import 'package:entert_projet_01/view/widgets/commits_widget.dart';
import 'package:entert_projet_01/viewModel/cart_provider.dart';
import 'package:entert_projet_01/viewModel/test_api_provider.dart';
import 'package:entert_projet_01/viewModel/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsDetails extends StatefulWidget {
  final ProductModel product;
  const ProductsDetails({super.key, required this.product});

  @override
  State<ProductsDetails> createState() => _ProductsDetailsState();
}

class _ProductsDetailsState extends State<ProductsDetails> {
  @override
  Widget build(BuildContext context) {
    final changeColor = Provider.of<ChangeColor>(context);
    final cart = Provider.of<CartProvider>(context);
    final commits = Provider.of<TestApiProvider>(context);

    final primaryColor = changeColor.primaryColor;
    final textColor = changeColor.textColor;
    final backgroundColor = changeColor.background;
    double ratioEcran = MediaQuery.of(context).size.aspectRatio;
    final cardColor = changeColor.cardColor;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: changeColor.iconColor),
        ),
        title: Text('Détails Produit', style: style(20, 3, textColor)),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: ratioEcran * 2.7,
              child: Container(
                margin: EdgeInsets.only(bottom: 20),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: NetworkImage(
                      widget.product.produitUrl != null &&
                              widget.product.produitUrl!.trim().isNotEmpty
                          ? widget.product.produitUrl.toString()
                          : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcScUfdvt0l4tq5x51ysl8s0-QWdSzEdrgAxjg&s',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () => cart.toggleProduct(widget.product),
                    child: CircleAvatar(
                      backgroundColor: backgroundColor,
                      child:
                          cart.isInCart(widget.product)
                              ? Icon(Icons.shopping_cart, color: primaryColor)
                              : Icon(
                                Icons.shopping_cart_outlined,
                                color: primaryColor,
                              ),
                    ),
                  ),
                ),
              ),
            ),
            Divider(color: cardColor, height: 5),
            Padding(
              padding: EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.product.name,
                          style: style(20, 3, textColor),
                        ),
                        SizedBox(height: 12),
                        Text(
                          "${widget.product.price}",
                          style: style(14, 1, textColor),
                        ),
                      ],
                    ),
                  ),
                  Text(widget.product.quality, style: style(14, 2, textColor)),
                ],
              ),
            ),
            Divider(color: cardColor, height: 5),

            ListTile(
              isThreeLine: true,
              title: Text('Description', style: style(20, 3, textColor)),
              subtitle:
                  widget.product.description!.isEmpty
                      ? Text(
                        'Aucune description disponibe pour ce produit',
                        style: style(14, 2, textColor),
                      )
                      : Text(
                        widget.product.description.toString(),
                        style: style(14, 2, textColor),
                      ),
            ),
            SizedBox(height: 10),
            Text('Commentaires', style: style(16, 3, textColor)),
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: ListView.builder(
                  itemCount: commits.commitsList.length,
                  itemBuilder: (context, index) {
                    if (commits.isLoading) {
                      return CircularProgressIndicator();
                    }
                    if (commits.errorMessage != null) {
                      return Text(
                        '${commits.errorMessage}',
                        style: style(14, 2, textColor),
                      );
                    }
                    final user = commits.commitsList[index];
                    return CommitsWidgets(user: user);
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
