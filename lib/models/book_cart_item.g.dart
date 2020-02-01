// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_cart_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookCartItem _$BookCartItemFromJson(Map<String, dynamic> json) {
  return BookCartItem(
    id: json['id'] as String,
    book: json['book'] == null
        ? null
        : Book.fromJson(json['book'] as Map<String, dynamic>),
    toReturn: json['toReturn'] as bool,
    isCompleted: json['isCompleted'] as bool,
    itemStatus: (json['itemStatus'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$BookCartItemToJson(BookCartItem instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('book', instance.book);
  writeNotNull('toReturn', instance.toReturn);
  writeNotNull('isCompleted', instance.isCompleted);
  writeNotNull('itemStatus', instance.itemStatus);
  return val;
}
