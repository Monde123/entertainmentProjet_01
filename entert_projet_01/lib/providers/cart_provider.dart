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
  bool isInCart(ProductModel p) => _cartProduitList(
    cartItems,
  ).contains(p.name + p.price.toString() + p.description.toString());

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
    notifyListeners();
  }

  Future<void> _saveDataInShared() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      'produits',
      cartItems.map((product) => jsonEncode(product.toMap())).toList(),
    );
  }

  //add products to cart
  void addInCart(ProductModel prod) async {
    List<String> products = _cartProduitList(cartItems);
    final p = prod.name + prod.price.toString() + prod.description.toString();
    if (products.contains(p) == false) {
      cartItems.add(prod);
    }
    await _saveDataInShared();
    notifyListeners();
  }

  //fonction de hashage pensé pour la vérification de l'unicité d'un produit
  List<String> _cartProduitList(List<ProductModel> cart) {
    List<String> listProduit = [];
    for (ProductModel product in cart) {
      String p =
          product.name +
          product.price.toString() +
          product.description.toString();
      listProduit.add(p);
    }
    return listProduit;
  }
  // fin de la fonction de clé unique

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
