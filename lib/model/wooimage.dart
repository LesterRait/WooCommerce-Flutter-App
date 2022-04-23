import 'package:json_annotation/json_annotation.dart';

part 'wooimage.g.dart';

@JsonSerializable()
class ProductImage {
  final String src;

  ProductImage({required this.src});

  factory ProductImage.fromJson(Map<String, dynamic> json) =>
      _$ProductImageFromJson(json);
  Map<String, dynamic> toJson() => _$ProductImageToJson((this));
}
