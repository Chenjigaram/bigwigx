import 'package:bigwigx/models/address.dart';

import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@JsonSerializable(nullable: true,includeIfNull: false)
class Order{
  String orderId;
  String username;
  Address address;
  bool isFulfilled;
  List<String> status;

  Order({this.orderId,this.username,this.address,this.isFulfilled,this.status});


  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);


/*
  factory Order.fromJson(Map<String,dynamic> json){
    if(json!=null && json!=""){
      return Order(
        orderId: json['orderId'],
        username:json['username'],
        address:Address.fromJson(json['address']),
        isFulfilled:json['isFulfilled'],
        status:Book.listString(json['status']),
      );
    }
    return null;
  }
*/

}