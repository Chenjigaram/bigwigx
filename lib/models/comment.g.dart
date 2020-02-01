// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) {
  return Comment(
    id: json['id'] as String,
    username: json['username'] as String,
    line1: json['line1'] as String,
    line2: json['line2'] as String,
  );
}

Map<String, dynamic> _$CommentToJson(Comment instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('username', instance.username);
  writeNotNull('line1', instance.line1);
  writeNotNull('line2', instance.line2);
  return val;
}
