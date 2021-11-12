import 'package:shop_app/models/cart/add%20cart.dart';
import 'package:shop_app/models/cart/getcarts.dart';
import 'package:shop_app/models/cart/updatecart.dart';
import 'package:shop_app/models/favorite/favorite_model.dart';
import 'package:shop_app/models/favorite/get_favorite_data_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';

abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class ProfileLoadingState extends HomeStates {}

class ProfileSuccessState extends HomeStates {
  final LoginModel model;

  ProfileSuccessState(this.model);
}

class ProfileErrorState extends HomeStates {
  final String error;

  ProfileErrorState(this.error);
}

class ChangeIndexState extends HomeStates {}

class GetHomeDataLoadingState extends HomeStates {}

class GetHomeDataSuccessState extends HomeStates {
  final HomeModel model;

  GetHomeDataSuccessState(this.model);
}

class GetHomeDataErrorState extends HomeStates {
  final String error;

  GetHomeDataErrorState(this.error);
}

class GetCategoryDataLoadingState extends HomeStates {}

class GetCategoryDataSuccessState extends HomeStates {
  GetCategoryDataSuccessState();
}

class GetCategoryDataErrorState extends HomeStates {
  final String error;

  GetCategoryDataErrorState(this.error);
}

class UpdateProfileLoadingState extends HomeStates {}

class UpdateProfileSuccessState extends HomeStates {
  final LoginModel model;

  UpdateProfileSuccessState(this.model);
}

class UpdateProfileErrorState extends HomeStates {
  final String error;

  UpdateProfileErrorState(this.error);
}
class ChangeFavoriteIconSuccessState extends HomeStates {
}

class ChangeFavoriteSuccessState extends HomeStates {
  final FavoriteModel favoriteModel;

  ChangeFavoriteSuccessState(this.favoriteModel);
}

class ChangeFavoriteErrorState extends HomeStates {
  final String error;

  ChangeFavoriteErrorState(this.error);
}
class GetFavoriteDataLoadingState extends HomeStates{

}

class GetFavoriteSuccessState extends HomeStates {
  final GetFavoritesModel getfavoriteModel;

  GetFavoriteSuccessState(this.getfavoriteModel);
}

class GetFavoriteErrorState extends HomeStates {
  final String error;

  GetFavoriteErrorState(this.error);
}
class GetCartLoadingState extends HomeStates{

}

class GetCartSuccessState extends HomeStates {
  final GetCartModel getfavoriteModel;

  GetCartSuccessState(this.getfavoriteModel);
}

class GetCartErrorState extends HomeStates {
  final String error;

  GetCartErrorState(this.error);
}

class UpdateCartLoadingState extends HomeStates{

}

class UpdateCartSuccessState extends HomeStates {
  final UpdateCartModel updateCartModel;

  UpdateCartSuccessState(this.updateCartModel);
}

class UpdateCartErrorState extends HomeStates {
  final String error;

  UpdateCartErrorState(this.error);
}

class ShopChangeCartItemState extends HomeStates
{

}


class ShopSuccessChangeCartItemState extends HomeStates {
  final AddCartModel updateCartModel;

  ShopSuccessChangeCartItemState(this.updateCartModel);
}

class ShopErrorChangeCartItemState extends HomeStates {
  final String error;

  ShopErrorChangeCartItemState(this.error);
}
