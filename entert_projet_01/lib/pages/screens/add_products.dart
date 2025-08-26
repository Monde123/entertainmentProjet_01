// pages/screens/add_products.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:entert_projet_01/model/product_model.dart';
import 'package:entert_projet_01/utils/colors.dart';
import 'package:flutter/material.dart';

class AddProducts extends StatefulWidget {
  const AddProducts({super.key});

  @override
  State<AddProducts> createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  final _db = FirebaseFirestore.instance;
  final _form = GlobalKey<FormState>();
  final _productsNameCtrl = TextEditingController();
  final _productsPriceCtrl = TextEditingController();
//  final _productsQualityCtrl;
  final _productsQuantityCtrl = TextEditingController();
  final _productsUrlCtrl = TextEditingController();
  void addProducts(
    String name,
    double price,
    String quality,
    String? quantity,
    String ? url,
  ) async {
    final product = ProductModel(
      name: name,
      price: price,
      quality: quality,
      quantity: quantity,
      produitUrl: url,
    );
    await _db.collection('Products').add(product.toMap());
    print('nouveau document créee');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text('Add products', style: style(20, 4)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _form,
            child: Column(
              children: [
                Center(
                  child: IconButton(
                    onPressed: () {
                      addProducts('Tomato', 1000, 'high', '','');
                    },
                    icon: Icon(Icons.add),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
