// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Book _$BookFromJson(Map<String, dynamic> json) {
  return Book(
    id: json['id'] as String,
    bookName: json['bookName'] as String,
    category: json['category'] as String,
    subCategory: json['subCategory'] as String,
    language: json['language'] as String,
    author: json['author'] as String,
    publisher: json['publisher'] as String,
    isbn: json['isbn'] as String,
    rating: json['rating'] as int,
    numberOfRatings: (json['numberOfRatings'] as num)?.toDouble(),
    reviews: (json['reviews'] as List)
        ?.map((e) =>
            e == null ? null : Comment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    bookImages: (json['bookImages'] as List)?.map((e) => e as String)?.toList(),
    availability: json['availability'] as int,
    description: json['description'] as String,
    averageReadingTime: (json['averageReadingTime'] as num)?.toDouble(),
    aboutAuthor: json['aboutAuthor'] as String,
    ageGroup: json['ageGroup'] as int,
    noOfTimesRented: (json['noOfTimesRented'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$BookToJson(Book instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('bookName', instance.bookName);
  writeNotNull('category', instance.category);
  writeNotNull('subCategory', instance.subCategory);
  writeNotNull('language', instance.language);
  writeNotNull('author', instance.author);
  writeNotNull('publisher', instance.publisher);
  writeNotNull('isbn', instance.isbn);
  writeNotNull('rating', instance.rating);
  writeNotNull('numberOfRatings', instance.numberOfRatings);
  writeNotNull('reviews', instance.reviews);
  writeNotNull('bookImages', instance.bookImages);
  writeNotNull('availability', instance.availability);
  writeNotNull('description', instance.description);
  writeNotNull('aboutAuthor', instance.aboutAuthor);
  writeNotNull('noOfTimesRented', instance.noOfTimesRented);
  writeNotNull('averageReadingTime', instance.averageReadingTime);
  writeNotNull('ageGroup', instance.ageGroup);
  return val;
}
