import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/modules/Home/Address/add%20address%20screen.dart';
import 'package:shop_app/modules/Home/Address/cubit/cubit.dart';
import 'package:shop_app/modules/Home/order/order_screen.dart';
import 'package:shop_app/shared/component/component.dart';
import 'package:shop_app/shared/component/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: BlocProvider.of<HomeCubit>(context)
      ..getAddressData(),
    child:BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is AddOrderSuccessState) {
          if (state.addOrderModel.status) {
            AwesomeDialog(
              context: context,
              dialogType: DialogType.SUCCES,
              animType: AnimType.SCALE,
              title: 'Your Order in progress',
              desc:
              "Your order was placed successfully.\n For more details check Delivery Status in settings.",
              btnOkText: "Orders",
              btnOkOnPress: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(
                  builder: (context)=>OrderScreen(),
                ));
              },
              btnCancelOnPress: () {
                Navigator.pop(context);
              },
              btnCancelText: "Home",
              btnCancelColor: Colors.yellow,
              btnOkIcon: Icons.home,
              btnCancelIcon: Icons.home,
              width: 400,
            )..show();
          }
        }
      },
      builder: (context, state) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              toolbarHeight: 66,
              brightness: Brightness.light,
              title: Text(
                "cart",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 24
                ),
              ),
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Color(0xff6CB9E7),
                  size: 30,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: ConditionalBuilder(
              condition: HomeCubit.get(context).getFavoritesModel != null &&
                  HomeCubit.get(context).getFavoritesModel.data != null &&
                  HomeCubit.get(context).cartModel != null,
              builder: (context) {
                return ConditionalBuilder(
                  condition: HomeCubit.get(context)
                          .cartModel.data.cartItems.isNotEmpty,
                  builder: (context) => SingleChildScrollView(
                    child: Column(

                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(vertical: 20),
                          itemBuilder: (context, index) {
                            return buildFavoriteItem(
                                HomeCubit.get(context)
                                    .cartModel
                                    .data
                                    .cartItems[index]
                                    .product,
                                context,
                                index,
                                true);
                          },
                          itemCount: HomeCubit.get(context).cartModel.data.cartItems.length,
                        ),
                        SizedBox(height: 50,),

                         Padding(
                            padding: const EdgeInsets.only(left: 15,right: 15),
                            child: defaultButton(text:"Checkout",
                            function: (){
                             bool address=CacheHelper.get(key:"Address");
                              if(address==true||address!=null)
                                {
                                  AwesomeDialog(
                                    context:  navigatorKey.currentContext,
                                    dialogType: DialogType.WARNING,
                                    width: 340,
                                    buttonsBorderRadius: BorderRadius.all(Radius.circular(2)),
                                    headerAnimationLoop: false,
                                    animType: AnimType.BOTTOMSLIDE,
                                    title: 'Question',
                                    desc: 'Are you Sure Confirm This Order...?',
                                    // showCloseIcon: true,
                                    btnCancelOnPress: () {
                                    },
                                    btnOkOnPress: () {
                                      HomeCubit.get(context).getAddressData();
                                      HomeCubit.get(context).addNewOrder();
                                      /*Navigator.push(context, MaterialPageRoute(
                                        builder: (context)=>OrderScreen(),
                                      ));
*/

                                    },
                                  )..show();
                                }
                              else
                                {
                                  AwesomeDialog(
                                    context:  navigatorKey.currentContext,
                                    dialogType: DialogType.WARNING,
                                    width: 340,
                                    buttonsBorderRadius: BorderRadius.all(Radius.circular(2)),
                                    headerAnimationLoop: false,
                                    animType: AnimType.BOTTOMSLIDE,
                                    title: 'INFO ',
                                    desc: 'Add your address to continue checkout.',
                                    // showCloseIcon: true,
                                    btnCancelOnPress: () {
                                    },
                                    btnOkOnPress: () {
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context)=>AddAddressScreen(true),
                                      ));


                                    },
                                  )..show();
                                }



                            },

                              width: double.infinity,

                            ),
                          ),


                      ],
                    ),
                  ),
                  fallback: (context) => emptyPage(
                      context: context,
                      image:"https://freepngimg.com/download/web_design/42851-3-cart-free-clipart-hd.png",
                     text: "Ouhh... Cart is Empty"),
                );
              },
              fallback: (context) => MyLoading(),
            )),
      ),
    ));
  }
}
