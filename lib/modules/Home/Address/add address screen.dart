import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/modules/Home/Address/cubit/cubit.dart';
import 'package:shop_app/modules/Home/Address/cubit/states.dart';
import 'package:shop_app/shared/component/component.dart';
import 'package:shop_app/shared/component/constants.dart';
import 'package:shop_app/shared/component/zoomdrawer.dart';

class AddAddressScreen extends StatefulWidget {

  final bool x;
  AddAddressScreen(this.x);
  @override
  _AddAddressScreenState createState() => _AddAddressScreenState(this.x);

}
class _AddAddressScreenState extends State<AddAddressScreen> {

  var formKey = GlobalKey<FormState>();
  var deletecurrentpasswordcontroller = TextEditingController();
  var deletenewpasswordcontroller = TextEditingController();
  var deleteconfirmcontroller = TextEditingController();
  var deletestreetcontroller = TextEditingController();
  int tabbarindex=0;
   bool x;

  _AddAddressScreenState( this.x);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>AddressCubit()..getAddressData(),
      child: BlocConsumer<AddressCubit, AddressStates>(
        listener: (context, state) {

          if(state is AddAddressSuccessState)
            {
              Navigator.push(context, MaterialPageRoute(
                builder: (context)=>AddAddressScreen(true)
              ));
              showMessage(msg: state.addAddressDataModel.message, color: Colors.blue);
            }
          if(state is UpdateAddressSuccessState)
          {
            showMessage(msg: state.addAddressDataModel.message, color: Colors.blue);

          }
          if(state is UpdateAddressLoadingState)
          {
            Center(child: CircularProgressIndicator());
          }
          if(state is DeleteAddressLoadingState)
          {
            showMessage(msg: "Deleted Successfully", color: Colors.red);
          }


        },
        builder: (context, state) {


          return ConditionalBuilder(
            condition: Token != null&&AddressCubit.get(context).getAddressModel!=null,
            builder: (context) => ConditionalBuilder(
              condition: AddressCubit.get(context).addressId==0,
              builder: (context){

                List<Column> padges=[
                  add(state,context),

                ];
                return MaterialApp(
                debugShowCheckedModeBanner: false,
                home: Stack(
                  children: [
                    DefaultTabController(

                      length: 1,
                      child: Scaffold(
                        appBar: AppBar(
                          backgroundColor: Colors.grey[50],
                          elevation: 0,
                          bottom: TabBar(
                            indicatorColor: defaultcolor,


                            tabs: [

                              Text(
                                "Add",
                                style: TextStyle(
                                  color: tabbarindex==0?defaultcolor:Colors.grey,
                                  fontSize: tabbarindex==0?16:null,
                                ),
                              ),

                            ],
                          ),
                          leading: IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              color: defaultcolor,
                              size: 30,

                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        body: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,

                            children: [
                              SizedBox(height: 20,),
                              Container(
                                padding: EdgeInsets.all(10.0),
                                width: MediaQuery.of(context).size.width / 1.2,
                                height: MediaQuery.of(context).size.width / 6,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white, width: 5),
                                    shape: BoxShape.rectangle,
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20)
                                ),
                                child: Center(
                                    child: Text(
                                      "Address",
                                      style: TextStyle(
                                          fontSize: 30,
                                          letterSpacing: 1.5,
                                          color: Color(0xff6CB9E7),
                                          fontFamily: "FONT1",
                                          fontWeight: FontWeight.w600),
                                    )),
                              ),

                              Form(
                                key: formKey,
                                child:padges[tabbarindex] ,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );},
              fallback: (context){

                List<Widget> padges=[
                  update(state,context,x),
                  delete(state,context),
                ];


                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  home: Stack(
                    children: [
                      DefaultTabController(

                        length: 2,
                        child: Scaffold(
                          appBar: AppBar(
                            backgroundColor: Colors.grey[50],
                            elevation: 0,
                            bottom: TabBar(
                              indicatorColor: defaultcolor,
                              onTap: (value){
                                print(value);

                                setState(() {
                                  tabbarindex=value;
                                });
                              },

                              tabs: [

                                Text(
                                  "Update",
                                  style: TextStyle(
                                    color: tabbarindex==0?defaultcolor:Colors.grey,
                                    fontSize: tabbarindex==0?16:null,
                                  ),
                                ),
                                Text(
                                  "Delete",
                                  style: TextStyle(
                                    color: tabbarindex==1?defaultcolor:Colors.grey,
                                    fontSize: tabbarindex==1?16:null,
                                  ),
                                ),

                              ],
                            ),
                            leading: IconButton(
                              icon: Icon(
                                Icons.arrow_back,
                                color: defaultcolor,
                                size: 30,

                              ),
                              onPressed: () {
                                xx=true;
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          body: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,

                              children: [
                                SizedBox(height: 20,),
                                Container(
                                  padding: EdgeInsets.all(10.0),
                                  width: MediaQuery.of(context).size.width / 1.2,
                                  height: MediaQuery.of(context).size.width / 6,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white, width: 5),
                                      shape: BoxShape.rectangle,
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20)
                                  ),
                                  child: Center(
                                      child: Text(
                                        "Address",
                                        style: TextStyle(
                                            fontSize: 30,
                                            letterSpacing: 1.5,
                                            color: Color(0xff6CB9E7),
                                            fontFamily: "FONT1",
                                            fontWeight: FontWeight.w600),
                                      )),
                                ),

                                Form(
                                  key: formKey,
                                  child:padges[tabbarindex] ,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            fallback: (context) => Scaffold(
              body: MyLoading(),
            ),
          );
        },
      ),
    );
  }

  Widget textfield(
      {@required hintText,
        @required controllel,
        @required validator,
        @required prefixicon,

        @required Function onpressed,
     @required  bool enabled,

      }) {

    return Container(
      height: 80,
      child: Center(
        child: Material(

          elevation: 6,

          shadowColor: Color(0xff6CB9E7),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            height: 68,
            child: Center(
              child: TextFormField(

                enabled: enabled,

                validator: validator,
                controller: controllel,
                decoration: InputDecoration(

                    prefixIcon: prefixicon,
                    labelText: hintText,
                    labelStyle: TextStyle(
                      letterSpacing: 1,
                      color: Colors.black54,
                      fontSize: 18,


                    ),

                    // hintText: hintText,
                    hintStyle: TextStyle(
                      letterSpacing: 2,
                      color: defaultcolor,
                    ),
                    fillColor: Colors.white30,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),


                        borderSide: BorderSide.none)),

              ),
            ),
          ),
        ),
      ),
    );
  }

  Column add(state,context)
  {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [

        if (state is UpdateProfileLoadingState)
          LinearProgressIndicator(),
        Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          // margin: EdgeInsets.symmetric(horizontal: 10),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment:
              MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 25,
                ),
                textfield(

                  hintText: 'Name of your Location',
                  prefixicon: Icon(Icons.location_on),


                  controllel: currentpasswordcontroller,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "this must be not empty";
                    }
                    return null;
                  },
                  onpressed: null,
                  enabled: true,

                ),
                SizedBox(
                  height: 25,
                ),
                textfield(
                  hintText: 'City',
                  prefixicon: Icon(Icons.location_city),
                  controllel: newpasswordcontroller,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "this must be not empty";
                    }
                    return null;
                  },
                    onpressed: null,
                  enabled: true,
                ),
                SizedBox(
                  height: 25,
                ),
                textfield(
                  hintText: 'Region',
                  prefixicon: Icon(Icons.zoom_out_map),
                  controllel: confirmcontroller,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "this must be not empty";
                    }
                    return null;
                  },
                  onpressed: null,
                  enabled: true,
                ),
                SizedBox(
                  height: 25,
                ),
                textfield(

                  hintText: 'Street',
                  prefixicon: Icon(Icons.streetview),
                  controllel: streetcontroller,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "this must be not empty";
                    }
                    return null;
                  },
                    onpressed: null,
                  enabled: true,
                ),
                SizedBox(
                  height: 55,
                ),
                Container(
                  height: 50,
                  width: double.infinity,
                  child: RaisedButton(
                    onPressed: () {
                      if (formKey.currentState.validate()) {
                        AddressCubit.get(context).addUserAddress(name: currentpasswordcontroller.text, city: newpasswordcontroller.text, region: confirmcontroller.text, details: streetcontroller.text);


                      }
                    },
                    color: Color(0xff6CB9E7),
                    child: Center(
                      child: Text(
                        "Add",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          //fontFamily: "FONT1"
                        ),
                      ),
                    ),
                  ),
                ),


              ],
            ),
          ),
        )
      ],
    );
  }


  Widget delete(state,context)
  {
    deletecurrentpasswordcontroller.text=AddressCubit.get(context).getAddressModel.data.data[0].name;
    deletenewpasswordcontroller.text=AddressCubit.get(context).getAddressModel.data.data[0].city;
    deleteconfirmcontroller.text=AddressCubit.get(context).getAddressModel.data.data[0].region;
    deletestreetcontroller.text=AddressCubit.get(context).getAddressModel.data.data[0].details;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          if (state is UpdateProfileLoadingState)
            LinearProgressIndicator(),
          Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            // margin: EdgeInsets.symmetric(horizontal: 10),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment:
                MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  textfield(

                      hintText: 'Name of your Location',
                      prefixicon: Icon(Icons.location_on),



                      controllel: deletecurrentpasswordcontroller,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "this must be not empty";
                        }
                        return null;
                      },
                      enabled: false,
                      onpressed: null


                  ),
                  SizedBox(
                    height: 25,
                  ),
                  textfield(
                      hintText: 'City',
                      prefixicon: Icon(Icons.location_city),
                      controllel: deletenewpasswordcontroller,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "this must be not empty";
                        }
                        return null;
                      },
                      enabled: false,
                      onpressed: null
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  textfield(
                      hintText: 'Region',
                      prefixicon: Icon(Icons.zoom_out_map),
                      controllel: deleteconfirmcontroller,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "this must be not empty";
                        }
                        return null;
                      },
                      enabled: false,
                      onpressed: null
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  textfield(

                    hintText: 'Street',
                    prefixicon: Icon(Icons.streetview),
                    controllel: deletestreetcontroller,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "this must be not empty";
                      }
                      return null;
                    },
                    onpressed: null,
                    enabled: false,
                  ),
                  SizedBox(
                    height: 55,
                  ),

                  Container(
                    height: 50,
                    width: double.infinity,
                    child: RaisedButton(
                      onPressed: () {

                        if (formKey.currentState.validate()) {

                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.WARNING,
                            width: 340,
                            buttonsBorderRadius: BorderRadius.all(Radius.circular(2)),
                            headerAnimationLoop: false,
                            animType: AnimType.BOTTOMSLIDE,
                            title: 'INFO',
                            desc: 'Are you Sure Delete Your Address ...',
                            // showCloseIcon: true,
                            btnCancelOnPress: () {},
                            btnOkOnPress: () {
                              AddressCubit.get(context).deleteUserAddress(AddressCubit.get(context).addressId);
                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                                builder: (context)=>AddAddressScreen(true)),
                                    (Route<dynamic> route) => false,
                              );
                            },
                          )..show();


                        }
                      },
                      color: Colors.redAccent,
                      child: Center(
                        child: Text(
                          "Delete",
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
    );
  }

  var currentpasswordcontroller = TextEditingController();
  var newpasswordcontroller = TextEditingController();
  var confirmcontroller = TextEditingController();
  var streetcontroller = TextEditingController();


  Widget update(state,context,x)
  {

    if(xx)
    {
      currentpasswordcontroller.text=AddressCubit.get(context).getAddressModel.data.data[0].name;
      newpasswordcontroller.text=AddressCubit.get(context).getAddressModel.data.data[0].city;
      confirmcontroller.text=AddressCubit.get(context).getAddressModel.data.data[0].region;
      streetcontroller.text=AddressCubit.get(context).getAddressModel.data.data[0].details;
      xx=false;
      print("xxxxxxxxxxxxxxxxxx");

    }
     if (currentpasswordcontroller.text==null)
      {
        xx=true;
      }
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          if (state is UpdateProfileLoadingState)
            LinearProgressIndicator(),
          Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            // margin: EdgeInsets.symmetric(horizontal: 10),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment:
                MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  textfield(

                    hintText: 'Name of your Location',
                    prefixicon: Icon(Icons.location_on),
                    enabled: true,


                    controllel: currentpasswordcontroller,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "this must be not empty";
                      }
                      return null;
                    },
                    onpressed: null,


                  ),
                  SizedBox(
                    height: 25,
                  ),
                  textfield(
                    hintText: 'City',
                    prefixicon: Icon(Icons.location_city),
                    controllel: newpasswordcontroller,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "this must be not empty";
                      }
                      return null;
                    },
                    onpressed: null,
                    enabled: true,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  textfield(
                    hintText: 'Region',
                    prefixicon: Icon(Icons.zoom_out_map),
                    controllel: confirmcontroller,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "this must be not empty";
                      }
                      return null;
                    },
                    onpressed: null,
                    enabled: true,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  textfield(

                    hintText: 'Street',
                    prefixicon: Icon(Icons.streetview),
                    controllel: streetcontroller,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "this must be not empty";
                      }
                      return null;
                    },
                    onpressed: null,
                    enabled: true,
                  ),
                  SizedBox(
                    height: 55,
                  ),
                  Container(
                    height: 50,
                    width: double.infinity,
                    child: RaisedButton(
                      onPressed: () {
                        if (formKey.currentState.validate()) {
                          AddressCubit.get(context).changeUserAddress(name: currentpasswordcontroller.text, city: newpasswordcontroller.text, region: confirmcontroller.text, details: streetcontroller.text);

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
                  ),
                  SizedBox(
                    height: 15,
                  ),


                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}


