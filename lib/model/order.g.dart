// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      id: json['id'] as int,
      productId: json['product_id'] as int,
      number: json['number'] as String,
      orderKey: json['order_key'] as String,
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'id': instance.id,
      'product_id': instance.productId,
      'number': instance.number,
      'order_key': instance.orderKey,
    };
