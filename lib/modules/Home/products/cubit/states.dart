
import 'package:shop_app/models/favorite/favorite_model.dart';

abstract class CategoryStates {}

class CategoryInitialState extends CategoryStates {}


class CategoryLoadingState extends CategoryStates {}

class CategorySuccessState extends CategoryStates {


  CategorySuccessState();
}

class CategoryErrorState extends CategoryStates {
  final String error;

  CategoryErrorState(this.error);
}

class ProductDetailsLoadingState extends CategoryStates {}

class ProductDetailsSuccessState extends CategoryStates {


  ProductDetailsSuccessState();
}



class ProductDetailsErrorState extends CategoryStates {
  final String error;

  ProductDetailsErrorState(this.error);
}