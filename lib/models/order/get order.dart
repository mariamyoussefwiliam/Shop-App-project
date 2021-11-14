class GetOrderModel {
  bool status;
  GetOrdersData data;

  GetOrderModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = GetOrdersData.fromJson(json['data']);
  }
}

class GetOrdersData {
  int totalOrders;
  List<GetOrderData> data = [];

  GetOrdersData.fromJson(Map<String, dynamic> json) {
    totalOrders = json['total'];
    data =
        List.from(json['data']).map((e) => GetOrderData.fromJson(e)).toList();
    data.sort((a, b) => b.status.compareTo(a.status));
  }
}

class GetOrderData {
  int id;
  dynamic total;
  String date;
  String status;

  GetOrderData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    total = json['total'];
    date = json['date'];
    status = json['status'];
  }
}
