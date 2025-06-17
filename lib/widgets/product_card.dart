import 'package:flutter/material.dart';
import 'package:bank_susu_pos/models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onAddToCart;

  const ProductCard({
    super.key,
    required this.product,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      child: InkWell(
        onTap: onAddToCart,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 3,
                child: Hero(
                  tag: 'product-${product.id}',
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      product.imageUrl,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.broken_image,
                          size: 80,
                          color: Colors.grey[400],
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                product.name,
                style: textTheme.titleLarge?.copyWith(
                  fontSize: 16,
                  color: colorScheme.onSurface,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 6),
              Text(
                'Rp${product.price.toStringAsFixed(0)}',
                style: textTheme.bodyLarge?.copyWith(
                  color: Colors.green[700],
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                'Stok: ${product.stock}',
                style: textTheme.bodyMedium?.copyWith(
                  color:
                      product.stock > 0
                          ? Colors.blueGrey[600]
                          : Colors.red[600],
                  fontWeight:
                      product.stock > 0 ? FontWeight.normal : FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton.icon(
                  onPressed: product.stock > 0 ? onAddToCart : null,
                  icon: const Icon(Icons.add_shopping_cart, size: 20),
                  label: Text(
                    product.stock > 0 ? 'Tambah Keranjang' : 'Stok Habis',
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        product.stock > 0
                            ? colorScheme.primary
                            : Colors.blueGrey[200],
                    foregroundColor:
                        product.stock > 0
                            ? colorScheme.onPrimary
                            : Colors.blueGrey[500],
                    elevation: product.stock > 0 ? 4.0 : 0.0,
                    minimumSize: const Size(double.infinity, 45),
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
