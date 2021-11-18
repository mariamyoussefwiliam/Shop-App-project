import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/modules/Home/products/product%20details.dart';
import 'package:shop_app/shared/component/MySearch.dart';
import 'package:shop_app/shared/component/component.dart';
import 'package:shop_app/shared/component/constants.dart';

class SearchScreen extends StatelessWidget {
  List<String> images=[
    "https://manticoresearch.com/wp-content/uploads/2020/12/BG.png",
    "https://www.getillustrations.com/packs/download-simple-colorful-outline-illustrations/scenes/_1x/location%20_%20not%20found,%20missing,%20place,%20destination,%20unknown,%20search,%20find_md.png"
  ];
List<String> texts=[
  'Find a Products, Brands, ...',
  'Oops Your Search Not Found, ...'
];
  final String token;
  SearchScreen(this.token);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context,state){},
      builder:(context,state)=> Scaffold(
        //drawer: MyDrawer(token),

        appBar:AppBar(
          //automaticallyImplyLeading: false,
          toolbarHeight: 66,

          title: Text('Search ',style:    TextStyle(
            color: Colors.grey[500],
            fontSize:18,
            //fontWeight: FontWeight.bold,

          ),),
          actions: [
            SizedBox(width: 50,),
            Padding(
              padding:  EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 20),
                    child: MySearch(),
                  ),
                ],
              ),
            ),
        /*    IconButton(
              onPressed: () {
                HomeCubit.get(context).clearSearchData();
              },
              icon: Icon(
                Icons.clear,
                color: defaultcolor,
              ),
            ),*/
          ],


        ),
        body:  Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: ConditionalBuilder(
            condition: state is! SearchLoadingState,
            builder: (context) => ConditionalBuilder(
              condition: HomeCubit.get(context).searchModel != null,
              builder: (context) => ConditionalBuilder(
                condition:
                HomeCubit.get(context).searchModel.data.total != 0,
                builder: (context) => SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 0),
                        child: Row(
                          children: [
                            Text(
                              "Search Results",
                              style: TextStyle(
                                fontSize: 18,
                                color: defaultcolor.withOpacity(0.95),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "${HomeCubit.get(context).searchModel.data.total}",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.redAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) => buildSearchProduct(
                            HomeCubit.get(context)
                                .searchModel
                                .data
                                .products[index],
                            context,
                            state,index),
                        itemCount: HomeCubit.get(context).searchModel.data.total,

                      ),
                    ],
                  ),
                ),
                fallback: (context) =>emptyPage( context: context,image: images[1], text: texts[1])// buildNoSearchFound(context),
              ),
              fallback: (context) =>emptyPage(context:context,image: images[0],text: texts[0]),
            ),
            fallback: (context) =>MyLoading() ,//buildSearchLoadingIndicator(),
          ),
        ),
      ),
    );
  }
}



Widget buildSearchProduct( model, context,state,index) {
  return Dismissible(
    key: UniqueKey(),
    child:    Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Container(
        width: MediaQuery.of(context).size.width/2,
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: InkWell(
          onTap: () async{
            await    Navigator.push(context, MaterialPageRoute(
                builder: (context)=>ProductDetails(model.id)
            )).then((value) {
             // HomeCubit.get(context).GetHomeData();
              //HomeCubit.get(context).getCartData();
            });
          },
          child: Material(

            shadowColor: Colors.grey[300],
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: Colors.white,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Stack(
                    alignment: AlignmentDirectional.bottomStart,
                    children: [
                      Image(
                        image: NetworkImage(
                          model.image,
                        ),
                        width: 160,
                        height: 160,
                      ),
                      if (HomeCubit.get(context).home_model.data.products[index].discount != 0)
                        Container(
                          width: 80,
                          height: 20,
                          color: Colors.red,
                          child: Center(
                            child: Text(
                              "DISCOUNT",
                              style: TextStyle(color: Colors.white, fontSize: 10),
                            ),
                          ),
                        ),

                    ],
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: 180,
                    height: 150,
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Container(
                          width: double.infinity,
                          height: 50,
                          child: Text(
                            //model.name.toString()??"",
                            HomeCubit.get(context).home_model.data.products[index].name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 14, height: 1.1),
                          ),
                        ),
                        Spacer(),
                        Row(
                          children: [
                            Text(
                              "${model.price.round()}" ?? "",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 14, height: 1.2, color: defaultcolor),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            if (HomeCubit.get(context).home_model.data.products[index].discount!= 0)
                              Text(
                                "${HomeCubit.get(context).home_model.data.products[index].old_price.round()}",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 10,
                                    height: 1.2,
                                    color: Colors.grey,
                                    decoration: TextDecoration.lineThrough),
                              ),

                            Spacer(),


                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.favorite,
                                    size: HomeCubit.get(context).favorites[model.id]
                                        ? 34
                                        : 27,
                                    color: HomeCubit.get(context).favorites[model.id]
                                        ? defaultcolor
                                        : Colors.grey[400],
                                  ),
                                  onPressed: () {
                                    print(model.id);

                                    HomeCubit.get(context)
                                        .changeFavorite(productId: model.id);
                                  },
                                ),

                              ],
                            ),
                          ],
                        ),
                        addToCartButton(model,context),



                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
    confirmDismiss: (direction) {
      return Future.value(direction == DismissDirection.horizontal);
    },
    onDismissed: (direction)
    {


    },

  );


}
