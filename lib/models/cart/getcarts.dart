import 'package:shop_app/models/products/product%20details.dart';

class GetCartModel {
  bool status;
  GetCartData data;

  GetCartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = GetCartData.fromJson(json['data']);
  }
}

class GetCartData {
  List<CartItem> cartItems = [];
  dynamic total;

  GetCartData.fromJson(Map<String, dynamic> json) {
    json['cart_items'].forEach((value) {
      cartItems.add(CartItem.fromJson(value));
    });
    total = json['total'];
  }
}

class CartItem {
  int id;
  int quantity;
  Product_Model product;

  CartItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    product = Product_Model.fromJson(json['product']);
  }
}
