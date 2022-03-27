import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop/code-verify.dart';
import 'package:shop/forget-password.dart';
import 'package:shop/home.dart';
import 'package:shop/services/fetch.dart';
import 'package:shop/services/user.dart';
import 'create_account.dart';
import 'account_adjustment.dart';
import 'package:shop/widgets.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  //orange color
  Color color=Color(0xFFFB9A6E);
  //   /toggle show and not show the password
  bool toggle1 =true;
  Icon icon1=Icon(Icons.visibility,color: Color(0xFFFB9A6E),);
  //Controller of all text field to validator on submit
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  //index of bottomNavigationBar
  var value=0;
  // GlobalKey of form
  var _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();

  bool loading = false;
  var data = {
    "phone": "",
    "password": ""
  };
  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return  Scaffold(
      key: _scaffold,
        backgroundColor: Colors.white,
          body: Container(
            width: width,
            height: height,
            child: Padding(
              padding: EdgeInsets.only(left: 20,right: 20,),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    // the title
                    Container(
                      width: width,
                      height: height*.3,
                      child: Center(
                        child: Text('متجري',
                          style: TextStyle(
                              fontSize: 100,
                              fontFamily: 'Almarai',
                              color: color),
                          textDirection: TextDirection.rtl,
                        ),
                      ),
                    ),
                    ////////
                    //email TextField
                    ClipRRect(
                      borderRadius: BorderRadius.circular(17.5),
                      child: Center(
                        child: formInput(
                            hint: "XXXXXXXXXX",
                            icon: Icons.phone,
                            // ignore: missing_return
                            validator: (String v) {
                              if (v == "") return "مطلوب";
                            },
                            isPhoneNumber: true,
                            data: data,
                            key: 'phone',
                        )
                      ),
                    ),
                    /////////////////
                    //password TextField
                    SizedBox(height: height*.02,),
                    Container(
                      height: height*.13,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(17.5),
                        child: Center(
                          child: formInput(
                            isLoginOrSignupInput: true,
                              hint: "كلمة السر",
                              icon: Icons.lock,
                              // ignore: missing_return
                              validator: (String v) {
                                if (v == "") return "مطلوب";
                              },
                              data: data,
                              key: 'password',
                              isPassword: true
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: height*.02,),
                    /////////////////////
                    // the validate Button
                    SizedBox(
                      width: width*.9,
                      height: 65,
                      child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          child: RaisedButton(
                            color: color,
                            textColor: Colors.white,
                            child: loading ? CircularProgressIndicator() : Text(
                              'تسجيل الدخول',
                              style: TextStyle(
                                  fontFamily: 'Almarai', fontSize: 30),
                            ),
                            elevation: 1,
                            onPressed: loading ? null : () {
                              setState(() {
                                _formKey.currentState.save();
                                if (_formKey.currentState.validate()) {
                                  loading = true;
                                  login();
                                }
                              });
                            },
                          )),
                    ),
                    //////////////
                    SizedBox(height: 25,),
                    SizedBox(
                      width: width*.9,
                      height: height*.05,
                      child: GestureDetector(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>ForgetPasswordPage(),
                          ));
                        },
                        child: Center(
                          child: Text('تغير كلمة السر',
                            textDirection: TextDirection.rtl,
                          style: TextStyle(
                              fontFamily:'Almarai',
                          ),),
                        ),
                      ),
                    ),
                    //////////////
                    SizedBox(
                      width: width*.9,
                      height: height*.05,
                      child: Center(
                        child: Text('أو',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                              fontFamily:'Almarai',
                            color: color
                          ),),
                      ),
                    ),
                    //////////////////////
                    SizedBox(
                      width: width*.9,
                      height: height*.05,
                      child: GestureDetector(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>CreateAccount(),
                          ));
                        },
                        child: Center(
                          child: Text('أنشاء حساب جديد',
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                                fontFamily:'Almarai',
                              decoration: TextDecoration.underline
                            ),),
                        ),
                      ),
                    ),
                    ///////////////
                  ],
                ),
              ),
            ),
          ),

          ////////////////
          //bottomNavigationBar
            /*
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(
                        width: 3,
                        color: color
                    )
                )
            ),
            child: BottomNavigationBar(
              currentIndex: value,
              onTap: (int value){
                setState(() {
                  this.value=value;
                });
              },
//selectedLabelStyle: TextStyle(color: Colors.blue),
              selectedFontSize: 0,
              showUnselectedLabels: false,
              showSelectedLabels: false,
              items:[
                BottomNavigationBarItem(
                    icon: IconButton(icon: Icon(Icons.local_grocery_store,color: color,size: 35,),
                      onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>ShoppingCart(),
                        ));
                      },
                    ),
                    title: Text('')
                ),
                BottomNavigationBarItem(
                    icon: IconButton(icon: Icon(Icons.favorite,color: color,size: 35,),
                      onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>Favorite(),
                        ));
                      },
                    ),
                    title: Text('')
                ),
                BottomNavigationBarItem(
                    icon: IconButton(icon: Icon(Icons.home,color: color,size: 35,),
                      onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>MyHomePage(),
                        ));
                      },
                    ),
                    title: Text('')
                ),
                BottomNavigationBarItem(
                    icon: CircleAvatar(
                      backgroundColor: Colors.deepOrange.withOpacity(.5),
                      child: Icon(Icons.person,color: Colors.deepOrange,size: 35,),
                    ),
                    title: Text('')
                ),
              ],

            ),
          ),
          */

        );
  }
  /*to toggle show and not show the password*/
  void togglePassword1() {
    if (toggle1) {
      toggle1 = false;
      icon1 = Icon(Icons.visibility_off);
    } else {
      toggle1 = true;
      icon1 = Icon(Icons.visibility);
    }
  }

  void login() async {
    print(data);
    final resp = await post("auth/login", data);
    setState(() {
      loading = false;
    });
    print('resp: ${resp}');
    if (resp['success'] == false) {
      _scaffold.currentState.showSnackBar(SnackBar(
        content: Text("معلومات التسجيل خاطئة", textAlign: TextAlign.center,style: TextStyle(color:Colors.white,fontFamily: 'Almarai'),),
        backgroundColor: Color.fromRGBO(235,68,90, 1),
        duration: Duration(milliseconds: 3000),
        
      ));
    }
    else {
      var respData = resp['data'];
      var userAccountIsActivited = respData['user']['v_code'] == null;
        User.saveToken(respData['access_token'], userAccountIsActivited, respData['user']['phone'], respData['user']['id']);
        if (!userAccountIsActivited) {
          Navigator.of(context).pop();
          Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) =>CodeVerifiyPage(),
          ));
        }
        else {
          Navigator.of(context).pop();
          Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) =>RootPage(),
          ));
        }
    }
  }
}