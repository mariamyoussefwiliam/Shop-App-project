
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/favorite/favorite_model.dart';
import 'package:shop_app/models/products/category%20productsmodel.dart';
import 'package:shop_app/models/products/product%20details.dart';
import 'package:shop_app/modules/Home/products/cubit/states.dart';
import 'package:shop_app/shared/component/constants.dart';
import 'package:shop_app/shared/network/end_point.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';


class CategoryCubit extends Cubit<CategoryStates> {
  CategoryCubit() : super(CategoryInitialState());

  static CategoryCubit get(context) => BlocProvider.of(context);

  CategoryDetailsModel categoryModel;

  void CategoryProducts({@required categoryId}) {
    emit(CategoryLoadingState());
    DioHelper.getData(url: "$Category_Products?category_id=$categoryId", token: Token).then((value) {
    //  if(value.data.data)
      categoryModel = CategoryDetailsModel.fromJson(value.data);
      //print(" ${categoryModel.data.data[0].id}");
      emit(CategorySuccessState());

    }).catchError((error) {
      emit(CategoryErrorState(error.toString()));
      print(error.toString());
    });
  }
  ProductDetails productDetailsModel;
  Product_Model model;
  void productDetailsData({@required productId}) {
    emit(ProductDetailsLoadingState());
    DioHelper.getData(url: "$Category_Products/$productId", token: Token).then((value) {
      //  if(value.data.data)
      productDetailsModel = ProductDetails.fromJson(value.data);
      model=productDetailsModel.data;
      //print(" ${categoryModel.data.data[0].id}");
      emit(ProductDetailsSuccessState());
      //print(productDetailsModel.data.in_favorites);

    }).catchError((error) {
      emit(ProductDetailsErrorState(error.toString()));
      print(error.toString());
    });
  }




}
