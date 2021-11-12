class HomeModel {
  bool status;
  DataModel data;

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = DataModel.fromJson(json['data']);
  }
}

class DataModel {
  List<bannerModel> banners = [];
  List<productModel> products = [];

  DataModel.fromJson(Map<String, dynamic> json) {
    json['banners'].forEach((value) {
      banners.add(bannerModel.fromJson(value));
    });

    json['products'].forEach((value) {
      products.add(productModel.fromJson(value));
    });
  }
}

class bannerModel {
  int id;
  String image;

  bannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class productModel {
  int id;
  dynamic price;
  dynamic old_price;
  dynamic discount;
  String image;
  String name;
  bool inFavorites;
  bool inCart;

  productModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    old_price = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
