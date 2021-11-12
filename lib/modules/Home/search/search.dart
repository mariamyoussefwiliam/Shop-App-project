import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    return Scaffold(
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
        ],


      ),
      body: Center(

        child:emptyPage(context:context,image: images[0],text: texts[0]),
       // child:buildSearchItem(),
        //child:buildTypeToSearch(context,images[1],texts[1]),

      ),

    );
  }


  Widget buildSearchItem()
  {
    return Padding(
      padding: const EdgeInsets.only(top:20.0),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
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
                          "https://student.valuxapps.com/storage/uploads/products/1615442168bVx52.item_XXL_36581132_143760083.jpeg"),
                      width: 160,
                      height: 160,
                    ),
                    if (1 != 0)
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
                          "name of product",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 14, height: 1.1),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            //"${model.price.round()}",
                            "price",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 14, height: 1.2, color:defaultcolor ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          // if (model.discount != 0)
                          if (1 != 0)
                            Text(
                              // "${model.old_price.round()}",
                              "old price",
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
                              size: 27,
                              color: Colors.grey[400],
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: defaultButton(
                            text: "Add To Cart",
                            width: 192,
                            //background: Colors.blue,
                            radius: 10,
                            isUpper: false,
                            height: 35,
                            function: () {}),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
