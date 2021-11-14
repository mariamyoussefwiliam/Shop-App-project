class CancelOrderModel {
  bool status;
  String message;
  CancelOrderModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}