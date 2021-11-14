import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/order/order%20details.dart';
import 'package:shop_app/shared/component/component.dart';
import 'package:shop_app/shared/component/constants.dart';
import 'package:shop_app/shared/component/zoomdrawer.dart';

class OrderScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is CancelOrderSuccessState) {
          if (state.cancelOrderModel.status) {

            AwesomeDialog(
              context:  navigatorKey.currentContext,
              dialogType: DialogType.SUCCES,
              width: 340,
              buttonsBorderRadius: BorderRadius.all(Radius.circular(2)),
              headerAnimationLoop: false,
              animType: AnimType.BOTTOMSLIDE,
              title: 'Order has been Cancelled.',
              desc: "Your order was cancelled successfully!",

              btnOkOnPress: () {
              },
            )..show();
          } else {}
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Row(
              children: [
                Text(
                  'Orders',
                  style: TextStyle(

                    fontSize: 25,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),

          ),
          body: ConditionalBuilder(
            condition: HomeCubit.get(context).orderModel.data.data.length > 0,
            builder: (context) => ConditionalBuilder(
              condition: HomeCubit.get(context).ordersDetails.isNotEmpty &&
                  state is! CancelOrderLoadingState,
              builder: (context) => SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    ListView.separated(
                      itemBuilder: (context, index) => buildOrderItem(
                          HomeCubit.get(context).ordersDetails[index].data,
                          context,
                          state),
                      separatorBuilder: (context, index) => Container(),
                        itemCount: HomeCubit.get(context).ordersDetails.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                    ),
                  ],
                ),
              ),
              fallback: (context) => MyLoading(),
            ),
            fallback: (context) => buildNoOrders(context),
          ),
        );
      },
    );
  }

  Widget buildOrderItem(OrderDetailsData model, context, state) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
    child: Material(
     // color: Colors.white,

      shadowColor: Colors.grey,
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "Order ID:",
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,

                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      model.id.toString(),
                      style: TextStyle(
                        color: defaultcolor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                          fontFamily: "FONT1"
                      ),
                    ),
                  ],
                ),
                Text(
                  model.date,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: defaultcolor.withOpacity(0.6),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 6,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "Cost:  ",
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                          fontFamily: "FONT1",

                      ),
                    ),
                    Text(
                      (model.cost).toString().substring(0, 5)+  "LE",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,

                        fontFamily: "FONT1",
                        color: defaultcolor.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "VAT:  ",
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                        fontFamily: "FONT1",
                      ),
                    ),
                    Text(
                      (model.vat).toString().substring(0, 6)+" LE",
                      style: TextStyle(
                        fontSize: 18,
                          fontWeight: FontWeight.w900,

                          fontFamily: "FONT1",

                       color: defaultcolor
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 6,
            ),
            Row(
              children: [
                Text(
                  "Total Amount : ",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                    fontFamily: "FONT1",
                  ),
                ),
                Text(
                  "${model.total} LE",
                  style: TextStyle(
                    fontSize: 18,

                    fontWeight: FontWeight.w700,


                    color: defaultcolor,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 6,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  model.status,
                  style: TextStyle(
                    color: (model.status == "New")
                        ? Colors.green.withOpacity(0.7)
                        : Colors.red.withOpacity(0.4),

                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                  ),
                ),
                if (model.status == "New")
                  defaultButton(

                    text: "Cancel ",
                    function: () {
                      AwesomeDialog(
                        context:  navigatorKey.currentContext,
                        dialogType: DialogType.WARNING,
                        animType: AnimType.SCALE,
                        desc: "",
                        title: 'Are you Sure for Cancel Order ?',
                        btnOkOnPress: () {
                          HomeCubit.get(context).cancelOrder(id: model.id);
                        },
                        btnCancelOnPress: () {},
                      )..show();
                    },
                    width: 100,
                    height: 30,
                  ),
              ],
            ),
          ],
        ),
      ),
    ),
  );

  Widget buildNoOrders(context) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        emptyPage(context:context,image: "https://cdn.dribbble.com/users/429792/screenshots/3649946/media/bb28392f6e913c06c56495260d0204a6.png",text:"You have no orders in progress !"),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: defaultButton(
              text: "Start Shopping",
              function: () {
                Navigator.pushAndRemoveUntil(context,MaterialPageRoute(
                  builder: (context)=> Zoom_Drawer(Token)
                ),
                    (route)=>false);
                HomeCubit.get(context).ChangeIndex(0);
                
              }),
        ),
      ],
    ),
  );
}