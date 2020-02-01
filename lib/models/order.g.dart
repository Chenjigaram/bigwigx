// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) {
  return Order(
    orderId: json['orderId'] as String,
    username: json['username'] as String,
    address: json['address'] == null
        ? null
        : Address.fromJson(json['address'] as Map<String, dynamic>),
    isFulfilled: json['isFulfilled'] as bool,
    status: (json['status'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$OrderToJson(Order instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('orderId', instance.orderId);
  writeNotNull('username', instance.username);
  writeNotNull('address', instance.address);
  writeNotNull('isFulfilled', instance.isFulfilled);
  writeNotNull('status', instance.status);
  return val;
}
