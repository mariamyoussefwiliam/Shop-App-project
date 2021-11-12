
class CategoryDetailsModel{

  bool status;
  DataModel data;
  CategoryDetailsModel.fromJson(Map<String,dynamic> json){
    status=json['status'];
    data=DataModel.fromJson(json['data']);
  }
}
class DataModel{
  List<ProductModel> data=[];

  DataModel.fromJson(Map<String,dynamic> json)
  {

    if( json['data']!=null)
      {
        json['data'].forEach((value) {
          print(value);
          data.add(ProductModel.fromJson(value));
        });
      }
  }
}

class ProductModel {
  int id;
  dynamic price;
  dynamic old_price;
  dynamic discount;
  String image;
  String name;
  String description;
  List<String> images=[];
  bool in_favorites;
  bool in_cart;

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    old_price = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description=json['description'];
    json['images'].forEach((element){
      images.add(element);
    });
    in_favorites = json['in_favorites'];
    in_cart = json['in_cart'];
  }
}