// viewModel/product_provider.dart
import 'dart:async';

import 'package:entert_projet_01/model/product_model.dart';
import 'package:entert_projet_01/repository/product_repository.dart';
import 'package:flutter/material.dart';

class ProductProvider with ChangeNotifier {
   ProductProvider() {
    _listenProducts();
  }
    final ProductRepository _productRepository =ProductRepository();
  List<ProductModel> _listProduits = [];
  bool _loading = false;
  String? _error;
  List<ProductModel> get listProduits => _listProduits;
  String? get error => _error;
  bool get loading => _loading;

 

  void _listenProducts() {
    _loading = true;
    notifyListeners();
    _productRepository.allProducts().listen(
      (data) {
        _listProduits = data;
        _loading = false;
        _error = null;
        notifyListeners(); 
      },
      onError: (err) {
        _loading = false;
        _error = err.toString();
      },
    );
  }
 
   
}
