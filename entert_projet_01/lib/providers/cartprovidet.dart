// providers/cartprovidet.dart
import 'package:entert_projet_01/model/product_model.dart';
import 'package:flutter/cupertino.dart';

class CartProvider with ChangeNotifier {
  List cartItems = [];
  bool _isCart = false;

  int get cartLenght => cartItems.length;
  bool get isCart => _isCart;

  //add products to cart
  void addInCart(ProductModel prod) async {
    cartItems.add(prod.toMap());
    _isCart = true;
    notifyListeners();
  }
 //remove products to cart
  void removeInCart(ProductModel prod) {
    cartItems.remove(prod.toMap());
    _isCart = false;
    notifyListeners();
  }
  
}
