class AddCartModel {
  bool status;
  String message;
  CartData data;

  AddCartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = CartData.fromJson(json['data']);
  }
}

class CartData {
  int id;
  int quantity;
  CartProduct product;

  CartData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    product = CartProduct.fromJson(json['product']);
  }
}

class CartProduct {
  int id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String image;

  CartProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
  }
}
