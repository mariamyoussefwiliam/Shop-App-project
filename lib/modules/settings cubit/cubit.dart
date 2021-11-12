import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/settings%20cubit/state.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class SettingCubit extends Cubit<SettingStates> {


  SettingCubit() : super(InitSetting());

  static SettingCubit get(context) => BlocProvider.of(context);

  bool isLast=false;
  void lastindex({@required bool last})
  {
    isLast=last;
    emit(LastIndexState());
  }



  bool is_skip = false;
  void skiponBoarding()
  {
    is_skip=!is_skip;
    emit(SkipOnBoarding());
    CacheHelper.put(key: "skip", value:is_skip);
  }
}
