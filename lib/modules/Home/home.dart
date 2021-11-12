import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/products/category_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/modules/Home/products/category%20products.dart';
import 'package:shop_app/modules/Home/products/product%20details.dart';
import 'package:shop_app/shared/component/component.dart';
import 'package:shop_app/shared/component/constants.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is ChangeFavoriteErrorState) {
          showMessage(msg: model.message, color: Colors.redAccent);
        }


      },
      builder: (context, state) {

          homeModel = HomeCubit.get(context).home_model;
          category_model = HomeCubit.get(context).category_model;


        return ConditionalBuilder(
          condition: homeModel != null &&
              category_model != null &&
              HomeCubit.get(context).getFavoritesModel != null
          ,
          builder: (context) {

           return productsBuilder(homeModel, category_model, context);
          },
          fallback: (context) => MyLoading(),
        );
      },
    );
  }

  Widget productsBuilder(HomeModel homeModel, CategoryModel model, context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: 250.0,
              viewportFraction: 1,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(
                seconds: 2,
              ),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
            ),
            items: homeModel.data.banners.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Image(
                    image: NetworkImage(
                      "${i.image}",
                    ),
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fill,
                  );
                },
              );
            }).toList(),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Categories",
                  style: TextStyle(
                    fontSize: 25,
                    fontFamily: 'Font1',
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  height: 120,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) =>
                        Category_Item(index, model, context),
                    separatorBuilder: (context, index) => SizedBox(width: 10),
                    itemCount: model.data.data.length,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  "New Products",
                  style: TextStyle(
                    fontSize: 25,
                    fontFamily: 'Font1',
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
              crossAxisCount: 2,
              childAspectRatio: 1 / 1.6,
              children: List.generate(
                homeModel.data.products.length,
                (index) => buildGridProduct(
                    homeModel.data.products[index], context, index),
              ),
            ),
          ),
        ],
      ),
    );
  }



  Widget Category_Item(int index, CategoryModel model, context) {
    return InkWell(



      onTap: ()async {
        await
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryProduct(
                    model.data.data[index].id,
                    model.data.data[index].name,
                    model.data.data[index].image,
                    index))).then((value) {
         HomeCubit.get(context).GetHomeData();
        HomeCubit.get(context).getCartData();
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: colors[index],
        ),
        width: 100,
        height: 110,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 2,
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Center(
                child: Container(
                  width: 100,
                  height: 78,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: item_colors[index],
                  ),
                  child: Center(
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image(
                            width: 87,
                            height: 72,
                            image: NetworkImage(
                              model.data.data[index].image.toString(),
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: 120,
              child: Text(
                model.data.data[index].name,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
