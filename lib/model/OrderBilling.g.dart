// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OrderBilling.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Billing _$BillingFromJson(Map<String, dynamic> json) => Billing(
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      address_1: json['address_1'] as String,
      address_2: json['address_2'] as String,
      city: json['city'] as String,
      country: json['country'] as String,
      state: json['state'] as String,
      postcode: json['postcode'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
    );

Map<String, dynamic> _$BillingToJson(Billing instance) => <String, dynamic>{
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'address_1': instance.address_1,
      'address_2': instance.address_2,
      'city': instance.city,
      'country': instance.country,
      'state': instance.state,
      'postcode': instance.postcode,
      'email': instance.email,
      'phone': instance.phone,
    };
