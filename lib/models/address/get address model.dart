

import 'address_model.dart';

class GetAddressDataModel {
  bool status;
  String message;
  DataModel data;

  GetAddressDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = DataModel.fromJson(json['data']);
  }
}

class DataModel {
  List<AddressData> data = [];

  DataModel.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((value) {
      data.add(AddressData.fromJson(value));
    });
  }
}

