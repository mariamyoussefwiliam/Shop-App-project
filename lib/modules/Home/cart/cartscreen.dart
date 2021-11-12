import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/shared/component/component.dart';
import 'package:shop_app/shared/component/constants.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
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
                  builder: (context) => ListView.builder(
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
                  fallback: (context) => emptyPage(
                      context: context,
                      image:"https://freepngimg.com/download/web_design/42851-3-cart-free-clipart-hd.png",
                     text: "Ouhh... Cart is Empty"),
                );
              },
              fallback: (context) => MyLoading(),
            )),
      ),
    );
  }
}
