import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ecommerce_app/config/config.dart';
import 'package:ecommerce_app/model/order.dart';
import 'package:ecommerce_app/model/product.dart';

class ApiClient with ChangeNotifier {
  final client = HttpClient();
  final key = Config().key;
  final secret = Config().secret;
  final urlBase = Config().url;

// Product - Get

  Future<List<Product>> getProduct() async {
    final json = await get(
            '$urlBase/wp-json/wc/v3/products?consumer_key=$key&consumer_secret=$secret')
        as List<dynamic>;

    final products = json
        .map((dynamic e) => Product.fromJson(e as Map<String, dynamic>))
        .toList();
    return products;
  }

// Order - Get

  Future<List<Order>> getOrder() async {
    final json = await get(
            '$urlBase/wp-json/wc/v3/orders?consumer_key=$key&consumer_secret=$secret')
        as List<dynamic>;

    final orders = json
        .map((dynamic e) => Order.fromJson(e as Map<String, dynamic>))
        .toList();
    return orders;
  }

// Create Order - POST

  Future<Order> createOrder({
    required String payment_method,
    required String payment_method_title,
    required String firstName,
    required String lastName,
    required String addressOne,
    required String addressTwo,
    required String city,
    required String country,
    required String state,
    required String postcode,
    required String email,
    required String phone,
    required String total,
    required int product_id,
    required int quantity,
  }) async {
    final url = Uri.parse(
      '$urlBase/wp-json/wc/v3/orders?consumer_key=$key&consumer_secret=$secret',
    );
    final parameters = <String, dynamic>{
      'payment_method_title': 'Банковская карта Visa/Mastercard',
      'payment_method': 'cp',
      'billing': {
        'first_name': firstName,
        'last_name': lastName,
        'address_1': addressOne,
        'address_2': addressTwo,
        'city': city,
        'country': country,
        'state': state,
        'postcode': postcode,
        'email': email,
        'phone': phone,
      },
      'shipping': {
        'first_name': firstName,
        'last_name': lastName,
        'address_1': addressOne,
        'address_2': addressTwo,
        'city': city,
        'country': country,
        'state': state,
        'postcode': postcode,
        'email': email,
        'phone': phone,
      },
      'line_items': [
        {
          'product_id': product_id,
          "quantity": quantity,
        },
      ],
    };
    final request = await client.postUrl(url);
    request.headers.set("Content-Type", "application/json; charset=utf-8");
    request.write(jsonEncode(parameters));
    final response = await request.close();
    final jsonStrings = await response.transform(utf8.decoder).toList();
    final jsonString = jsonStrings.join();
    final json = jsonDecode(jsonString) as Map<String, dynamic>;
    final order = Order.fromJson(json);
    return order;
  }

  Future<dynamic> get(String ulr) async {
    final url = Uri.parse(ulr);
    final request = await client.getUrl(url);
    final response = await request.close();
    final jsonStrings = await response.transform(utf8.decoder).toList();
    final jsonString = jsonStrings.join();
    final dynamic json = jsonDecode(jsonString);
    return json;
  }
}
