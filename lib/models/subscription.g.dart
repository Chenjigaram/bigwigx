// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Subscription _$SubscriptionFromJson(Map<String, dynamic> json) {
  return Subscription(
    subscriptionId: json['subscriptionId'] as String,
    username: json['username'] as String,
    subscriptionType: json['subscriptionType'] as String,
    noOfBooks: json['noOfBooks'] as int,
    startDate: json['startDate'] == null
        ? null
        : DateTime.parse(json['startDate'] as String),
    endDate: json['endDate'] == null
        ? null
        : DateTime.parse(json['endDate'] as String),
  );
}

Map<String, dynamic> _$SubscriptionToJson(Subscription instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('subscriptionId', instance.subscriptionId);
  writeNotNull('username', instance.username);
  writeNotNull('subscriptionType', instance.subscriptionType);
  writeNotNull('noOfBooks', instance.noOfBooks);
  writeNotNull('startDate', instance.startDate?.toIso8601String());
  writeNotNull('endDate', instance.endDate?.toIso8601String());
  return val;
}
