import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ecommerce_app/ApiClient/api_client.dart';
import 'package:ecommerce_app/model/product.dart';

class Products with ChangeNotifier {
  final client = HttpClient();
  List<Product> _items = [];
  final apiClient = ApiClient();

  var _showFavoritesOnly = false;

  List<Product> get items {
    return [..._items];
  }

// Loading product

  Future<void> reloadProduct() async {
    final items = await apiClient.getProduct();
    _items += items;
    notifyListeners();
  }

// Filter: favorite items

  List<Product> get favoriteItem {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

// id

  Product findById(int id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  void showFavoritesOnly() {
    _showFavoritesOnly = false;
    notifyListeners();
  }

  void showAll() {
    _showFavoritesOnly = false;
    notifyListeners();
  }
}
