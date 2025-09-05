// view/widgets/products_card.dart
import 'package:entert_projet_01/model/product_model.dart';
import 'package:entert_projet_01/viewModel/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget productsWidget({
  GestureTapCallback? onPressed,
  GestureTapCallback? action,

  required ProductModel produc,
  required bool isInCart,
}) => ChangeNotifierProvider(
  create: (_) => ChangeColor(),
  child: Consumer<ChangeColor>(
    builder: (context, color, _) {
      return GestureDetector(
        onTap: action,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color:color.cardColor,
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
                      onTap: onPressed ?? () {},
                      child: CircleAvatar(
                        backgroundColor: color.background,
                        child:
                            isInCart
                                ? Icon(Icons.shopping_cart, color: color.primaryColor)
                                : Icon(
                                  Icons.shopping_cart_outlined,
                                  color: color.primaryColor,
                                ),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.only(left: 8, right: 8, bottom: 10),

                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      //softWrap: true,
                      produc.name,
                      style: style(14, 2, color.textColor),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 5),
                    Text('\$ ${produc.price}', style: style(12, 1, color.textColor)),
                    SizedBox(height: 5),

                    Text(produc.quality),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  ),
);
