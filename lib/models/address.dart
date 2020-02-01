
import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

@JsonSerializable(nullable: true,includeIfNull: false)
class Address{
  String addressId;
  String username;
  String line1;
  String line2;
  String city;
  String state;
  String pinCode;
  String landmark;
  Address({this.addressId,this.username,this.line1,this.line2,this.city,this.state,this.pinCode,this.landmark});
  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);
  /*factory Address.fromJson(Map<String,dynamic> json){
    if(json!=null && json!=""){
      return Address(
        addressId:json['id'],
        username:json['username'],
        line1:json['line1'],
        line2:json['line2'],
        city:json['city'],
        state:json['state'],
        pinCode:json['pinCode'],
        landmark:json['landmark'],
      );
    }
    return null;

  }
  static List<Address> listAddresses(dynamic listAddressString){
    if(listAddressString!=null && listAddressString!=""){
      var listAddress = listAddressString as List;
      List<Address> addresses = listAddress.map((address)=>Address.fromJson(address)).toList();
      return addresses;
    }return null;
;
  }*/
}