class Product {
  String id;
  String name;
  double price;
  int stock;
  String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.stock,
    this.imageUrl = '',
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      price: map['price'],
      stock: map['stock'],
      imageUrl: map['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'stock': stock,
      'imageUrl': imageUrl,
    };
  }
}
