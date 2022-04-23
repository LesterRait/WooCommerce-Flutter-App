import 'package:flutter/material.dart';
import 'package:ecommerce_app/ApiClient/api_client.dart';
import 'package:ecommerce_app/model/order.dart';

class WooOrder with ChangeNotifier {
  final apiClient = ApiClient();
  List<Order> _order = [];

  List<Order> get order {
    return [..._order];
  }

  // Loading Order

  Future<void> reloadOrder() async {
    final orders = await apiClient.getOrder();
    _order += orders;
    notifyListeners();
  }
}
