import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop/services/fetch.dart';
import 'package:shop/services/user.dart';
import 'package:shop/widgets.dart';
import 'package:http/http.dart' as http;
import 'code-verify.dart';
class CreateAccount extends StatefulWidget {
  @override
  CreateAccountState createState() {
    return CreateAccountState();
  }
}
class CreateAccountState extends State<CreateAccount> {

  //Controller of all text field to validator on submit
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmationController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  // the currencies
  var _currencies = ['الخرطوم', 'الجزيرة', 'سنار'];
  // the first currencies
  CityItem selectedCity;
  //orange color
  Color color=Color(0xFFFB9A6E);
  // GlobalKey of form
  var _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();

  bool loading = false;
  var data = {
    "name": "",
    "email": "",
    "phone": "",
    "city_id": "",
    "password": "",
  };
  bool _phoneUsedError = false;
  bool _emailUsedError = false;

  @override
  void initState() {
    super.initState();
    if (CityItem.lists.length < 1)
    getCitys();
  }

  void getCitys() async {
    var citysResp = await get("citys");
    print(citysResp);
    if (citysResp['success'] == true) {
      setState(() {
        (citysResp['data'] as List).forEach((city) {
          CityItem.lists.add(CityItem(
            id: city['id'],
            name: city['name'],
          ));
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width/17;
    var screenHeight = MediaQuery.of(context).size.height/20;
    ThemeData themeData=ThemeData(
      primaryColor: color,
    );
    return MaterialApp(
      theme: themeData,
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          key: _scaffold,
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0.0,
              backgroundColor: Colors.white,
              centerTitle: true,
              title: Text(
                'انشاء حساب جديد',
                style: TextStyle(
                    color: color,
                    fontFamily: 'Almarai',
                    fontSize: 25),
              ),
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: color,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )),
          body: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                //userName TextField
                Padding(
                    padding: EdgeInsets.only(
                        top: screenHeight,
                        left: screenWidth,
                        right: screenWidth),
                    child: formInput(
                      isLoginOrSignupInput: true,
                        hint: "الإسم",
                        icon: Icons.person,
                        // ignore: missing_return
                        validator: (String v) {
                          if (v == "") return "مطلوب";
                          if (v.length < 4) return 'يجب أن لا يقل الإسم عن ٤ حروف';
                          if (v.length > 45) return 'يجب أن لا يزيد الإسم عن ٤٥ حروف';
                          if (RegExp(r'[!@#<>?":_`~/;[\]\\|=+)(*&^%0-9-]').hasMatch(v)) return "غير صالح";
                        },
                        data: data,
                        key: "name"
                    )),
                //////////////////
                // password TextField
                Padding(
                    padding: EdgeInsets.only(
                        top: screenHeight,
                        left: screenWidth,
                        right: screenWidth),
                    child: formInput(
                      isLoginOrSignupInput: true,
                        hint: "كلمة السر",
                        icon: Icons.lock,
                        // ignore: missing_return
                        validator: (String v) {
                          if (v == "") return "مطلوب";
                          if (v.length < 8) return "يجب أن لا تقل عن ٨ رمز";
                        },
                        data: data,
                        key: "password",
                        isPassword: true
                    )),
                ///////////////////
                // passwordConfirmation TextField
                Padding(
                    padding: EdgeInsets.only(
                        top: screenHeight,
                        left: screenWidth,
                        right: screenWidth),
                    child: formInput(
                      isLoginOrSignupInput: true,
                        hint: "تأكيد كلمة السر",
                        icon: Icons.lock,
                        // ignore: missing_return
                        validator: (String v) {
                          if (v == "") return "مطلوب";
                          if (v!= data['password']) return "غير متطابقة";
                        },
                        isPassword: true
                    )),
                //////////////
                // email TextField
                Padding(
                    padding: EdgeInsets.only(
                        top: screenHeight,
                        left: screenWidth,
                        right: screenWidth),
                    child: formInput(
                      isLoginOrSignupInput: true,
                        hint: "البريد الإلكتروني",
                        icon: Icons.email,
                        // ignore: missing_return
                        validator: (String v) {
                          if (v != "" && !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(v)) return 'غير صالح';
                          if (_emailUsedError == true) return "يوجد حساب مسبقاً بهذا الإيميل";
                        },
                        data: data,
                        key: "email",
                    )),
                ///////////
                // phoneNumber TextField
                Padding(
                    padding: EdgeInsets.only(
                        top: screenHeight,
                        left: screenWidth,
                        right: screenWidth),
                    child: formInput(
                      isLoginOrSignupInput: true,
                        hint: "XXXXXXXXXX",
                        icon: Icons.phone,
                        // ignore: missing_return
                        validator: (String v) {
                          if (v == "") return "مطلوب";
                          if (v.length != 9) return "يجب أن يتكون رقم الهاتف من ٩ أرقام";
                          if (_phoneUsedError == true) return "يوجد حساب مسبقاً بهذا الرقم";
                        },
                        isPhoneNumber: true,
                        data: data,
                        key: "phone"
                    )),
                /////////////////////////
                //DropdownButton
                Padding(
                    padding: EdgeInsets.only(
                        top: screenHeight,
                        left: screenWidth,
                        right: screenWidth),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        // color: Color.fromRGBO(252, 196, 173, 1),
                        child: Center(
                          child: DropdownButtonFormField<CityItem>(
                            elevation: 0,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color.fromRGBO(252, 196, 173, 1),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide.none
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(17.5),
                                borderSide: BorderSide(width: 2, color: Color.fromRGBO(242, 53, 36,1)),
                              ),
                              suffixIcon: Icon(Icons.add_location,color:color,),
                              prefixIcon: Icon(Icons.arrow_drop_down,color: Colors.white70,size: 55,)
                            ),
                            iconEnabledColor:color,
                            isExpanded: true,
                            validator: (CityItem val) {
                              if (val == null) return "مطلوب";
                            },
                            icon: Icon(Icons.add_location,color: color,size: 0,),
                            items: CityItem.lists.map((CityItem value) {
                              return DropdownMenuItem<CityItem>(
                                value: value,
                                child: Row(textDirection: TextDirection.rtl,
                                  children: <Widget>[
                                    Text(value.name,textDirection: TextDirection.rtl,style: TextStyle(fontFamily:'Tajawal',),),
                                  ],
                                ),
                              );
                            }).toList(),
                            value: selectedCity,
                            onChanged: (CityItem newValueSelected) {
                              setState(() {
                                selectedCity = newValueSelected;
                                data['city_id'] = newValueSelected.id.toString();
                              });
                            },
                          ),
                        ),
                      ),
                    )),
                //////////////////
                // the validate Button
                Padding(
                    padding: EdgeInsets.only(
                        left: screenWidth,
                        right: screenWidth,
                      top: screenHeight
                   ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        child: RaisedButton(
                          padding: EdgeInsets.all(12),
                          color: color,
                          textColor: Colors.white,
                          child: Center(
                            child:loading ? CircularProgressIndicator() : Text(
                               'إنشاء الحساب',
                              style: TextStyle(
                                  fontFamily: 'Almarai', fontSize: 25),
                            ),
                          ),
                          elevation: 1,
                          onPressed: loading ? null : () {
                            setState(() {
                                _phoneUsedError = false;
                                _emailUsedError = false;
                            });
                              _formKey.currentState.save();
                              if (_formKey.currentState.validate()) {
                                signup();
                                setState(() {
                                    loading = true;
                                });
                              }
                          },
                        ))),
                SizedBox(height:20)
              ],
            ),
          ),
        )
    );
  }//end of build widget

    signup() async {
      print(data);
      var signupResponse = await post("auth/signup", data);
      print(signupResponse);
      setState(() {
        loading = false;
      });
      if (signupResponse['success'] == true) {
        var respData = signupResponse['data'];
          User.saveToken(respData['access_token'], false, respData['user']['phone'], respData['user']['id']);
          _scaffold.currentState.showSnackBar(SnackBar(
            content: Text("${signupResponse['data']['user']['v_code']}", textAlign: TextAlign.center,style: TextStyle(color:Colors.white,fontFamily: 'Almarai'),),
            backgroundColor: Color.fromRGBO(235,68,90, 1),
            duration: Duration(seconds: 5),
          ));
          Future.delayed(Duration(seconds: 5));
            Navigator.of(context).pop();
            Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) =>CodeVerifiyPage(),
            ));
          
      }
      else if (signupResponse['message'] != null) {
        _scaffold.currentState.showSnackBar(SnackBar(
          content: Text(signupResponse['message'], textAlign: TextAlign.center,style: TextStyle(color:Colors.white,fontFamily: 'Almarai'),),
          backgroundColor: Color.fromRGBO(235,68,90, 1),
          duration: Duration(milliseconds: 3000),
        ));
        if (signupResponse['message'] == "هذا الهاتف مستخدم بواسطة مستخدم آخر") setState(() {
          _phoneUsedError = true;
          _formKey.currentState.validate();
        });
        if (signupResponse['message'] == "هذا الإيميل مستخدم بواسطة مستخدم آخر") setState(() {
          _emailUsedError = true;
          _formKey.currentState.validate();
        });
      }
    }
  }//end of class

class CityItem {
  static List<CityItem> lists = [];
  int id;
  String name;
  CityItem({this.id, this.name});
}