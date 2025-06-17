import 'package:flutter/material.dart';
import 'package:bank_susu_pos/models/product.dart';
import 'package:bank_susu_pos/data/product_data.dart';
import 'package:uuid/uuid.dart';

class AddEditProductScreen extends StatefulWidget {
  final Product? product;

  const AddEditProductScreen({super.key, this.product});

  @override
  State<AddEditProductScreen> createState() => _AddEditProductScreenState();
}

class _AddEditProductScreenState extends State<AddEditProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();

  final ProductData _productData = ProductData();
  bool _isEditing = false;
  String _productId = const Uuid().v4();

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      _isEditing = true;
      _productId = widget.product!.id;
      _nameController.text = widget.product!.name;
      _priceController.text = widget.product!.price.toString();
      _stockController.text = widget.product!.stock.toString();
      _imageUrlController.text = widget.product!.imageUrl;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _stockController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  void _saveProduct() {
    if (_formKey.currentState!.validate()) {
      final newProduct = Product(
        id: _productId,
        name: _nameController.text,
        price: double.parse(_priceController.text),
        stock: int.parse(_stockController.text),
        imageUrl:
            _imageUrlController.text.isNotEmpty
                ? _imageUrlController.text
                : 'https://via.placeholder.com/150',
      );

      if (_isEditing) {
        _productData.updateProduct(newProduct);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${newProduct.name} berhasil diperbarui!'),
            duration: const Duration(seconds: 1),
          ),
        );
      } else {
        _productData.addProduct(newProduct);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${newProduct.name} berhasil ditambahkan!'),
            duration: const Duration(seconds: 1),
          ),
        );
      }
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isEditing ? 'Edit Produk Susu' : 'Tambah Produk Susu Baru',
        ),
      ),
      body: Container(
        color: colorScheme.background, // Latar belakang
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                _isEditing
                    ? 'Perbarui detail produk ini:'
                    : 'Isi detail produk susu baru:',
                style: textTheme.bodyLarge?.copyWith(
                  color: Colors.blueGrey[700],
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nama Produk',
                  prefixIcon: Icon(Icons.shopping_bag_outlined),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama produk tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(
                  labelText: 'Harga (Rp)',
                  prefixIcon: Icon(Icons.payments_outlined),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Harga tidak boleh kosong';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Masukkan angka yang valid';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _stockController,
                decoration: const InputDecoration(
                  labelText: 'Stok',
                  prefixIcon: Icon(Icons.production_quantity_limits_outlined),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Stok tidak boleh kosong';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Masukkan angka yang valid';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _imageUrlController,
                decoration: const InputDecoration(
                  labelText: 'URL Gambar (opsional)',
                  prefixIcon: Icon(Icons.image_outlined),
                ),
                keyboardType: TextInputType.url,
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: _saveProduct,
                icon: Icon(_isEditing ? Icons.save : Icons.add_circle_outline),
                label: Text(
                  _isEditing ? 'Simpan Perubahan' : 'Tambah Produk',
                  style: textTheme.labelLarge,
                ),
                style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(vertical: 18.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
