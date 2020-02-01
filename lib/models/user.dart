




import 'address.dart';
import 'subscription.dart';


import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(nullable: true,includeIfNull: false)
class User{
  String username;
  String email;
  String password;
  String firstName;
  String lastName;
  String mobile;
  List<Address> addresses;
  Subscription subscription;
  bool isSubscriptionActive;
  String role;
  User({this.username,this.email,this.password,this.firstName,this.lastName,this.mobile,this.addresses,this.subscription,this.isSubscriptionActive,this.role});


  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);




/*factory User.fromJson(Map<String,dynamic> json){
    if(json!=null && json!="") {
      return User(
        username: json['username'],
        email: json['email'],
        password: json['password'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        mobile: json['mobile'],
        addresses: Address.listAddresses(json['addresses']),
        subscription: Subscription.fromJson(json['subscription']),
        isSubscriptionActive: json['isSubscriptionActive'],
        role: json['role'],
      );
    }return null;
  }*/
}