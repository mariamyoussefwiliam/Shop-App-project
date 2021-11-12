
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/login/LoginScreen.dart';
import 'package:shop_app/modules/settings%20cubit/cubit.dart';
import 'package:shop_app/modules/settings%20cubit/state.dart';
import 'package:shop_app/shared/component/constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class onBoardingModel
{
 final  String image;
 final String title;
 final  String body;

  onBoardingModel({this.image,this.title,this.body});

}
class OnboardingScreen extends StatelessWidget {

  List<onBoardingModel>  onboard=[
    onBoardingModel(image: "images/onboarding1.png",title:"Title Screen 1",body: "Body Screen 1"),
    onBoardingModel(image: "images/onboarding2.png",title:"Title Screen 2",body: "Body Screen 2"),
    onBoardingModel(image: "images/onboarding.jpg",title:"Title Screen 3",body: "Body Screen 3"),


  ];

  var pageController=PageController();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext contxt)=>SettingCubit(),
      child: BlocConsumer<SettingCubit,SettingStates>(
        listener: (context,state){},
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(
              actions: [

                Spacer(),
                InkWell(
                    onTap: (){
                      Navigator.pushAndRemoveUntil(context,
                        MaterialPageRoute(
                            builder: (context)=>LoginScreen()
                        ),
                            (Route<dynamic> route)=>false,
                      );
                    //  CacheHelper.put(key:"skip", value:true);
                      SettingCubit.get(context).skiponBoarding();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20,top: 20),
                      child: Text("SKIP",style: TextStyle(fontSize:20,color: defaultcolor),),
                    )),
              ],

            ),
            body:Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [

                  Expanded(
                    child: PageView.builder(
                      onPageChanged: (index){
                        print(onboard.length);
                        print(index);
                        if(index==onboard.length-1)
                        {
                         SettingCubit.get(context).lastindex(last: true);
                            //isLast=true;

                        }
                        else{
                          SettingCubit.get(context).lastindex(last: false);
                          //isLast=false;
                        }
                      },
                      physics: BouncingScrollPhysics(),
                      controller: pageController,
                      itemBuilder: (context,index)=>buildBoardingItem(onboard[index]),
                      itemCount: onboard.length,
                    ),
                  ),

                  SizedBox(
                    height: 50,
                  ),

                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      SmoothPageIndicator(
                        controller: pageController,

                        count: onboard.length,
                        effect: ExpandingDotsEffect(
                            dotHeight: 12,
                            dotWidth: 12,
                            dotColor:  Colors.grey[400],
                            activeDotColor:  defaultcolor,
                            expansionFactor: 3, //the width of colored indecator
                            spacing: 8
                          //  type: WormType.thin,
                          //    strokeWidth: 15,
                        ),
                      ),
                      Spacer(),
                      FloatingActionButton(
                        backgroundColor: defaultcolor,

                        onPressed: (){
                          if(SettingCubit.get(context).isLast)
                          {
                            Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(
                                  builder: (context)=>LoginScreen()
                              ),
                                  (Route<dynamic> route)=>false,
                            );

                            SettingCubit.get(context).skiponBoarding();

                          }
                          else{
                            pageController.nextPage(duration: Duration(
                              milliseconds: 3000,

                            ), curve: Curves.fastLinearToSlowEaseIn);
                          }

                        },
                        child: Icon(Icons.arrow_forward),
                      ),
                    ],

                  ),
                  SizedBox(
                    height: 20,
                  ),

                ],
              ),

            ),
          );
        },

      ),
    );
  }

  Widget buildBoardingItem(onBoardingModel boarding)=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
          child: Image.asset(boarding.image)),
      SizedBox(
        height: 30,
      ),
      Text(boarding.title,style: TextStyle(
        fontFamily: 'Font1',
        fontWeight: FontWeight.w600,
        fontSize: 40,


      ),),
      SizedBox(
        height: 30,
      ),
      Text( boarding.body
        ,style: TextStyle(
          fontFamily:  'Font1',

            fontSize: 20
        ),),

    ],
  );
}
