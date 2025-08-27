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
    cartItems =
        list!
            .map((product) => ProductModel.fromMap(jsonDecode(product)))
            .toList();
  }

  Future<void> _saveDataInShared() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      'produits',
      cartItems.map((product) => jsonEncode(product.toMap())).toList(),
    );
  }

  //add products to cart
  void addInCart(String produitId, ProductModel prod) async {
    if (cartItems.contains(prod) == false) {
      cartItems.add(prod);
    }
    await _saveDataInShared();
    notifyListeners();
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
