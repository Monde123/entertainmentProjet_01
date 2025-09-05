// pages/widgets/cart_products_card.dart
//widget for cart product
import 'package:entert_projet_01/model/product_model.dart';
import 'package:entert_projet_01/utils/colors.dart';
import 'package:flutter/material.dart';

Widget cartProductsWidget({
  Function? onPressed,
  GestureTapCallback? action,

  required ProductModel produc,
}) => GestureDetector(
  onTap: action,
  child: Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      color: Colors.white,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 1.2,
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: NetworkImage(
                  produc.produitUrl != null &&
                          produc.produitUrl!.trim().isNotEmpty
                      ? produc.produitUrl.toString()
                      : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcScUfdvt0l4tq5x51ysl8s0-QWdSzEdrgAxjg&s',
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () {
                  onPressed!();
                },
                child: CircleAvatar(
                  backgroundColor: backgroundColor,
                  child: Icon(Icons.delete, color: Colors.red),
                ),
              ),
            ),
          ),
        ),

        SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.only(left: 8, right: 8, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                produc.name,
                style: style(14, 2),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 8),
              Text('\$ ${produc.price}', style: style(12, 1)),
              Text(produc.quality),
            ],
          ),
        ),
      ],
    ),
  ),
);
