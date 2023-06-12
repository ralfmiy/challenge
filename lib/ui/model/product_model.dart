class ProductModel {
  final int id;
  final String? title;
  final int? price;
  final String? brand;
  final String? description;
  final int? stock;
  List<String>? images = [];

  ProductModel(
      {required this.id,
      this.title,
      this.price,
      this.brand,
      this.description,
      this.stock,
      this.images});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json["id"],
      title: json["title"],
      price: json["price"],
      brand: json["brand"],
      description: json["description"],
      stock: json["stock"],
      images: json["images"]!=null?List<String>.from(json["images"]):null,
    );
  }
}