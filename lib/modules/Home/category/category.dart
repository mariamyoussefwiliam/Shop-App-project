import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/products/category_model.dart';
import 'package:shop_app/modules/Home/products/category%20products.dart';
import 'package:shop_app/shared/component/component.dart';
import 'package:shop_app/shared/component/constants.dart';
import '../products/product details.dart';

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if(category_model==null)
      {
        category_model = HomeCubit.get(context).category_model;
      }

    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, states) {

      },
      builder: (context, states) => ConditionalBuilder(
        condition: category_model != null,
        builder: (context) => Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Container(
            width: double.infinity,
            child: ListView.separated(
                itemBuilder: (context, index) =>
                    Category_Item(index, category_model,context),
                separatorBuilder: (context, index) => Container(),
                itemCount: category_model.data.data.length),
          ),
        ),
        fallback: (context) => MyLoading(),
      ),
    );
  }

  Widget Category_Item(int index, CategoryModel model,context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: InkWell(
        onTap:() async{
     await Navigator.push(context, MaterialPageRoute(
      builder: (context)=>CategoryProduct(model.data.data[index].id,model.data.data[index].name,model.data.data[index].image,index)
      )).then((value) {
      });
      },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: colors[index],
          ),
          width: double.infinity,
          height: MediaQuery.of(context).size.height/5.6,
          child: Row(
            children: [
              SizedBox(
                width: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: item_colors[index],
                    image: new DecorationImage(
                      image: new NetworkImage(model.data.data[index].image),
                      fit: BoxFit.cover,
                    )),
                width: 110,
                height: 110,
              ),
              Spacer(),
              Container(
                //  width: 120,
                child: Text(
                  model.data.data[index].name,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              IconButton(
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: item_colors[index],
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context)=>CategoryProduct(model.data.data[index].id,model.data.data[index].name,model.data.data[index].image,index)
                  ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
