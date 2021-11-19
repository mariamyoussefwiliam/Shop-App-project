import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/layout/homeLayout.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/shared/component/mydrawer.dart';

import 'constants.dart';

class Zoom_Drawer extends StatelessWidget
{

  final String token;


  Zoom_Drawer(this.token);

  @override
  Widget build(BuildContext context) {


  return   BlocProvider.value(
        value: BlocProvider.of<HomeCubit>(context)
    ..GetHomeData()..UserProfile(token: Token)..GetCategoryData()..getOrders()..getAddressData(),
     child:BlocConsumer<HomeCubit,HomeStates>(
          listener: (context,state){

            if(state is ChangeFavoriteIconSuccessState)
              {
                HomeCubit.get(context).GetHomeData(token:Token);
              }
            if(state is ShopSuccessChangeCartItemState)
            {
              HomeCubit.get(context).GetHomeData(token: Token);
            }
            if(state is UpdateCartSuccessState)
            {
              HomeCubit.get(context).GetHomeData(token: Token);
            }




          },
      builder: (context,state){




      return ZoomDrawer(
        style: DrawerStyle.Style1,
        borderRadius: 40,
        angle: -7,
        //slideWidth: MediaQuery.of(context).size.width*0.66,
        showShadow: true,
        backgroundColor: Colors.lightBlue,
        mainScreen: HomeLayout(token),
        menuScreen: MyDrawer(token),
      );

  }

    )
  );
}
}