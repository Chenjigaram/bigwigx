// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookCart _$BookCartFromJson(Map<String, dynamic> json) {
  return BookCart(
    username: json['username'] as String,
    items: (json['items'] as List)
        ?.map((e) =>
            e == null ? null : BookCartItem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$BookCartToJson(BookCart instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('username', instance.username);
  writeNotNull('items', instance.items);
  return val;
}
