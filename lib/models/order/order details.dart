class OrderDetailsModel {
  bool status;
  OrderDetailsData data;

  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = OrderDetailsData.fromJson(json['data']);
  }
}

class OrderDetailsData {
  int id;
  dynamic cost;
  dynamic vat;
  dynamic total;
  String date;
  String status;
  String paymentMethod;

  OrderDetailsData.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    cost = json["cost"];
    vat = json["vat"];
    total = json["total"];
    paymentMethod = json["payment_method"];
    date = json["date"];
    status = json["status"];
  }
}
