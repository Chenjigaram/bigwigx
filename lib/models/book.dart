

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import 'comment.dart';

part 'book.g.dart';

@JsonSerializable(nullable: true,includeIfNull: false)
class Book{
  String id;
  String bookName;
  String category;
  String subCategory;
  String language;
  String author;
  String publisher;
  String isbn;
  int rating;
  double numberOfRatings;
  List<Comment> reviews;
  List<String> bookImages;
  int availability;
  String description;
  String aboutAuthor;
  double noOfTimesRented;
  double averageReadingTime;
  int ageGroup;

  Book({this.id,this.bookName,this.category,this.subCategory,this.language,this.author,this.publisher,this.isbn,
    this.rating,this.numberOfRatings,this.reviews,this.bookImages,this.availability,this.description,
    this.averageReadingTime,this.aboutAuthor,this.ageGroup,this.noOfTimesRented});

  factory Book.newBook(Book book){
    if(book!=null){
      book.availability = null;
      book.noOfTimesRented = null;
      book.aboutAuthor =null;
      book.isbn = null;
      book.reviews = null;
      return book;
    }
    return null;

  }

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);

  Map<String, dynamic> toJson() => _$BookToJson(this);

  static List<Book> listBooks(dynamic listBooks){

    return (listBooks as List)
        ?.map((e) =>
    e == null ? null : Book.fromJson(e as Map<String, dynamic>))
        ?.toList();
  }

  /*factory Book.fromJson(Map<String,dynamic> json){
    if(json!=null && json!=""){
      return Book(
          id:json['id'],
          bookName:json['bookName'],
          category:json['category'],
          subCategory:json['subCategory'],
          language:json['language'],
          author:json['author'],
          publisher:json['publisher'],
          isbn:json['isbn'],
          rating:json['rating'],
          numberOfRatings:json['numberOfRatings'],
          reviews:Comment.listComment(json['reviews']),
          bookImages:Book.listString(json['bookImages']),
          availability:json['availability'],
          description:json['description'],
          averageReadingTime:json['averageReadingTime'],
          aboutAuthor:json['aboutAuthor'],
          ageGroup:json['ageGroup'],
          noOfTimesRented:json['noOfTimesRented']
      );
    }
    return null;
  }
  static List<String> listString(dynamic listStrings){
    if(listStrings!=null && listStrings!=""){
      var stringList = listStrings as List;
      List<String> strings = stringList.map((text)=>text.toString()).toList();
      return strings;
    }return null;
  }

  Map<String, dynamic> toJson(){

    var jsonValue = {
      'id':this.id,
      'bookName':this.bookName,
      'category':this.category,
      'subCategory':this.subCategory,
      'language':this.language,
      'author':this.author,
      'publisher':this.publisher,
      'isbn': this.isbn,
      'rating':this.rating,
      'numberOfRatings':this.numberOfRatings,
      'reviews':jsonEncode(this.reviews),
      'bookImages':jsonEncode(this.bookImages),
      'availability':this.availability,
      'description':this.description,
      'averageReadingTime':this.averageReadingTime,
      'aboutAuthor': this.aboutAuthor,
      'ageGroup':this.ageGroup,
      'noOfTimesRented': this.noOfTimesRented,
    };
    jsonValue.removeWhere((k,v)=>v==null || v=="null");
    return jsonValue;
  }*/
}