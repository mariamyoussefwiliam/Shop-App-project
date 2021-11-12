class ProductDetails {
  bool status;
  Product_Model data;

  ProductDetails.fromJson(Map<String, dynamic> json){
    status = json['status'];
    data = Product_Model.fromJson(json['data']);
  }

}
  class Product_Model {
  int id;
  dynamic price;
  dynamic old_price;
  dynamic discount;
  String image;
  String name;
  String description;
  bool in_favorites;
  bool in_cart;
  List<String> images=[];
  Product_Model.fromJson(Map<String, dynamic> json) {
  id = json['id'];
  price = json['price'];
  old_price = json['old_price'];
  discount = json['discount'];
  image = json['image'];
  name = json['name'];
  description=json['description'];
  in_favorites = json['in_favorites'];
  in_cart = json['in_cart'];

  json['images'].forEach((element){
    images.add(element);
  });
  }
  }
