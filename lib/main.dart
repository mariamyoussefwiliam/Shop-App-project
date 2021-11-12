import 'package:bloc/bloc.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/login/LoginScreen.dart';
import 'package:shop_app/shared/component/constants.dart';
import 'package:shop_app/shared/component/zoomdrawer.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/obsever.dart';
import 'layout/cubit/cubit.dart';
import 'modules/onboarding/onoardingScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  DioHelper.init();
  bool skip =false;
  if(CacheHelper.get(key: "skip")!=null)
  {
   skip= CacheHelper.get(key: "skip");

  }
  Widget startWidget;
  String token=CacheHelper.get(key: "token");
  if(token!=null)
    {
      Token=token;
      startWidget=Zoom_Drawer(token);
    }
  else if(skip)
    {
      startWidget=LoginScreen();
    }
  else {
    startWidget=OnboardingScreen();
  }
  print(skip);
  runApp(MyApp(skip , startWidget,));
}

class MyApp extends StatelessWidget {

   final bool Skip;
   final Widget StartWidget;
   MyApp(this.Skip, this.StartWidget);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
   /* SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.white));*/

    return MultiBlocProvider(
      providers: [
        BlocProvider(
      create: (context)=>HomeCubit()..GetHomeData()..UserProfile(token: Token)..GetCategoryData()..getCartData(),
        ),

      ],
      child: MaterialApp(
        builder: BotToastInit(),
        debugShowCheckedModeBanner: false,
        title: "Shop app",
        home:StartWidget,
        //!Skip? OnboardingScreen():LoginScreen(),
        theme: ThemeData(
          //  primarySwatch:  MaterialColor(0xff6cbae8,color),

          appBarTheme: AppBarTheme(

            brightness: Brightness.light,

            iconTheme: IconThemeData(
              color: Colors.lightBlue,
            ),

            color: Colors.white,
            elevation: 0,
          ),

          scaffoldBackgroundColor: Colors.white,
        ),
      ),
    );
  }
}













































