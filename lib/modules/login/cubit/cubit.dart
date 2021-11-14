import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/shared/component/constants.dart';
import 'package:shop_app/shared/network/end_point.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {

  LoginModel model ;
  ShopLoginCubit() : super(InitLoginState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  void UserLogin({@required String email, @required String password }) {
    print("errrrrprrrr $email  $password");
    emit(LoginLoadingState());
    DioHelper.postData(url: Login, data: {
      'email':email,
      'password':password,

    })
        .then((value) {

   model = LoginModel.fromJson(value.data);
     // print(model);
      print(model.status);

        // print(value.data['message']);
      //   print(value.data['data']['id']);
     emit( LoginSuccessState(model));

    })
        .catchError((onError) {
          print(onError.toString());
      emit(LoginErrorState(onError.toString()));
    });
  }
  void UserRegister({
    @required String name,
    @required String email,
    @required String password,
    @required String phone,
  }) {


    emit(RegisterLoadingState());
    DioHelper.postData(url: Register, data: {
      'name':name,
      'email':email,
      'password':password,
      'phone':phone,

    })
        .then((value) {
          print(value.data);
          model = LoginModel.fromJson(value.data);

          print(model.status);
      emit( RegisterSuccessState(model));

    })
        .catchError((onError) {
      print(onError.toString());
      emit(RegisterErrorState(onError.toString()));
    });
  }



}
