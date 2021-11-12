import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/shared/component/component.dart';
import 'package:shop_app/shared/component/constants.dart';

class SettingScreen extends StatelessWidget {
  var namecontroller = TextEditingController();
  var emailcontroller = TextEditingController();
  var phonedcontroller = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is UpdateProfileSuccessState) {
          showMessage(msg: state.model.message, color: Colors.blue);
        }
      },
      builder: (context, state) {

            model = HomeCubit.get(context).model;


        if (model != null) {
          namecontroller.text = model.data.name;
          emailcontroller.text = model.data.email;
          phonedcontroller.text = model.data.phone;
        }

        return ConditionalBuilder(
          condition: model != null && Token != null&&widgett==3,
          builder: (context) => SingleChildScrollView(
            child: Stack(
              alignment: Alignment.topCenter,
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
                          fontSize: 35,
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
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('images/person.jpg'),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 280),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                textfield(
                                  hintText: 'Username',
                                  controllel: namecontroller,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "User name must be not empty";
                                    }
                                    return null;
                                  },
                                ),
                                textfield(
                                  hintText: 'Email',
                                  controllel: emailcontroller,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "Email must be not empty";
                                    }
                                    return null;
                                  },
                                ),
                                textfield(
                                  hintText: 'Phone',
                                  controllel: phonedcontroller,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "Phone must be not empty";
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
                                        HomeCubit.get(context).UpdateProfile(
                                            name: namecontroller.text,
                                            email: emailcontroller.text,
                                            phone: phonedcontroller.text);
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
                ),
              ],
            ),
          ),
          fallback: (context) => MyLoading(),
        );
      },
    );
  }

  Widget textfield(
      {@required hintText, @required controllel, @required validator}) {
    return Material(
      elevation: 6,
      shadowColor: Color(0xff6CB9E7),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        validator: validator,
        controller: controllel,
        decoration: InputDecoration(
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
