import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/login/cubit/cubit.dart';
import 'package:shop_app/shared/component/component.dart';

import 'LoginScreen.dart';
import 'cubit/states.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var emailcontroller = TextEditingController();

  var passwordcontroller = TextEditingController();
  var namecontroller = TextEditingController();

  var phonecontroller = TextEditingController();

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
              print(state);
              if (state is RegisterSuccessState) {
                if (state.model.status) {
                  showMessage(msg: state.model.message, color: Colors.blue);
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                    (Route<dynamic> route) => false,
                  );
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
                        child: Image.asset("assets/images/top1.png",
                            width: size.width),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Image.asset("assets/images/top2.png",
                            width: size.width),
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
                        child: Image.asset("assets/images/bottom1.png",
                            width: size.width),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Image.asset("assets/images/bottom2.png",
                            width: size.width),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Center(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Form(
                              key: formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Register",
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff6CB9E7),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    "Please enter details to register",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.grey),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  defaultTextFormField(
                                    lable: "Name  ",
                                    controller: namecontroller,
                                    validate: (value) {
                                      if (value.isEmpty) {
                                        return "name must be not empty";
                                      }
                                      return null;
                                    },
                                    type: TextInputType.text,
                                    prefixIcon: Icons.person,
                                  ),
                                  SizedBox(
                                    height: 15,
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
                                    onpressed: () {
                                      setState(() {
                                        eye = !eye;
                                      });
                                    },
                                    suffixIcon: eye
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    suffix: true,
                                    obscuretext: eye ? true : false,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  defaultTextFormField(
                                    lable: "Phone",
                                    controller: phonecontroller,
                                    validate: (value) {
                                      if (value.isEmpty) {
                                        return "phone must be not empty";
                                      }
                                      return null;
                                    },
                                    type: TextInputType.phone,
                                    prefixIcon: Icons.phone,
                                  ),
                                  SizedBox(
                                    height: 35,
                                  ),
                                  ConditionalBuilder(
                                    condition: state is! RegisterLoadingState,
                                    builder:(context)=> Row(
                                      children: [
                                        Spacer(),
                                        defaultButton(
                                          text: "Register",

                                          width: 230,
                                          //    background: Colors.blue,
                                          radius: 5,
                                          isUpper: true,
                                          function: () {
                                            if (formKey.currentState.validate()) {
                                              print(emailcontroller.text);
                                              print(passwordcontroller.text);
                                              ShopLoginCubit.get(context)
                                                  .UserRegister(
                                                      name: namecontroller.text,
                                                      email: emailcontroller.text,
                                                      password:
                                                          passwordcontroller.text,
                                                      phone:
                                                          phonecontroller.text);
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                    fallback: (context) =>
                                        Center(child: CircularProgressIndicator()),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  SingleChildScrollView(
                                    //scrollDirection: Axis.horizontal,

                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Spacer(),
                                        Text(
                                          "Already hava an account ?",
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
                                                      LoginScreen(),
                                                ),
                                                (Route<dynamic> route) => false,
                                              );
                                            },
                                            child: Text(
                                              "Login",
                                              style: TextStyle(
                                                  color: Colors.lightBlue),
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
                ))));
  }
}
