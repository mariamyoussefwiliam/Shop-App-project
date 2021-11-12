
import 'package:shop_app/models/address/address_model.dart';
import 'package:shop_app/models/address/get%20address%20model.dart';

abstract class AddressStates {}

class AddressInitialState extends AddressStates {}


class GetAddressLoadingState extends AddressStates {}

class GetAddressSuccessState extends AddressStates {
GetAddressDataModel getAddressDataModel;
GetAddressSuccessState(this.getAddressDataModel);
}

class GetAddressErrorState extends AddressStates {
  final String error;

  GetAddressErrorState(this.error);
}


class AddAddressLoadingState extends AddressStates {}

class AddAddressSuccessState extends AddressStates {
  AddressModel addAddressDataModel;
  AddAddressSuccessState(this.addAddressDataModel);
}

class AddAddressErrorState extends AddressStates {
  final String error;

  AddAddressErrorState(this.error);
}


class UpdateAddressLoadingState extends AddressStates {}

class UpdateAddressSuccessState extends AddressStates {
  AddressModel addAddressDataModel;
  UpdateAddressSuccessState(this.addAddressDataModel);
}

class UpdateAddressErrorState extends AddressStates {
  final String error;

  UpdateAddressErrorState(this.error);
}
class DeleteAddressLoadingState extends AddressStates {}

class DeleteAddressSuccessState extends AddressStates {
  AddressModel deleteAddressDataModel;
  DeleteAddressSuccessState(this.deleteAddressDataModel);
}

class DeleteAddressErrorState extends AddressStates {
  final String error;

  DeleteAddressErrorState(this.error);
}


