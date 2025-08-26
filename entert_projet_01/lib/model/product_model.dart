// model/product_model.dart

class ProductModel {
  String name;
  String? produitUrl;
  double price;
  String quality;
  String? quantity;
  ProductModel({
    required this.name,
    required this.price,
    required this.quality,
    this.quantity,
    this.produitUrl,
  });
  factory ProductModel.fromMap(Map<String, dynamic> v) {
    return ProductModel(
      name: (v['name'] ?? 'produit inconnu'),
      price: (v['price'] ?? 0.0),
      quality: (v['quality'] ?? 'indisponible'),
      quantity: (v['quantity']),
      produitUrl: v['produitUrl'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'quality': quality,
      'quantity': quantity,
      'produitUrl': produitUrl,
    };
  }
}
