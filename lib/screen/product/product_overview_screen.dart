// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_app/ApiClient/api_client.dart';
import 'package:ecommerce_app/provider/cart.dart';
import 'package:ecommerce_app/provider/products.dart';
import 'package:ecommerce_app/screen/cart.dart';
import 'package:ecommerce_app/widget/app_drawer.dart';
import 'package:ecommerce_app/widget/badge.dart';
import 'package:ecommerce_app/widget/product/product_grid.dart';

enum FilterOptions {
  // ignore: constant_identifier_names
  Favorites,
  // ignore: constant_identifier_names
  All,
}

class ProductOverviewScreen extends StatefulWidget {
  const ProductOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showOnlyFavorites = false;
  var _isInit = true;
  var _isLoading = false;
  final apiClient = ApiClient();

  @override
  void initState() {
    super.initState();
  }

// Загрузка товаров

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context).reloadProduct().then(
        (_) {
          setState(() {
            _isLoading = false;
          });
        },
      );
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final productsContainer = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Магазин'),
        actions: [
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorites) {
                  _showOnlyFavorites = true;
                } else {
                  _showOnlyFavorites = false;
                }
              });
            },

// Фильтр между избранным товаром и смотреть всё

            itemBuilder: (_) => [
              const PopupMenuItem(
                child: Text('Избранное'),
                value: FilterOptions.Favorites,
              ),
              const PopupMenuItem(
                child: Text('Смотреть всё'),
                value: FilterOptions.All,
              ),
            ],
            icon: const Icon(Icons.more_vert),
          ),

// Навигация на страницу корзины

          Consumer<Cart>(
            builder: (_, cart, child) => Badge(
                child: IconButton(
                  icon: const Icon(
                    Icons.shopping_cart,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(CartScreen.routeName);
                  },
                ),
                value: cart.itemCount.toString(),
                color: Theme.of(context).focusColor),
            // child:
          ),
        ],
      ),

// Выдвижное меню

      drawer: const AppDraweWidget(),

// Продукты

      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ProductsGrid(
              showFavs: _showOnlyFavorites,
            ),
    );
  }
}
