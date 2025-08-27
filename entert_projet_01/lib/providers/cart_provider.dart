// providers/cart_provider.dart
import 'dart:convert';

import 'package:entert_projet_01/model/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider extends ChangeNotifier {
  List<ProductModel> cartItems = [];
  CartProvider() {
    loadData();
  }

  int get cartLenght => cartItems.length;

  void loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList('produits');

    if (list == null) {
      cartItems = [];
    } else {
      cartItems =
          list
              .map((product) => ProductModel.fromMap(jsonDecode(product)))
              .toList();
    }
  }

  Future<void> _saveDataInShared() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      'produits',
      cartItems.map((product) => jsonEncode(product.toMap())).toList(),
    );
  }

  //add products to cart
  void addInCart( ProductModel prod) async {
    List<Map<String, dynamic>> cartMap =
        cartItems.map((product) => product.toMap()).toList();
    if (cartMap.contains(prod.toMap()) == false) {
      cartItems.add(prod);
    }
    await _saveDataInShared();
    notifyListeners();
  }

  // calcul price Total
  double priceTotal() {
    double s = 0.0;
    for (ProductModel prod in cartItems) {
      s = s + prod.price;
    }
    return s;
  }

  //remove products to cart
  void removeInCart(ProductModel prod) async {
    cartItems.remove(prod);
    await _saveDataInShared();
    notifyListeners();
  }

  bool get isCart {
    if (cartItems.isEmpty) {
      return false;
    } else {
      return true;
    }
  }
  //remove all products

  void clear() async {
    cartItems.clear();
    await _saveDataInShared();
    notifyListeners();
  }
}
