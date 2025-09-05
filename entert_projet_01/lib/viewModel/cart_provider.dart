// providers/cart_provider.dart
import 'dart:convert';

import 'package:entert_projet_01/model/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider extends ChangeNotifier {
  List<ProductModel> _cartItems = [];
  List<ProductModel> get cartItems => List.unmodifiable(_cartItems);

  CartProvider() {
    loadData();
  }

  bool isInCart(ProductModel p) {
    return _cartItems.any((prod) => prod.id == p.id);
  }

  int get cartLenght => _cartItems.length;

  void toggleProduct(ProductModel prod) {
    if (isInCart(prod)) {
      removeInCart(prod);
    } else {
      addInCart(prod);
    }
  }

  void loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList('produits');

    if (list == null) {
      _cartItems = [];
    } else {
      _cartItems =
          list
              .map((product) => ProductModel.fromMap(jsonDecode(product)))
              .toList();
    }
    notifyListeners();
  }

  Future<void> _saveDataInShared() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      'produits',
      _cartItems.map((product) => jsonEncode(product.toMap())).toList(),
    );
  }

  //add products to cart
  void addInCart(ProductModel prod) async {
    if (isInCart(prod) == false) {
       _cartItems.add(prod);
    }
    await _saveDataInShared();
    notifyListeners();
  }



  // calcul price Total
  double priceTotal() {
    double s = 0.0;
    for (ProductModel prod in _cartItems) {
      s = s + prod.price;
    }
    return s;
  }

  //remove products to cart
  void removeInCart(ProductModel prod) async {
    _cartItems.removeWhere((pro)=>pro.id==prod.id);
    await _saveDataInShared();
    notifyListeners();
  }

  bool get isCart {
    if (_cartItems.isEmpty) {
      return false;
    } else {
      return true;
    }
  }
  //remove all products

  void clear() async {
    _cartItems.clear();
    await _saveDataInShared();
    notifyListeners();
  }
}
