import 'dart:ffi';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/modules/Home/products/product%20details.dart';
import 'package:shop_app/shared/network/end_point.dart';

import 'constants.dart';

Widget defaultButton({
  double width = 200,
  Color background = const Color(0xff6CB9E7),
  Function function,
  String text,
  double height,
  double radius = 10,
  bool isUpper = true,
}) =>
    Container(
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(radius),
      ),
      width: width,
      height: height,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpper ? text.toUpperCase() : text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );

Widget emptyPage({@required context,@required String image,@required String text}) => Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: NetworkImage(
                image,
              ),
              width: 300,
              height: 200,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              text,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: defaultcolor,
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );


Widget defaultTextFormField({
  @required Function validate,
  @required TextEditingController controller,
  @required TextInputType type,
  Function onSubmit,
  Function onChanged,
  @required String lable,
  @required IconData prefixIcon,
  @required IconData suffixIcon,
  bool suffix = false,
  bool obscuretext = false,
  @required Function onpressed,
}) =>
    Padding(
      padding: const EdgeInsets.only(top: 8),
      child: TextFormField(
        validator: validate,
        controller: controller,
        keyboardType: type,
        onFieldSubmitted: onSubmit,
        onChanged: onChanged,
        obscureText: obscuretext,
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          // hintText: "Email Address"
          labelText: lable,
          labelStyle: TextStyle(color: Colors.grey[400]),

          prefixIcon: Icon(
            prefixIcon,
            color: Colors.grey,
          ),
          suffixIcon: suffix
              ? IconButton(
                  icon: Icon(
                    suffixIcon,
                    color: Colors.grey,
                  ),
                  onPressed: onpressed,
                )
              : null,
          //border: OutlineInputBorder(),
        ),
      ),
    );

Widget showMessage({@required msg, Color color = Colors.red}) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0);
}

Widget MyLoading() => Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage(
              "images/download2.gif",
            ),
            width: 80,
            height: 80,
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "Loading",
            style: TextStyle(
              color: Color(0xff6CB9E7),
              fontSize: 20,
            ),
          ),
        ],
      ),
    );

Widget myseprator() {
  return Container(
    height: 1,
    width: double.infinity,
    color: Colors.grey,
  );
}

Widget buildGridProduct(var model, context, index) {
  return InkWell(
    onTap: () async {
    await Navigator.push(context,
          MaterialPageRoute(builder: (context) => ProductDetails(model.id))).then((value) {

      });

    },
    child: Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(
                  model.image,
                ),
                width: 200,
                height: 150,
              ),
              if (model.discount != 0)
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
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 50,
                  child: Text(
                    " ${model.name}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14, height: 1.1),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "${model.price.round()}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 14,
                          height: 1.2,
                          color: Color(0xff6CB9E7)),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    if (model.discount != 0)
                      Text(
                        "${model.old_price.round()}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 10,
                            height: 1.2,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),
                      ),
                    Spacer(),
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
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: addToCartButton(model,context)
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}


Widget addToCartButton(var model,context,{productId}) {
  return ConditionalBuilder(
    condition: HomeCubit
        .get(context)
        .productsQuantity[model.id] == null||HomeCubit.get(context).productsQuantity[model.id]==0,
    builder: (context) =>
        defaultButton(
            text: "Add To Cart",
            width: 192,
            //background: Colors.blue,
            radius: 10,
            isUpper: false,
            height: 35,
            function: () {
productId==null?HomeCubit.get(context).changeCartItem(model.id):HomeCubit.get(context).changeCartItem(productId);
              //productId!=null?HomeCubit.get(context).changeQuantityItem(productId,increment: true):HomeCubit.get(context).changeQuantityItem(model.id,increment: true);
            }),

    fallback: (context) =>
        Container(
          width: double.infinity,
          height: 35,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: defaultcolor,

                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(1.5),
                      child: Container(

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,


                        ),
                        child: MaterialButton(
                          child: Text('+',
                            textAlign: TextAlign.center
                            , style: TextStyle(
                                fontSize: 25,

                                color: defaultcolor

                            ),

                          ),
                          onPressed: () {
                            HomeCubit.get(context).changeQuantityItem(productId=model.id,increment: true);
                          },


                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    width: 2,
                    child: productId == null ? Text("${
                        HomeCubit
                            .get(context)
                            .productsQuantity[model.id]
                    }",

                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18,
                          color: defaultcolor,
                          fontWeight: FontWeight.bold
                      ),
                    ) : Text("${
                        HomeCubit
                            .get(context)
                            .productsQuantity[productId]
                    }",

                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18,
                          color: defaultcolor,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: defaultcolor,

                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(1.5),
                      child: Container(

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,


                        ),
                        child: MaterialButton(
                          child: Text('-',
                            textAlign: TextAlign.center
                            , style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,

                                color: defaultcolor

                            ),

                          ),
                          onPressed: () {
                            HomeCubit.get(context).changeQuantityItem(productId=model.id,increment: false);
                          },


                        ),
                      ),
                    ),
                  ),
                ),

              ],

            ),
          ),
        ),
  );
}














  Widget buildFavoriteItem(var model, context, index,bool cart) {
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
           HomeCubit.get(context).GetHomeData();
           HomeCubit.get(context).getCartData();
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
                        if (model.discount != 0)
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
                              model.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 14, height: 1.1),
                            ),
                          ),
                          Spacer(),
                          Row(
                            children: [
                              Text(
                                "${model.price.round()}",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 14, height: 1.2, color: defaultcolor),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              if (model.discount != 0)
                                Text(
                                  "${model.old_price.round()}",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 10,
                                      height: 1.2,
                                      color: Colors.grey,
                                      decoration: TextDecoration.lineThrough),
                                ),
                              Spacer(),
                         !cart?     IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  size: 27,
                                  color: Colors.redAccent,
                                ),
                                onPressed: () {
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.WARNING,
                                    width: 340,
                                    buttonsBorderRadius: BorderRadius.all(Radius.circular(2)),
                                    headerAnimationLoop: false,
                                    animType: AnimType.BOTTOMSLIDE,
                                    title: 'INFO',
                                    desc: 'Are you Sure Delete ${model.name.split(" ")[0]} ${model.name.split(" ")[1]}  ...',
                                    // showCloseIcon: true,
                                    btnCancelOnPress: () {

                                    },
                                    btnOkOnPress: () {

                                        HomeCubit.get(context).changeFavorite(productId: model.id);


                                    },
                                  )..show();

                                },
                              ):

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
                             IconButton(
                               icon: Icon(
                                 Icons.delete,
                                 size: 27,
                                 color: Colors.redAccent,
                               ),
                               onPressed: () {
                                 AwesomeDialog(
                                   context:  navigatorKey.currentContext,
                                   dialogType: DialogType.WARNING,
                                   width: 340,
                                   buttonsBorderRadius: BorderRadius.all(Radius.circular(2)),
                                   headerAnimationLoop: false,
                                   animType: AnimType.BOTTOMSLIDE,
                                   title: 'Question',
                                   desc: 'Are you Sure Delete ${model.name.split(" ")[0]} ${model.name.split(" ")[1]} From Your Cart  ...',
                                   // showCloseIcon: true,
                                   btnCancelOnPress: () {


                                   },
                                   btnOkOnPress: () {


                                         HomeCubit.get(context).changeCartItem(model.id);



                                   },
                                 )..show();


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

