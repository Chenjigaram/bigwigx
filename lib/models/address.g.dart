// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) {
  return Address(
    addressId: json['addressId'] as String,
    username: json['username'] as String,
    line1: json['line1'] as String,
    line2: json['line2'] as String,
    city: json['city'] as String,
    state: json['state'] as String,
    pinCode: json['pinCode'] as String,
    landmark: json['landmark'] as String,
  );
}

Map<String, dynamic> _$AddressToJson(Address instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('addressId', instance.addressId);
  writeNotNull('username', instance.username);
  writeNotNull('line1', instance.line1);
  writeNotNull('line2', instance.line2);
  writeNotNull('city', instance.city);
  writeNotNull('state', instance.state);
  writeNotNull('pinCode', instance.pinCode);
  writeNotNull('landmark', instance.landmark);
  return val;
}
