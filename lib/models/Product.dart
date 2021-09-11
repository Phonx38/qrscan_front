class Product {
  String id;
  String name;
  int price;
  String qrImage;

  Product({this.id, this.name, this.price, this.qrImage});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["id"],
      name: json['product_name'],
      price: json["price"],
      qrImage: json["qr_code"],
    );
  }
}
