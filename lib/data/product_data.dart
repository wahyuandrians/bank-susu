import 'package:bank_susu_pos/models/product.dart';

class ProductData {
  static List<Product> products = [
    Product(
      id: '1',
      name: 'Susu Murni Segar',
      price: 15000,
      stock: 50,
      imageUrl: '',
    ),
    Product(
      id: '2',
      name: 'Yogurt Plain',
      price: 20000,
      stock: 30,
      imageUrl: '',
    ),
    Product(
      id: '3',
      name: 'Keju Cheddar',
      price: 35000,
      stock: 20,
      imageUrl: '',
    ),
    Product(
      id: '4',
      name: 'Butter Kemasan',
      price: 25000,
      stock: 15,
      imageUrl: '',
    ),
  ];

  void addProduct(Product product) {
    products.add(product);
  }

  void updateProduct(Product updatedProduct) {
    int index = products.indexWhere((p) => p.id == updatedProduct.id);
    if (index != -1) {
      products[index] = updatedProduct;
    }
  }

  void deleteProduct(String id) {
    products.removeWhere((p) => p.id == id);
  }

  List<Product> getProducts() {
    return products;
  }
}
