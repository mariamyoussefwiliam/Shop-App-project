import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/Home/Address/add%20address%20screen.dart';
import 'package:shop_app/modules/Home/Address/cubit/cubit.dart';
import 'package:shop_app/modules/Home/profile/Change%20Password/change_paswword.dart';
import 'package:shop_app/modules/login/LoginScreen.dart';
import 'package:shop_app/modules/onboarding/onoardingScreen.dart';
import 'package:shop_app/shared/component/zoomdrawer.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

import 'constants.dart';

class MyDrawer extends StatelessWidget {
  final String token;
  MyDrawer(this.token);

  @override
  Widget build(BuildContext context) {
    LoginModel model;
    // TODO: implement build

    return BlocProvider(
      create: (context)=>AddressCubit()..getAddressData(),
      child: BlocConsumer<HomeCubit,HomeStates>(
          listener: (context,state){
            if(state is ProfileSuccessState)
            {
              model=HomeCubit.get(context).model;
            //  print(model);
            }

          },
          builder: (context,state){
            return ConditionalBuilder(
              condition: state is! ProfileLoadingState  &&HomeCubit.get(context).model!=null,
              builder: (context)=> Scaffold(
                backgroundColor: defaultcolor,
                // or drawer
                body: /* Column*/ ListView(
                  //or Row
                  children: <Widget>[
                    InkWell(
                      onTap: (){
                        widgett=3;
                        HomeCubit.get(context).ChangeIndex(3);

                        print(HomeCubit.get(context).selectedIndex);
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                      //   HomeCubit.get(context).ChangeIndex(3);
                           return  Zoom_Drawer(token);
                          },
                        ));
                      },
                      child: Column(
                        children: [
                         // SizedBox(height: 100,),
                          UserAccountsDrawerHeader(
                            accountEmail:HomeCubit.get(context).model.data.email != null ? Text(HomeCubit.get(context).model.data.email,style: TextStyle(fontSize: 12,)):"null",
                            accountName: HomeCubit.get(context).model.data.name != null ? Text(HomeCubit.get(context).model.data.name,style: TextStyle(fontSize: 18),):"name",
                            currentAccountPicture: CircleAvatar(

                              backgroundColor: Colors.lightBlue,
                              backgroundImage:
                              AssetImage('images/person.jpg'),


                            ),
                            decoration: BoxDecoration(
                              color: defaultcolor,

                            ),
                          ),
                        ],
                      ),
                    ),
                     SizedBox(height: 100,),
                    ListTile(
                      title: Text(
                        " Home  ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      leading: Icon(
                        Icons.home,
                        color: Colors.lightBlue,
                        size: 25,
                      ),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder:(context) {
                            widgett=0;
                          return  Zoom_Drawer(token);
                          },
                        ));
                      },
                    ),
                    ListTile(
                      title: Text(
                        "My Orders",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      leading: Icon(
                        Icons.menu,
                        color: Colors.white,
                        size: 25,
                      ),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context)=>ChangePasswordScreen(),
                        ));
                      },
                    ),
                    ListTile(
                      title: Text(
                        "Address",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      leading: Icon(
                        Icons.location_on,
                        color: Colors.white,
                        size: 25,
                      ),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) =>AddAddressScreen(true),
                        ));
                      },
                    ),
                    ListTile(
                      title: Text(
                        "Change Password",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      leading: Icon(
                        Icons.lock,
                        color: Colors.white,
                        size: 25,
                      ),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context)=>ChangePasswordScreen(),
                        ));
                      },
                    ),

                    ListTile(
                      title: InkWell(
                        onTap: () {
                          CacheHelper.clearData();
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => OnboardingScreen()),
                                (Route<dynamic> route) => false,
                          );
                        },
                        child: Text(
                          "On Boarding",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      leading: Icon(
                        Icons.clear,
                        color: Colors.white,
                        size: 25,
                      ),
                      onTap: () {
                        print("on tap");
                      },
                    ),
                     SizedBox(height: 130,),
                      ListTile(
                        title: InkWell(
                            onTap: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context) => LoginScreen()),
                                    (Route<dynamic> route) => false,
                              );
                              CacheHelper.removeData(key: "token");
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 184),
                              child: Container(

                               // width: 35,
                                height: 48,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Colors.orange,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(width: 20,),
                                    Icon(
                                      Icons.exit_to_app,
                                      color: Colors.white,
                                      size: 25,
                                    ),
                                    SizedBox(width: 20,),
                                    Text(
                                      "Logout",
                                      style: TextStyle(fontSize: 18,color: Colors.white,),
                                    ),
                                  ],
                                ),
                              ),
                            )),

                        leading: null,
                        onTap: () {
                          print("on tap");
                        },
                      ),



                  ],
                ),
              ),
              fallback:(context)=> Scaffold(
                body: Center(

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage("images/loading.gif",

                        ),
                        width: 80,
                        height: 80,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text("Loading",
                        style: TextStyle(
                          color: defaultcolor,
                          fontSize: 20,
                        ),),
                    ],
                  ),
                ),
              ),
            );
          },

        ),
    );
  }
}




