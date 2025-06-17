import 'package:flutter/material.dart';
import 'package:bank_susu_pos/data/product_data.dart';
import 'package:bank_susu_pos/models/product.dart';
import 'package:bank_susu_pos/screens/add_edit_product_screen.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final ProductData _productData = ProductData();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Manajemen Produk Susu')),
      body:
          _productData.getProducts().isEmpty
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.inventory_2_outlined,
                      size: 90,
                      color: Colors.blueGrey[200],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Belum ada produk.\nSilakan tambahkan produk baru!',
                      textAlign: TextAlign.center,
                      style: textTheme.headlineMedium?.copyWith(
                        color: Colors.blueGrey[400],
                      ),
                    ),
                  ],
                ),
              )
              : ListView.builder(
                padding: const EdgeInsets.all(10.0), // Padding di luar list
                itemCount: _productData.getProducts().length,
                itemBuilder: (context, index) {
                  final product = _productData.getProducts()[index];
                  Color stockColor;
                  String stockStatus;
                  if (product.stock > 20) {
                    stockColor = Colors.green[700]!;
                    stockStatus = 'Stok Banyak';
                  } else if (product.stock > 0) {
                    stockColor = Colors.orange[700]!;
                    stockStatus = 'Stok Terbatas';
                  } else {
                    stockColor = Colors.red[700]!;
                    stockStatus = 'Stok Habis';
                  }

                  return Card(
                    // Card theme dari main.dart akan diterapkan
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30, // Ukuran avatar lebih besar
                        backgroundImage: NetworkImage(product.imageUrl),
                        backgroundColor:
                            colorScheme.primaryColorLight, // Border halus
                      ),
                      title: Text(
                        product.name,
                        style: textTheme.titleLarge?.copyWith(
                          color: colorScheme.onSurface,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Harga: Rp${product.price.toStringAsFixed(0)}',
                            style: textTheme.bodyMedium?.copyWith(
                              color: Colors.blueGrey[600],
                            ),
                          ),
                          Text(
                            'Stok: ${product.stock} ($stockStatus)',
                            style: textTheme.bodyMedium?.copyWith(
                              color: stockColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: colorScheme.primary,
                              size: 26,
                            ),
                            onPressed: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => AddEditProductScreen(
                                        product: product,
                                      ),
                                ),
                              );
                              setState(() {});
                            },
                            tooltip: 'Edit Produk',
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: colorScheme.error,
                              size: 26,
                            ),
                            onPressed: () {
                              _showDeleteConfirmationDialog(product);
                            },
                            tooltip: 'Hapus Produk',
                          ),
                        ],
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 10.0,
                      ), // Padding konten
                    ),
                  );
                },
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddEditProductScreen(),
            ),
          );
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showDeleteConfirmationDialog(Product product) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Hapus Produk', style: textTheme.titleLarge),
          content: Text(
            'Apakah Anda yakin ingin menghapus "${product.name}"?',
            style: textTheme.bodyMedium,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.blueGrey[700],
              ), // Warna teks
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                _productData.deleteProduct(product.id);
                Navigator.of(context).pop();
                setState(() {});
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${product.name} berhasil dihapus!'),
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.error,
              ), // Warna merah
              child: Text('Hapus', style: textTheme.labelLarge),
            ),
          ],
        );
      },
    );
  }
}

extension on ColorScheme {
  get primaryColorLight => null;
}
