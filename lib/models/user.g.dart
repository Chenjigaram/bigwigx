// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    username: json['username'] as String,
    email: json['email'] as String,
    password: json['password'] as String,
    firstName: json['firstName'] as String,
    lastName: json['lastName'] as String,
    mobile: json['mobile'] as String,
    addresses: (json['addresses'] as List)
        ?.map((e) =>
            e == null ? null : Address.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    subscription: json['subscription'] == null
        ? null
        : Subscription.fromJson(json['subscription'] as Map<String, dynamic>),
    isSubscriptionActive: json['isSubscriptionActive'] as bool,
    role: json['role'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('username', instance.username);
  writeNotNull('email', instance.email);
  writeNotNull('password', instance.password);
  writeNotNull('firstName', instance.firstName);
  writeNotNull('lastName', instance.lastName);
  writeNotNull('mobile', instance.mobile);
  writeNotNull('addresses', instance.addresses);
  writeNotNull('subscription', instance.subscription);
  writeNotNull('isSubscriptionActive', instance.isSubscriptionActive);
  writeNotNull('role', instance.role);
  return val;
}
