import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/favorite/get_favorite_data_model.dart';
import 'package:shop_app/modules/Home/products/product%20details.dart';
import 'package:shop_app/shared/component/component.dart';
import 'package:shop_app/shared/component/constants.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {



        },
        builder: (context, state) {
          return ConditionalBuilder(
            condition: HomeCubit.get(context).getFavoritesModel != null &&
                HomeCubit.get(context).getFavoritesModel.data != null,
            builder: (context) {
              return ConditionalBuilder(
                condition: HomeCubit.get(context).getFavoritesModel.data.data.length>0,
                builder:(context)=> ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  itemBuilder: (context, index) {

                      return buildFavoriteItem(
                          HomeCubit.get(context)
                              .getFavoritesModel
                              .data
                              .data[index]
                              .product,
                          context,
                          index,false);

                  },
                  itemCount:
                      HomeCubit.get(context).getFavoritesModel.data.data.length,
                ),
                fallback:(context) => emptyPage(
                  context: context,
                  image:"https://cdn.dribbble.com/users/1670876/screenshots/3754988/media/529cf72420af7fe96932d884e301ca1a.png",
                  text: "Ouhh... Favorite is Empty"),
              );
            },
            fallback: (context) => MyLoading(),
          );
        });
  }

}
