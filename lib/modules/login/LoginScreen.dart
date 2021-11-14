import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/login/RegisterScreen.dart';
import 'package:shop_app/modules/login/cubit/cubit.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/shared/component/component.dart';
import 'package:shop_app/shared/component/constants.dart';
import 'package:shop_app/shared/component/zoomdrawer.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailcontroller = TextEditingController();

  var passwordcontroller = TextEditingController();

  var formKey = GlobalKey<FormState>();

  bool eye = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // TODO: implement build
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          SystemChrome.setSystemUIOverlayStyle(
              SystemUiOverlayStyle(statusBarColor: Colors.white));

          print(state);
          if (state is LoginSuccessState) {
            if (state.model.status) {
              Token=state.model.data.token;
              print(state.model.message);
              print(state.model.data.id);
              showMessage(msg: state.model.message, color: Colors.blue);
              CacheHelper.put(key: "token", value: state.model.data.token)
                  .then((value) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) {
                    widgett = 0;
                    return Zoom_Drawer(state.model.data.token);
                  }),
                  (Route<dynamic> route) => false,
                );
              });
            } else {
              showMessage(msg: state.model.message);
            }
          }
        },
        builder: (context, state) => Scaffold(
            body: Container(
          width: double.infinity,
          height: size.height,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                top: 0,
                right: 0,
                child: Image.asset("assets/images/top1.png", width: size.width),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Image.asset("assets/images/top2.png", width: size.width),
              ),
              Positioned(
                top: 50,
                right: 30,
                child: Image.asset("assets/images/main.png",
                    width: size.width * 0.35),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Image.asset(
                  "assets/images/bottom1.png",
                  width: size.width,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child:
                    Image.asset("assets/images/bottom2.png", width: size.width),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 60, right: 20, left: 20, bottom: 20),
                child: Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Login",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xff6CB9E7),
                              fontSize: 30,
                            ),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            "Please login to your account",
                            style: TextStyle(fontSize: 20, color: Colors.grey),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          defaultTextFormField(
                            lable: "Email ",
                            controller: emailcontroller,
                            validate: (value) {
                              if (value.isEmpty) {
                                return "email must be not empty";
                              }
                              return null;
                            },
                            type: TextInputType.emailAddress,
                            prefixIcon: Icons.email,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          defaultTextFormField(
                            lable: "Password",
                            controller: passwordcontroller,
                            validate: (value) {
                              if (value.isEmpty) {
                                return "password must be not empty";
                              }
                              return null;
                            },
                            type: TextInputType.visiblePassword,
                            prefixIcon: Icons.lock,
                            onSubmit: (value) {
                              if (formKey.currentState.validate()) {
                                print(emailcontroller.text);
                                print(passwordcontroller.text);
                                ShopLoginCubit.get(context).UserLogin(
                                    email: emailcontroller.text,
                                    password: passwordcontroller.text);
                              }
                            },
                            onpressed: () {
                              setState(() {
                                eye = !eye;
                              });
                            },
                            suffixIcon:
                                eye ? Icons.visibility : Icons.visibility_off,
                            suffix: true,
                            obscuretext: eye ? true : false,
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Row(
                            children: [
                              Spacer(),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ConditionalBuilder(
                            condition: state is! LoginLoadingState,
                            builder: (context) => Row(
                              children: [
                                Spacer(),
                                defaultButton(
                                  text: "loGin",

                                  width: 230,
                                  //background: Colors.blue,
                                  radius: 5,
                                  isUpper: true,
                                  function: () {
                                    if (formKey.currentState.validate()) {
                                      print(emailcontroller.text);
                                      print(passwordcontroller.text);
                                      ShopLoginCubit.get(context).UserLogin(
                                          email: emailcontroller.text,
                                          password: passwordcontroller.text);
                                    }
                                  },
                                ),
                              ],
                            ),
                            fallback: (contxt) =>
                                Center(child: CircularProgressIndicator()),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SingleChildScrollView(
                            //scrollDirection: Axis.horizontal,

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Spacer(),
                                Text(
                                  "Don\'t hava an account ?",
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                    onTap: () {
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              RegisterScreen(),
                                        ),
                                        (Route<dynamic> route) => false,
                                      );
                                    },
                                    child: Text(
                                      "Register",
                                      style: TextStyle(color: Colors.lightBlue),
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
