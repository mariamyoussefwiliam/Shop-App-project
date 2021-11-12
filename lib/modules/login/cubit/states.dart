import 'package:shop_app/models/login_model.dart';

abstract class ShopLoginStates
{

}
class InitLoginState extends ShopLoginStates
{

}

class LoginLoadingState extends ShopLoginStates
{

}
class LoginSuccessState extends ShopLoginStates
{
  final LoginModel model;

  LoginSuccessState(this.model);
}
class LoginErrorState extends ShopLoginStates
{
  final String error;
  LoginErrorState(this.error);

}



class RegisterLoadingState extends ShopLoginStates
{

}
class RegisterSuccessState extends ShopLoginStates
{
  final LoginModel model;

  RegisterSuccessState(this.model);
}
class RegisterErrorState extends ShopLoginStates
{
  final String error;
  RegisterErrorState(this.error);

}
