import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/change_password_model.dart';
import 'package:shop_app/modules/Home/profile/Change%20Password/cubit/states.dart';
import 'package:shop_app/shared/component/constants.dart';
import 'package:shop_app/shared/network/end_point.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class ChangePasswordcubit extends Cubit<ChangePasswordStates> {
  ChangePasswordcubit() : super(ChangePasswordInitialState());

  static ChangePasswordcubit get(context) => BlocProvider.of(context);

  ChangePasswordModel changePasswordModel;

  void ChangePassword(
      {@required String token,
      @required String current_pass,
      @required String new_pass}) {
    emit(ChangePasswordLoadingState());
    DioHelper.postData(url: Change_Password, token: Token, data: {
      "current_password": current_pass,
      "new_password": new_pass,
    }).then((value) {
      changePasswordModel = ChangePasswordModel.fromJson(value.data);

      emit(ChangePasswordSuccessState(changePasswordModel));
    }).catchError((onError) {
      print(onError.toString());
      emit(ChangePasswordErrorState(onError.toString()));
    });
  }
}
