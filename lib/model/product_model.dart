
class ProductModel {
  final String title;
  final int price;
  final String brand;
  final String description;
  final int stock;

  ProductModel(
      {required this.title,
      required this.price,
      required this.brand,
      required this.description,
      required this.stock});

      factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      title: json["title"],
      price: json["price"],
      brand: json["brand"],
      description: json["description"],
      stock: json["stock"],
    );
  }
}
