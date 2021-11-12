class AddressModel
{
bool status;
String message;
AddressData data;

AddressModel.fromJson(Map<String, dynamic> json) {
  status = json['status'];
  message = json['message'];
  data =AddressData.fromJson(json['data']);
}
}

class AddressData {
   int id;
   String name;
   String city;
   String region;
   String details;
  AddressData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    city = json['city'];
    region = json['region'];
    details = json['details'];
  }
}