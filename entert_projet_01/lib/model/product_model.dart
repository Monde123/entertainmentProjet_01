// model/product_model.dart

class ProductModel {
  String name;
  String? produitUrl;
  double price;
  String quality;
  String? description;
  ProductModel({
    required this.name,
    required this.price,
    required this.quality,
    this.description,
    this.produitUrl,
  });
  factory ProductModel.fromMap(Map<String, dynamic> v) {
    return ProductModel(
      name: (v['name'] ?? 'produit inconnu'),
      price: (v['price'] ?? 0.0),
      quality: (v['quality'] ?? 'indisponible'),
      description: (v['description']),
      produitUrl: v['produitUrl'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'quality': quality,
      'description': description,
      'produitUrl': produitUrl,
    };
  }
}
