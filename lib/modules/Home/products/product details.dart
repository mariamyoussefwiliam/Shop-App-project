import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/layout/homeLayout.dart';
import 'package:shop_app/models/products/product%20details.dart';
import 'package:shop_app/modules/Home/home.dart';
import 'package:shop_app/modules/Home/products/cubit/cubit.dart';
import 'package:shop_app/modules/Home/products/cubit/states.dart';
import 'package:shop_app/shared/component/component.dart';
import 'package:shop_app/shared/component/constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetails extends StatelessWidget {
  final int product_id;
  PageController _controller = PageController();

  ProductDetails(this.product_id);


  var descriptionSplited = [];
  final dataKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    var cubit;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
        create: (BuildContext context) =>
    CategoryCubit()..productDetailsData(productId: product_id),),

      ],
      child: BlocConsumer<HomeCubit,HomeStates>(
        listener: (context,state){


        },


        builder:(context,state)=> BlocConsumer<CategoryCubit, CategoryStates>(

            listener: (context, state) {
              cubit = CategoryCubit
                  .get(context)
                  .productDetailsModel;
            }, builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                toolbarHeight: 66,
                brightness: Brightness.dark,
                title: Text(
                  " ",
                  style: TextStyle(
                    fontSize: 20,
                    letterSpacing: 1,
                    //  fontFamily: 'Font1',
                    //fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                backgroundColor: Colors.white,
                elevation: 0,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: defaultcolor,
                    size: 30,
                  ),
                  onPressed: () {
                     Navigator.pop(context);
                  }
                ),
              ),
              body: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  ConditionalBuilder(
                    condition: cubit != null,
                    builder: (context) => buildProductDetails(
                        CategoryCubit.get(context).model, context),
                    fallback: (context) => MyLoading(),
                  ),

                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget buildProductDetails(Product_Model model, context) {
    descriptionSplited.clear();
    descriptionSplited= spliting(model.description);
    print( descriptionSplited[0]);
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
        child: Column(
          key: dataKey,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  model.name.split(" ")[0],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: defaultcolor,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: 30,
                      height: 25,
                      child: Center(
                        child: Text(
                          "5.6",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: defaultcolor,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              model.name,
              style: TextStyle(
                //fontWeight: FontWeight.bold,
                fontSize: 20,
                height: 1.3,
                color: Colors.grey,

              ),
            ),
            SizedBox(
              height: 30,
            ),
            Column(
              children: [
                Container(
                  height: 250,
                  width: double.infinity,
                  child: PageView.builder(
                    scrollDirection: Axis.horizontal,
                    controller: _controller,
                    itemBuilder: (context, index) => Image(
                      image: NetworkImage(model.images[index]),
                    ),
                    itemCount: model.images.length,
                    physics: BouncingScrollPhysics(),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                SmoothPageIndicator(
                  controller: _controller,
                  count: model.images.length,
                  axisDirection: Axis.horizontal,
                  effect: ScrollingDotsEffect(
                    activeDotColor: defaultcolor,
                    dotColor: Colors.grey[300],
                    dotHeight: 10,
                    dotWidth: 10,
                    spacing: 5,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(

                children: [
                  Text(
                    "${model.price}",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      // fontFamily: 'Font1',
                    ),
                  ),
                  Text(
                    ' LE',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),

                  ),

                  if (model.discount > 0)
                    Text(
                      "${model.old_price}",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.favorite,size: HomeCubit.get(context).favorites[product_id]?34:27,color:HomeCubit.get(context).favorites[product_id]?defaultcolor: Colors.grey[400],),
                    onPressed: (){
                      print(model.id);

                      HomeCubit.get(context).changeFavorite(productId: product_id);

                    },

                  ),
                  Container(
                      width: 150,
                      child: addToCartButton(model,context,productId: product_id)),
                  SizedBox(
                    width: 5,
                  ),
                ],
              ),
            ),
            MyDivider(),

            Text(
              "Order in Two Days",
              style: TextStyle(
                fontSize: 16,
                color: defaultcolor.withOpacity(0.8),
                fontWeight: FontWeight.bold,
              ),
            ),




            MyDivider(),

            Text(
              "Description",
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),



            ConditionalBuilder(
              condition:descriptionSplited.length>2,

              builder:(context)=> Container(

                height: 330,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  //shrinkWrap: true,
                  //physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context,index){

                    return descriptionItem(index,context);
                  },
                  itemCount: descriptionSplited.length,

                ),
              ),
              fallback: (context)=>Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.all(15),
                  width: MediaQuery.of(context).size.width,

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[200],
                  ),
                  child: Center(
                    child: Text(

                      "${descriptionSplited[0]}",


                      style: TextStyle(
                        // fontFamily: "FONT1",
                        // fontWeight: FontWeight.w600,
                          color:Colors.black38
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30,),
          ],
        ),
      ),
    );
  }

  Widget descriptionItem(index,context){
    if(index%2==0)
    {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 40,

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: defaultcolor,
          ),
          child: Center(
            child: Text(
              "${descriptionSplited[index]}",

              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white
              ),
            ),
          ),
        ),
      );
    }

    return   Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 40,

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black26,
        ),
        child: Center(
          child: Text(
            "${descriptionSplited[index]}",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white
            ),
          ),
        ),
      ),
    );
  }

  Widget MyDivider() => Column(
    children: [
      SizedBox(
        height: 5,
      ),
      Container(
        width: double.infinity,
        height: 1,
        color: Colors.grey,
      ),
      SizedBox(
        height: 5,
      ),
    ],
  );


  List<String> spliting(string) {
    return string.split("\r\n");
  }
}