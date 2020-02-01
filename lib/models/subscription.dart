


import 'package:json_annotation/json_annotation.dart';

part 'subscription.g.dart';

@JsonSerializable(nullable: true,includeIfNull: false)
class Subscription{
   String subscriptionId;
   String username;
   String subscriptionType;
   int noOfBooks;
   DateTime startDate;
   DateTime endDate;

   Subscription({this.subscriptionId,this.username,this.subscriptionType,this.noOfBooks,this.startDate,this.endDate});


   factory Subscription.fromJson(Map<String, dynamic> json) => _$SubscriptionFromJson(json);

   Map<String, dynamic> toJson() => _$SubscriptionToJson(this);




/*   factory Subscription.fromJson(Map<String,dynamic> json){
      if(json!=null && json!=""){
         final DateFormat dateFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
         return Subscription(
            subscriptionId:json['subscriptionId'],
            username:json['username'],
            subscriptionType:json['subscriptionType'],
            noOfBooks:json['noOfBooks'],
            startDate: json['startDate']!="" && json['startDate']!=null ?dateFormat.parse(json['startDate']):null,
            endDate:json['endDate']!="" && json['endDate']!=null?dateFormat.parse(json['endDate']):null,
         );
      }
      return null;
   }*/

}