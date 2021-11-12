import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/shared/component/component.dart';
import 'package:shop_app/shared/component/constants.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class CategoryProduct extends StatelessWidget {
  final int product_id;
  final String product_name;
  final String product_image;
  final int index;

  CategoryProduct(this.product_id, this.product_name,this.product_image,this.index);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
       BlocProvider(
        create: (BuildContext context) => CategoryCubit()..CategoryProducts(categoryId: product_id),
       )
      ],
      child: BlocConsumer<HomeCubit,HomeStates>(
        listener: (context,state){},

        builder:(context,state)=> BlocConsumer<CategoryCubit,CategoryStates>(
          listener: (context,state){},
          builder: (context,state)
         {
          return  Scaffold(
               backgroundColor: Colors.white,
               appBar: AppBar(
                 toolbarHeight: 66,

                 brightness: Brightness.dark,
                 title: Text(
                   "$product_name",
                   style: TextStyle(
                     fontSize: 20,
                   letterSpacing: 1,
                   //  fontFamily: 'Font1',
                     //fontWeight: FontWeight.w700,
                     color: Colors.white,
                   ),
                 ),
                 backgroundColor: colors[index],
                 elevation: 0,
                 leading: IconButton(
                   icon: Icon(
                     Icons.arrow_back,
                     color: Colors.white,
                     size: 30,
                   ),
                   onPressed: () {
                     Navigator.pop(context,HomeCubit.get(context).favorites);
                   },
                 ),
               ),
               body: ConditionalBuilder(
                   condition: CategoryCubit.get(context).categoryModel!=null&&Token!=null&&HomeCubit.get(context).getFavoritesModel!=null,
                   builder: (context){
                     return SingleChildScrollView(
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [


                           Container(
                             color: Colors.grey[300],
                             child: ConditionalBuilder(
                               condition: CategoryCubit.get(context).categoryModel.data.data.length>0,
                               builder: (context)=>SingleChildScrollView(
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [

                                     SizedBox(
                                       height: 5,
                                     ),
                                     Container(
                                       color: Colors.grey[300],

                                       child: GridView.count(
                                         shrinkWrap: true,
                                         physics: NeverScrollableScrollPhysics(),
                                         crossAxisSpacing: 4,
                                         mainAxisSpacing: 4,
                                         crossAxisCount: 2,
                                         childAspectRatio: 1 / 1.6,
                                         children: List.generate(CategoryCubit.get(context).categoryModel.data.data.length, (index) => buildGridProduct(CategoryCubit.get(context).categoryModel.data.data[index],context,index)),
                                       ),
                                     ),
                                   ],
                                 ),
                               ),
                               fallback: (context)=>Container(
                                 color: Colors.white,
                                 width: MediaQuery.of(context).size.width,
                                 height: MediaQuery.of(context).size.height/1.123,
                                 child: Center(
                                   child:  Padding(
                                     padding: const EdgeInsets.symmetric( horizontal: 4),
                                     child: Column(
                                       mainAxisAlignment: MainAxisAlignment.center,
                                       children: [
                                         Image(
                                           image: NetworkImage("${product_image}",),
                                           width: 150,
                                           height: 150,
                                         ),
                                         SizedBox(
                                           height: 7,
                                         ),
                                         Text(
                                           "No Product in $product_name , .....",
                                           textAlign: TextAlign.center,
                                           style: TextStyle(
                                             fontSize: 24,
                                             fontWeight: FontWeight.bold,
                                             color: colors[index],
                                           ),
                                         ),
                                       ],
                                     ),
                                   ),
                                 ),
                               ),
                             ),
                           ),
                         ],
                       ),
                     );
                            },
                 fallback: (context)=>Center(child: Container(
                   width: 50,
                   height: 50,
                   child: CircularProgressIndicator(
                     backgroundColor: colors[index],

                   ),
                 )),
               )
             );

         }
        ),
      ),
    );
  }

}
