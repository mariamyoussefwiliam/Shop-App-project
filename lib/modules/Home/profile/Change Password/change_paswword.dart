import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/shared/component/component.dart';
import 'package:shop_app/shared/component/constants.dart';
import 'cubit/Cubit.dart';
import 'cubit/states.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  bool eye1 = true;
  bool eye2 = true;
  bool eye3 = true;
  var currentpasswordcontroller = TextEditingController();

  var newpasswordcontroller = TextEditingController();

  var confirmcontroller = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangePasswordcubit(),
      child: BlocConsumer<ChangePasswordcubit, ChangePasswordStates>(
        listener: (context, state) {
          //   HomeCubit.get(context).ChangeIndex(0);

          if (state is ChangePasswordSuccessState) {
            showMessage(msg: state.ChangePassword.message, color: Colors.blue);
          } else if (state is ChangePasswordErrorState) {
            showMessage(msg: "Your Current Password Failed", color: Colors.red);
          }
        },
        builder: (context, state) {
          return ConditionalBuilder(
            condition: Token != null,
            builder: (context) => MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                appBar: AppBar(
                  backgroundColor: Color(0xff6CB9E7),
                  elevation: 0,
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                body: Stack(
                  alignment: Alignment.center,
                  children: [
                    CustomPaint(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                      ),
                      painter: HeaderCurvedContainer(),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            "",
                            style: TextStyle(
                              fontSize: 30,
                              letterSpacing: 1.5,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10.0),
                          width: MediaQuery.of(context).size.width / 2,
                          height: MediaQuery.of(context).size.width / 2,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 5),
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Center(
                              child: Text(
                            "  Change \n Password",
                            style: TextStyle(
                                fontSize: 30,
                                letterSpacing: 1.5,
                                color: Color(0xff6CB9E7),
                                fontFamily: "FONT1",
                                fontWeight: FontWeight.w600),
                          )),
                        ),
                      ],
                    ),

                    Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          if (state is UpdateProfileLoadingState)
                            LinearProgressIndicator(),
                          Container(
                            height: 430,
                            width: double.infinity,
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  textfield(
                                    hintText: 'Current Password',
                                    obsecure: eye1 ? true : false,
                                    onpressed: () {
                                      setState(() {
                                        eye1 = !eye1;
                                      });
                                    },
                                    suffixicon: eye1
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    controllel: currentpasswordcontroller,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "this must be not empty";
                                      }
                                      return null;
                                    },
                                  ),
                                  textfield(
                                    hintText: 'New Password',
                                    obsecure: eye2 ? true : false,
                                    onpressed: () {
                                      setState(() {
                                        eye2 = !eye2;
                                      });
                                    },
                                    suffixicon: eye2
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    controllel: newpasswordcontroller,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "this must be not empty";
                                      }
                                      return null;
                                    },
                                  ),
                                  textfield(
                                    obsecure: eye3 ? true : false,
                                    onpressed: () {
                                      print(" eyeee $eye3");
                                      setState(() {
                                        eye3 = !eye3;
                                      });
                                    },
                                    suffixicon: eye3
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    hintText: 'Confirm Password',
                                    controllel: confirmcontroller,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "this must be not empty";
                                      }
                                      return null;
                                    },
                                  ),
                                  Container(
                                    height: 50,
                                    width: double.infinity,
                                    child: RaisedButton(
                                      onPressed: () {
                                        if (formKey.currentState.validate()) {
                                          if (newpasswordcontroller.text ==
                                              confirmcontroller.text) {
                                            ChangePasswordcubit.get(context)
                                                .ChangePassword(
                                              token: Token,
                                              current_pass:
                                                  currentpasswordcontroller.text,
                                              new_pass:
                                                  newpasswordcontroller.text,
                                            );
                                          } else {
                                            showMessage(
                                                msg:
                                                    "new pass and confirm pass now equal");
                                          }
                                        }
                                      },
                                      color: Color(0xff6CB9E7),
                                      child: Center(
                                        child: Text(
                                          "Update",
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                            //fontFamily: "FONT1"
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            fallback: (context) => MyLoading(),
          );
        },
      ),
    );
  }

  Widget textfield(
      {@required hintText,
      @required controllel,
      @required validator,
      @required IconData suffixicon,
      @required obsecure,
      @required Function onpressed}) {
    return Material(
      elevation: 6,
      shadowColor: Color(0xff6CB9E7),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        validator: validator,
        controller: controllel,
        obscureText: obsecure,
        decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: Icon(
                suffixicon,
                color: Color(0xff6CB9E7),
              ),
              onPressed: onpressed,
            ),
            labelText: hintText,
            labelStyle: TextStyle(
              letterSpacing: 2,
              color: Colors.black54,
              fontSize: 18,
            ),

            // hintText: hintText,
            hintStyle: TextStyle(
              letterSpacing: 2,
              color: Colors.black54,
            ),
            fillColor: Colors.white30,
            filled: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none)),
      ),
    );
  }
}

class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Color(0xff6CB9E7);
    Path path = Path()
      ..relativeLineTo(0, 150)
      ..quadraticBezierTo(size.width / 2, 225, size.width, 150)
      ..relativeLineTo(0, -150)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
