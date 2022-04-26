import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ecommerce_app/model/wooimage.dart';

part 'product.g.dart';

@JsonSerializable()
class Product with ChangeNotifier {
  final int id;
  final String name;
  final String description;
  final String price;
  final List<ProductImage> images;
  bool isFavorite;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.images,
    this.isFavorite = false,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);

  void toggleFavoriteStatus() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
