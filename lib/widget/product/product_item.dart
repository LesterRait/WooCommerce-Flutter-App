import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_app/provider/cart.dart';
import 'package:ecommerce_app/model/product.dart';
import 'package:ecommerce_app/screen/product/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
                  arguments: product.id);
            },
            child: Column(
              children: [
                Image(height: 100, image: NetworkImage(product.images[0].src)),
                const SizedBox(height: 8),
                Text(product.name,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2),
                const SizedBox(height: 8),
                Text('${product.price} ₸', textAlign: TextAlign.center),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Consumer<Product>(
                builder: (context, product, _) => IconButton(
                  icon: Icon(product.isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border),
                  color: Theme.of(context).colorScheme.secondary,
                  onPressed: () {
                    product.toggleFavoriteStatus();
                  },
                ),
              ),
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined),
                color: Theme.of(context).colorScheme.secondary,
                onPressed: () {
                  cart.addItem(
                    product.id.toString(),
                    double.parse(product.price),
                    product.name,
                    product.id,
                  );
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text(
                        'Добавлено в корзину',
                        textAlign: TextAlign.center,
                      ),
                      duration: const Duration(seconds: 2),
                      action: SnackBarAction(
                        label: 'Отменить',
                        onPressed: () {
                          cart.removeItem(product.id.toString());
                        },
                      ),
                    ),
                  );
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
