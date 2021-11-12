
import 'package:shop_app/models/change_password_model.dart';


abstract class ChangePasswordStates {}

class ChangePasswordInitialState extends ChangePasswordStates {}


class ChangePasswordLoadingState extends ChangePasswordStates
{

}
class ChangePasswordSuccessState extends ChangePasswordStates
{
  ChangePasswordModel ChangePassword;

  ChangePasswordSuccessState(this.ChangePassword);
}
class ChangePasswordErrorState extends ChangePasswordStates
{
  final String error;
  ChangePasswordErrorState(this.error);
}

