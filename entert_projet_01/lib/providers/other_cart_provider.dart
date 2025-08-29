// providers/other_cart_provider.dart
// providers/other_cart_provider.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtherCartProvider extends ChangeNotifier {
  List<String> _cartItems = [];
  List<String> get cartItems => List.unmodifiable(_cartItems);

  OtherCartProvider() {
    loadData();
  }

  bool isInCart(String productId) {
    return _cartItems.contains(productId);
  } //fonction pour la vérification d'un produit dans le panier

 
  bool isCart() {
    return _cartItems.isEmpty;
  }

  void toggleInCart(String p) {
    if (isInCart(p)) {
      removeInCart(p);
    } else {
      addInCart(p);
    }
  }

  void addInCart(String p) async {
    if (!isInCart(p)) {
      _cartItems.add(p);
    }
    await _saveData(_cartItems);
    notifyListeners();
  } // function to add products to cart

  void removeInCart(String p) async {
    _cartItems.remove(p);
    await _saveData(_cartItems);
    notifyListeners();
  } //function to remove out cart

  Future<void> _saveData(List<String> cart) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('productsIds', cart);
  } // function to save data in sharedPreferences

  void loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final cartIds = prefs.getStringList('productsIds');
    if (cartIds == null) {
      _cartItems = [];
    } else {
      _cartItems = cartIds;
    }
    notifyListeners();
  } // function to get data in sharedPreferences

  void clear() async {
    _cartItems.clear();
    await _saveData(_cartItems);
    notifyListeners();
  }
}
