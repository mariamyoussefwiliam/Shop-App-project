

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/address/address_model.dart';
import 'package:shop_app/models/address/get%20address%20model.dart';
import 'package:shop_app/models/cart/add%20cart.dart';
import 'package:shop_app/models/cart/getcarts.dart';
import 'package:shop_app/models/cart/updatecart.dart';
import 'package:shop_app/models/favorite/favorite_model.dart';
import 'package:shop_app/models/favorite/get_favorite_data_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/models/order/add%20order.dart';
import 'package:shop_app/models/order/cancle%20order.dart';
import 'package:shop_app/models/order/get%20order.dart';
import 'package:shop_app/models/order/order%20details.dart';
import 'package:shop_app/models/products/category_model.dart';
import 'package:shop_app/shared/component/component.dart';
import 'package:shop_app/shared/component/constants.dart';
import 'package:shop_app/shared/network/end_point.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  LoginModel model;

  void UserProfile( {@required String token}) {
    emit(ProfileLoadingState());
    DioHelper.getData(url: Profile, token: token).then((value) {
      model = LoginModel.fromJson(value.data);

      emit(ProfileSuccessState(model));
    }).catchError((onError) {
      emit(ProfileErrorState(onError.toString()));
    });
  }

  int selectedIndex = 0;

  void ChangeIndex(index) {
    selectedIndex = index;
    emit(ChangeIndexState());
  }

  HomeModel home_model;
  Map<int, bool> favorites = {};
  Map<int, bool> carts = {};
  int ProductLength=0;

  void GetHomeData({String token}) {
    emit(GetHomeDataLoadingState());
    DioHelper.getData(url: Home, token: token).then((value) {
      home_model = HomeModel.fromJson(value.data);

      if(favorites.isEmpty)
      {
      home_model.data.products.forEach((element) {
        ProductLength+=1;

            favorites.addAll({element.id: element.inFavorites});


      }); }
      if(carts.isEmpty)
      {
      home_model.data.products.forEach((element) {

        carts.addAll({element.id: element.inCart});

      }); }
      getFavoriteData();


      print(Token);
      emit(GetHomeDataSuccessState(home_model));
    }).catchError((error) {
      emit(GetHomeDataErrorState(error.toString()));
      print(error.toString());
    });
  }


  FavoriteModel favoriteModel;


  void changeFavorite({
    @required int productId,
  }) {
    favorites[productId] = !favorites[productId];
    emit(ChangeFavoriteIconSuccessState());

    DioHelper.postData(url: Favorite, token: Token, data: {
      'product_id': productId,
    }).then((value) {
      print(value.data);


      favoriteModel = FavoriteModel.fromJson(value.data);
      if (!favoriteModel.status) {
        favorites[productId] = !favorites[productId];
        showMessage(msg: favoriteModel.message, color: Colors.redAccent);
      }
      emit(ChangeFavoriteSuccessState(favoriteModel));
    }).catchError((onError) {
      favorites[productId] = !favorites[productId];
      print(onError.toString());
      emit(ChangeFavoriteErrorState(onError.toString()));
    });
  }

  GetFavoritesModel getFavoritesModel;

  void getFavoriteData() {

    emit(GetFavoriteDataLoadingState());
    DioHelper.getData(url: Favorite, token: Token).then((value) {
      getFavoritesModel = GetFavoritesModel.fromJson(value.data);
      //  print(value.data);
      getFavoritesModel.data.data.forEach((element) {
        favorites.addAll({element.product.id: true});
     //   favorites[element.product.id]= true;
      });


      emit(GetFavoriteSuccessState(getFavoritesModel));
    }).catchError((onError) {
      print(onError.toString());
      emit(GetFavoriteErrorState(onError.toString()));
    });
  }


  CategoryModel category_model;

  void GetCategoryData({String token}) {
    emit(GetCategoryDataLoadingState());
    DioHelper.getData(url: Gategories, token: token).then((value) {
      category_model = CategoryModel.fromJson(value.data);
      emit(GetCategoryDataSuccessState());
      print(category_model.data.data.toString());
    }).catchError((error) {
      emit(GetCategoryDataErrorState(error.toString()));
      print(error.toString());
    });
  }


  // LoginModel updated_model ;
  void UpdateProfile(
      {@required String name, @required String email, @required String phone}) {
    emit(UpdateProfileLoadingState());
    DioHelper.putData(url: Update_Profile, token: Token, data: {
      "name": name,
      "email": email,
      "phone": phone,
    }).then((value) {
      model = LoginModel.fromJson(value.data);

      emit(UpdateProfileSuccessState(model));
    }).catchError((onError) {
      emit(UpdateProfileErrorState(onError.toString()));
    });
  }


  Map<int, int> productCartIds = {};
  Map<int, int> productsQuantity = {};
  Set cartIds = {};

  GetCartModel cartModel;

  void getCartData() {
    emit(GetCartLoadingState());
    DioHelper.getData(url: Carts, token: Token).then((json) {
      cartModel = GetCartModel.fromJson(json.data);
      cartModel.data.cartItems.forEach((element) {
        productCartIds[element.product.id] = element.id;
        productsQuantity[element.product.id] = element.quantity;
      });
      cartIds.addAll(productCartIds.values);
      emit(GetCartSuccessState(cartModel));
      getQuantities();
      print(productCartIds.toString());
      print(productsQuantity.toString());
      print(cartIds.toString());
    }).catchError((error) {
      print(error.toString());
      emit(GetCartErrorState(error));
    });
  }

  int totalCarts = 0;
  void getQuantities() {
    totalCarts = 0;
    if (productsQuantity.isNotEmpty) {
      productsQuantity.forEach((key, value) {
        totalCarts += value;
      });
    }
  }



  AddCartModel cartItem;

  void changeCartItem(int productId) {
    emit(ShopChangeCartItemState());
    var productQuantity = productsQuantity[productId];
    bool added = productQuantity == null;
    if (added) {
      productsQuantity[productId] = 1;
    } else {
      cartIds.remove(productCartIds[productId]);
      productsQuantity.remove(productId);
      productCartIds.remove(productId);
    }


    print("lolololo              x sj$productId");
    DioHelper.postData(
      url: Carts,
      data: {
        'product_id': productId,
      },
      token: Token,
    ).then((value) {
     cartItem = AddCartModel.fromJson(value.data);

      emit(ShopSuccessChangeCartItemState(cartItem));
      getCartData();
    }).catchError((error) {

      emit(ShopErrorChangeCartItemState(error.toString()));
      print("Error Change Cart Data ${error.toString()}");
      print(productId);
    });
  }
  UpdateCartModel updateCartModel;

  void changeQuantityItem(int productId, {bool increment = true}) {
    emit(UpdateCartLoadingState());
    var cartId = productCartIds[productId];
    int quantity = productsQuantity[productId];
    print("hiiiiiiiiiiiiiiiiiiiiiiiiiiii ${quantity}");
   if (increment && quantity >= 0)
      quantity++;
    else if (!increment && quantity > 1)
      quantity--;
    else if (!increment && quantity == 1) {
      quantity--;

      changeCartItem(productId);

    }
    productsQuantity[productId] = quantity;
    DioHelper.putData(
      url: "$Carts/$cartId",
      data: {"quantity": "$quantity"},
      token: Token,
    ).then((value) {
      updateCartModel = UpdateCartModel.fromJson(value.data);
      emit(UpdateCartSuccessState(updateCartModel));
     getCartData();
    }).catchError((error) {
      emit(UpdateCartErrorState(error.toString()));
      print(error);
    });
  }



  GetAddressDataModel getAddressModel;
  int addressId;
  void getAddressData() {
    emit(GetAddressLoadingState());

    DioHelper.getData(url:Address, token: Token).then((value) {
      getAddressModel = GetAddressDataModel.fromJson(value.data);

      emit(GetAddressSuccessState(getAddressModel));
      // print(getAddressModel.data.data .toString());

      if(getAddressModel.data.data.isNotEmpty)
      {
        addressId=getAddressModel.data.data[0].id;
      }
      else{
        addressId=0;
      }

    }).catchError((error) {
      emit(GetAddressErrorState(error.toString()));
      print(error.toString());
    });
  }


  AddressModel addAddressModel;
  void addUserAddress(
      {@required  name, @required city, @required region, @required details}) {

    emit(AddAddressLoadingState());
    DioHelper.postData(
        url: Address,
        data: {
          'name': name,
          'city': city,
          'region': region,
          'details': details,
          "latitude": 30.0616863,
          "longitude": 31.3260088
        },
        token: Token)
        .then((value) {
      addAddressModel = AddressModel.fromJson(value.data);
      getAddressData();
      emit(AddAddressSuccessState(addAddressModel));
    }).catchError((error) {
      print('${error.toString()}');
      emit(AddAddressErrorState(error));
    });
  }



  bool isNewAddress = false;
  AddressModel updateAddressModel;
  void changeUserAddress(
      {@required name, @required city, @required region, @required details}) {

    emit(UpdateAddressLoadingState());
    DioHelper.putData(
        url: "$Address/$addressId",
        data: {
          'name': name,
          'city': city,
          'region': region,
          'details': details,
          "latitude": 30.0616863,
          "longitude": 31.3260088
        },
        token: Token)
        .then((value) {
      updateAddressModel = AddressModel.fromJson(value.data);
      getAddressData();
      emit(UpdateAddressSuccessState(updateAddressModel));
    }).catchError((error) {
      print("Change User Address Error : ${error.toString()}");
      emit(UpdateAddressErrorState(error));
    });
  }


  AddressModel deleteAddressModel;
  void deleteUserAddress(int addressId) {
    emit(DeleteAddressLoadingState());
    DioHelper.deleteData(url: "$Address/$addressId", token: Token)
        .then((value) {
      addressId=0;
      deleteAddressModel = AddressModel.fromJson(value.data);

      emit(DeleteAddressSuccessState(deleteAddressModel));

    }).catchError((error) {
      //  print("Change User Address Error : ${error.toString()}");
      emit(DeleteAddressErrorState(error));
    });
  }




  GetOrderModel orderModel;
  void getOrders() {
    emit(GetOrdersLoadingState());
    DioHelper.getData(url: Orders, token: Token).then((value) {
      orderModel = GetOrderModel.fromJson(value.data);
      ordersDetails.clear();
      ordersIds.clear();
      orderModel.data.data.forEach((element) {
        ordersIds.add(element.id);
      });
      emit(GetOrdersSuccessState(orderModel));
      getOrdersDetails();
    }).catchError((error) {
      emit(GetOrdersErrorState(error));
      print('Get Orders Error ${error.toString()}');
    });
  }

  List<int> ordersIds = [];
  OrderDetailsModel orderItemDetails;
  List<OrderDetailsModel> ordersDetails = [];

  void getOrdersDetails() async {
    emit(OrderDetailsLoadingState());
    if (ordersIds.isNotEmpty) {
      for (var id in ordersIds) {
        await DioHelper.getData(url: "$Orders/$id", token: Token)
            .then((value) {
          orderItemDetails = OrderDetailsModel.fromJson(value.data);
          ordersDetails.add(orderItemDetails);
          emit(OrderDetailsSuccessState(orderItemDetails));
        }).catchError((error) {
          emit(OrderDetailsErrorState(error));
          print('Get Orders Details Error ${error.toString()}');
          return;
        });
      }
    }
  }

  AddOrderModel addOrderModel;
  void addNewOrder() {
    emit(AddOrderLoadingState());
    DioHelper.postData(
        url: Orders,
        data: {
          'address_id': addressId,
          "payment_method": 1,
          "use_points": false,
        },
        token: Token)
        .then((value) {

      addOrderModel = AddOrderModel.fromJson(value.data);
      if (addOrderModel.status) {
        getCartData();
        productsQuantity.clear();
        cartIds.clear();
        productCartIds.clear();
        getOrders();
        emit(AddOrderSuccessState(addOrderModel));
      } else {
       // getCartData();
        //getOrders();
      }
    }).catchError((error) {
      print('${error.toString()}');
      emit(AddOrderErrorState(error));
    });
  }

  CancelOrderModel cancelOrderModel;
  void cancelOrder({@required int id}) {
    emit(CancelOrderLoadingState());
    DioHelper.getData(url: "$Orders/$id/cancel", token: Token).then((value) {
      cancelOrderModel = CancelOrderModel.fromJson(value.data);
      getOrders();
      emit(CancelOrderSuccessState(cancelOrderModel));
    }).catchError((error) {
      print('${error.toString()}');
      emit(CancelOrderErrorState(error));
    });
  }





}
