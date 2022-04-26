import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@JsonSerializable()
class Order extends ChangeNotifier {
  // final List<Billing> billing;
  final int id;
  final String number;
  @JsonKey(name: 'order_key')
  final String orderKey;

  Order({
    // required this.billing,
    required this.id,
    required this.number,
    required this.orderKey,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
