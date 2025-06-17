import 'package:flutter/material.dart';
import 'package:bank_susu_pos/data/product_data.dart';
import 'package:bank_susu_pos/models/product.dart';
import 'package:bank_susu_pos/widgets/product_card.dart';

class POSScreen extends StatefulWidget {
  const POSScreen({super.key});

  @override
  State<POSScreen> createState() => _POSScreenState();
}

class _POSScreenState extends State<POSScreen> {
  final ProductData _productData = ProductData();
  final List<Product> _cartItems = [];
  double _totalPrice = 0.0;

  void _addProductToCart(Product product) {
    setState(() {
      int existingIndex = _cartItems.indexWhere(
        (item) => item.id == product.id,
      );
      if (existingIndex != -1) {
        _cartItems[existingIndex].stock++;
      } else {
        _cartItems.add(
          Product(
            id: product.id,
            name: product.name,
            price: product.price,
            stock: 1,
            imageUrl: product.imageUrl,
          ),
        );
      }
      _calculateTotalPrice();
    });
  }

  void _removeProductFromCart(Product product) {
    setState(() {
      int existingIndex = _cartItems.indexWhere(
        (item) => item.id == product.id,
      );
      if (existingIndex != -1) {
        if (_cartItems[existingIndex].stock > 1) {
          _cartItems[existingIndex].stock--;
        } else {
          _cartItems.removeAt(existingIndex);
        }
      }
      _calculateTotalPrice();
    });
  }

  void _calculateTotalPrice() {
    _totalPrice = 0.0;
    for (var item in _cartItems) {
      _totalPrice += item.price * item.stock;
    }
  }

  void _clearCart() {
    setState(() {
      _cartItems.clear();
      _totalPrice = 0.0;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Keranjang dikosongkan!'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('List Barang'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: colorScheme.onSurface),
            onPressed: () {
              setState(() {
                // Trigger rebuild of product list
              });
            },
            tooltip: 'Refresh Produk',
          ),
        ],
      ),
      body: Row(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              color: colorScheme.background, // Latar belakang abu-abu muda
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 0.8,
                ),
                itemCount: _productData.getProducts().length,
                itemBuilder: (context, index) {
                  final product = _productData.getProducts()[index];
                  return ProductCard(
                    product: product,
                    onAddToCart: () => _addProductToCart(product),
                  );
                },
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              color: colorScheme.surface, // Latar belakang putih
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text('Keranjang Belanja', style: textTheme.headlineMedium),
                  const Divider(height: 30, thickness: 1.5),
                  Expanded(
                    child:
                        _cartItems.isEmpty
                            ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.shopping_cart_outlined,
                                    size: 70,
                                    color: Colors.blueGrey[200],
                                  ),
                                  const SizedBox(height: 15),
                                  Text(
                                    'Keranjang kosong',
                                    style: textTheme.bodyMedium?.copyWith(
                                      color: Colors.blueGrey[400],
                                    ),
                                  ),
                                ],
                              ),
                            )
                            : ListView.builder(
                              itemCount: _cartItems.length,
                              itemBuilder: (context, index) {
                                final item = _cartItems[index];
                                return Card(
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 8.0,
                                  ),
                                  elevation: 1, // Card keranjang lebih halus
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0,
                                      vertical: 8.0,
                                    ),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 22,
                                          backgroundImage: NetworkImage(
                                            item.imageUrl,
                                          ),
                                          backgroundColor:
                                              colorScheme
                                                  .primaryColorLight, // Border halus
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                item.name,
                                                style: textTheme.titleLarge
                                                    ?.copyWith(fontSize: 16),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                'Rp${item.price.toStringAsFixed(0)}',
                                                style: textTheme.bodyMedium
                                                    ?.copyWith(
                                                      color: Colors.green[600],
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                              icon: Icon(
                                                Icons.remove_circle,
                                                color: Colors.red[400],
                                                size: 26,
                                              ),
                                              onPressed:
                                                  () => _removeProductFromCart(
                                                    item,
                                                  ),
                                              splashRadius:
                                                  20, // Efek sentuhan lebih kecil
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 6.0,
                                                  ),
                                              child: Text(
                                                item.stock.toString(),
                                                style: textTheme.headlineMedium
                                                    ?.copyWith(fontSize: 20),
                                              ),
                                            ),
                                            IconButton(
                                              icon: Icon(
                                                Icons.add_circle,
                                                color: Colors.green[400],
                                                size: 26,
                                              ),
                                              onPressed:
                                                  () => _addProductToCart(item),
                                              splashRadius: 20,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                  ),
                  const Divider(height: 30, thickness: 1.5),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Total Belanja:',
                          style: textTheme.bodyLarge?.copyWith(
                            color: Colors.blueGrey[700],
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Rp${_totalPrice.toStringAsFixed(0)}',
                          style: textTheme.displayMedium?.copyWith(
                            color: colorScheme.primary, // Warna total dari tema
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed:
                          _cartItems.isEmpty
                              ? null
                              : () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Pembayaran berhasil untuk Rp${_totalPrice.toStringAsFixed(0)}!',
                                    ),
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
                                _clearCart();
                              },
                      icon: const Icon(Icons.payment),
                      label: Text(
                        'Proses Pembayaran',
                        style: textTheme.labelLarge,
                      ), // Gunakan textTheme.labelLarge
                      style: Theme.of(
                        context,
                      ).elevatedButtonTheme.style?.copyWith(
                        padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(vertical: 18.0),
                        ), // Padding lebih besar
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: _clearCart,
                      icon: const Icon(Icons.clear_all),
                      label: Text(
                        'Kosongkan Keranjang',
                        style: textTheme.bodyLarge?.copyWith(
                          color: Colors.red[700],
                        ),
                      ),
                      style: Theme.of(
                        context,
                      ).outlinedButtonTheme.style?.copyWith(
                        side: MaterialStateProperty.all(
                          BorderSide(color: Colors.red[300]!, width: 1.5),
                        ), // Border merah
                        foregroundColor: MaterialStateProperty.all(
                          Colors.red[700],
                        ),
                        padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(vertical: 18.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

extension on ColorScheme {
  get primaryColorLight => null;
}
