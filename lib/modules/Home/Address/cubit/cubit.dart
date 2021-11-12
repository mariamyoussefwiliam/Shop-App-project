import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/address/address_model.dart';
import 'package:shop_app/models/address/get%20address%20model.dart';
import 'package:shop_app/modules/Home/Address/cubit/states.dart';
import 'package:shop_app/shared/component/constants.dart';
import 'package:shop_app/shared/network/end_point.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class AddressCubit extends Cubit<AddressStates> {
  AddressCubit() : super(AddressInitialState());

  static AddressCubit get(context) => BlocProvider.of(context);

  GetAddressDataModel getAddressModel;

  int addressId = 0;
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
      deleteAddressModel = AddressModel.fromJson(value.data);

      emit(DeleteAddressSuccessState(deleteAddressModel));

    }).catchError((error) {
    //  print("Change User Address Error : ${error.toString()}");
      emit(DeleteAddressErrorState(error));
    });
  }



}