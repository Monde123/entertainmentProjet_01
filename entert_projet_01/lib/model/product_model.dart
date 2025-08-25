// model/product_model.dart


class ProductModel {
  String name;
  String price;
  String quality;
  String quantity;
  ProductModel({
    required this.name,
    required this.price,
    required this.quality,
    required this.quantity,
  });
  factory ProductModel.fromMap(Map<String, dynamic> v) {
    return ProductModel(
      name: 'name',
      price: 'price',
      quality: 'quality',
      quantity: 'quantity',
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'quality': quality,
      'quantity': quantity,
    };
  }
}
