import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'OrderBilling.g.dart';

@JsonSerializable()
class Billing extends ChangeNotifier {
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String lastName;
  final String address_1;
  final String address_2;
  final String city;
  final String country;
  final String state;
  final String postcode;
  final String email;
  final String phone;

  Billing({
    required this.firstName,
    required this.lastName,
    required this.address_1,
    required this.address_2,
    required this.city,
    required this.country,
    required this.state,
    required this.postcode,
    required this.email,
    required this.phone,
  });

  factory Billing.fromJson(Map<String, dynamic> json) =>
      _$BillingFromJson(json);
  Map<String, dynamic> toJson() => _$BillingToJson(this);
}
