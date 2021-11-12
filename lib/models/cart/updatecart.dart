import 'add cart.dart';

class UpdateCartModel {
  bool status;
  String message;
  UpdateCart data;

  UpdateCartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = UpdateCart.fromJson(json['data']);
  }
}

class UpdateCart {
  UpdateCartData cart;
  dynamic total;

  UpdateCart.fromJson(Map<String, dynamic> json) {
    cart = UpdateCartData.fromJson(json['cart']);
    total = json['total'];
  }
}

class UpdateCartData {
  int id;
  int quantity;
  CartProduct product;

  UpdateCartData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = int.parse(json['quantity']);
    product = CartProduct.fromJson(json['product']);
  }
}
