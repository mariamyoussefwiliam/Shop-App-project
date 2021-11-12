import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/shared/component/component.dart';

class ForgetPass extends StatelessWidget {
  var emailcontroller = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
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
                    "Reset Password",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue),
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
                    height: 50,
                  ),
                  defaultButton(
                    text: "Submit",
                    width: double.infinity,
                    background: Colors.blue,
                    radius: 5,
                    isUpper: true,
                    function: () {
                      if (formKey.currentState.validate()) {
                        print(emailcontroller.text);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
