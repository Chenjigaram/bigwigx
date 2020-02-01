
import 'package:json_annotation/json_annotation.dart';

part 'comment.g.dart';

@JsonSerializable(nullable: true,includeIfNull: false)
class Comment{
  String id;
  String username;
  String line1;
  String line2;

  Comment({this.id,this.username,this.line1,this.line2});


  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);

/*  factory Comment.fromJson(Map<String,dynamic> json){
    if(json!=null && json!=""){
      return Comment(
        id:json['id'],
        username:json['username'],
        line1:json['line1'],
        line2:json['line2'],
      );
    }return null;

  }
  static List<Comment> listComment(dynamic listCommentsString){
    if(listCommentsString!=null && listCommentsString!=""){
      var listComments = listCommentsString as List;
      List<Comment> comments = listComments.map((comment)=>Comment.fromJson(comment)).toList();
      return comments;
    }return null;
  }*/
}