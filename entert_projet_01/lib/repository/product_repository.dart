// repository/product_repository.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:entert_projet_01/model/product_model.dart';

class ProductRepository {
  ProductModel? _productModel;
  ProductModel? get productModel => _productModel;
  final _db = FirebaseFirestore.instance.collection('Products');

  Future<void> addProduit(
    String name,
    String? produitUrl,
    double price,
    String? description,
    String quality,
  ) async {
    try {
      final docs = _db.doc();
      final id = docs.id;
      _productModel = ProductModel(
        id: id,
        name: name,
        price: price,
        quality: quality,
        description: description,
      );
      await docs.set(_productModel!.toMap());
    } on FirebaseException {
      throw Exception('Firestore error');
    } catch (e) {
      throw Exception('Erreur inattendue');
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> allProducts() {
     Stream<QuerySnapshot<Map<String, dynamic>>> firebase =
        FirebaseFirestore.instance.collection('Products').snapshots();
    return firebase;
  }
}
