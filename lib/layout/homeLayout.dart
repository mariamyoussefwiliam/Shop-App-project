import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/modules/Home/cart/cartscreen.dart';
import 'package:shop_app/modules/Home/category/category.dart';
import 'package:shop_app/modules/Home/favorite/favorite.dart';
import 'package:shop_app/modules/Home/home.dart';
import 'package:shop_app/modules/Home/profile/Change%20Password/change_paswword.dart';
import 'package:shop_app/modules/Home/search/search.dart';
import 'package:shop_app/modules/Home/profile/setting.dart';
import 'package:shop_app/shared/component/constants.dart';
import 'package:shop_app/shared/component/mydrawer.dart';

class HomeLayout extends StatefulWidget {
  final String token;

  HomeLayout(this.token);

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);

  @override
  _HomeLayoutState createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  List<Widget> Screens = <Widget>[
    HomeScreen(),
    CategoryScreen(),
    FavoriteScreen(),
    SettingScreen(),
    ChangePasswordScreen()
  ];

  List<String> titles = [
    "Home",
    "Category",
    "Favorite",
    "Profile",
    "Change Password"
  ];

  @override
  Widget build(BuildContext context) {
    Token = widget.token;

    if (widgett == 3&&x) {
      HomeCubit.get(context).ChangeIndex(3);
      setState(() {
        x=!x;
      });
     widgett=0;
    }


    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context,state){

      },
      builder:(context,state)=> Scaffold(
        drawer: MyDrawer(
          widget.token,
        ),
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              ZoomDrawer.of(context).toggle();
            },
          ),
          title: Text(
            titles[HomeCubit.get(context).selectedIndex],
            style: TextStyle(

              color: Colors.black87,

            ),
          ),
          actions: [
            InkWell(
              onTap: () async {
                await Navigator.push(context, MaterialPageRoute(
                  builder: (context)=>CartScreen()
                )).then((value) {

                });
              },
              child: Stack(
                children: [
                  Image(
                    image: NetworkImage(
                        "https://st3.depositphotos.com/3554337/15771/i/1600/depositphotos_157714780-stock-photo-blue-shopping-cart-icon.jpg"),
                    width: 60,
                    height: 110,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.redAccent,
                      child: Center(
                          child: Text(
                        "${HomeCubit.get(context).totalCarts}",
                        style: TextStyle(color: Colors.white),
                      )),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        body: Center(
          child: Screens[HomeCubit.get(context).selectedIndex],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xff6CB9E7),
          child: Icon(Icons.search),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SearchScreen(widget.token))).then((value) {
              HomeCubit.get(context).clearSearchData();
            });
          },
          //params
        ),
        //   floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 5,
                color: Colors.black.withOpacity(.1),
              )
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              child: GNav(
                rippleColor: Colors.grey[300],
                hoverColor: Colors.grey[100],
                gap: 8,
                activeColor: Color(0xff6CB9E7),
                iconSize: 24,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: Duration(milliseconds: 400),
                tabBackgroundColor: Colors.grey[100],
                color: Colors.black,
                tabs: [
                  GButton(
                    icon: Icons.home,
                    iconColor: Colors.lightBlue,
                    text: 'Home',
                  ),
                  GButton(
                    icon: Icons.category,
                    text: 'Category',
                  ),
                  GButton(
                    icon: Icons.favorite,
                    text: 'Favorite',
                  ),
                  GButton(
                    icon: Icons.person,
                    text: 'Profile',
                  ),
                ],
                selectedIndex: HomeCubit.get(context).selectedIndex,
                onTabChange: (index) {
                  widgett=index;
                 HomeCubit.get(context).ChangeIndex(index);

                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
