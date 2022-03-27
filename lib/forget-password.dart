import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop/login.dart';
import 'package:shop/services/fetch.dart';
import 'package:shop/services/user.dart';
import 'package:shop/widgets.dart';


class ForgetPasswordPage extends StatefulWidget {
  @override
  _ForgetPasswordPageState createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();
  Color color=Color(0xFFFB9A6E);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Theme(
      data: ThemeData(
        fontFamily: 'Almarai',
        primaryColor: color,
      ),
      child: Scaffold(
        key: _scaffold,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Container(),
          actions: [IconButton(
              icon: Icon(
                Icons.arrow_forward,
                color: color,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              })],
        ),
        body: EnterPhoneScreen(screenWidth: screenWidth, scaffold: _scaffold, context:context),
      ),
    );
  }
}

class EnterPhoneScreen extends StatefulWidget {
  EnterPhoneScreen({
    Key key,
    @required this.screenWidth,
    @required this.scaffold,
    @required this.context,
  }) : super(key: key);

  final double screenWidth;
  final GlobalKey<ScaffoldState> scaffold;
  BuildContext context;

  @override
  _EnterPhoneScreenState createState() => _EnterPhoneScreenState();
}

class _EnterPhoneScreenState extends State<EnterPhoneScreen> {
  var _data = {
    'phone': "",
  };
  var _resetData = {
    'phone': "",
    'password': "",
    'password_confirmation': "",
    'code': "",
  };
  bool _saved = false; 
  bool _loading = false; 
  int screen = 1;
  GlobalKey<FormState> _form = GlobalKey<FormState>(); 
  GlobalKey<FormState> _resetForm = GlobalKey<FormState>(); 
  String phoneCode = "+249";
  Color color=Color(0xFFFB9A6E);

  void sendCode() async {
    print(_data);
    var response = await post("auth/request-change-password", _data);
    print(response);
    setState(() {
      _loading = false;
    });
    if (response['success'] == true) {
      _resetData['phone'] = _data['phone'];
      setState(() {
        screen = 2;
        _saved = false;
      });
      widget.scaffold.currentState.showSnackBar(SnackBar(
        content: Text("${response['data']['code']}", textAlign: TextAlign.center,style: TextStyle(color:Colors.white,fontFamily: 'Almarai'),),
        backgroundColor: Color.fromRGBO(235,68,90, 1),
      ));
    }
    else if (response['message'] != null) {
      widget.scaffold.currentState.showSnackBar(SnackBar(
        content: Text(response['message'], textAlign: TextAlign.center,style: TextStyle(color:Colors.white,fontFamily: 'Almarai'),),
        backgroundColor: Color.fromRGBO(235,68,90, 1),
        duration: Duration(milliseconds: 3000),
      ));
    }
    
  }

  void resetCode() async {
    print(_resetData);
    var response = await post("auth/change-password", _resetData);
    print("it is $response");
    if (response['success'] == true) {
      widget.scaffold.currentState.showSnackBar(SnackBar(
        content: Text("تم تغيير كلمة السر بنجاح", textAlign: TextAlign.center,style: TextStyle(color:Colors.white,fontFamily: 'Almarai'),),
        backgroundColor: Color.fromRGBO(45,211,111, 1),
        duration: Duration(seconds: 2),
      ));
      await Future.delayed(Duration(seconds: 2));
      Navigator.of(context).pop();
    }
    else if (response['message'] != null) {
      widget.scaffold.currentState.showSnackBar(SnackBar(
          content: Text(response['message'], textAlign: TextAlign.center,style: TextStyle(color:Colors.white,fontFamily: 'Almarai'),),
          backgroundColor: Color.fromRGBO(235,68,90, 1),
          duration: Duration(milliseconds: 3000),
        ));
    }
    setState(() {
      _loading = false;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Form(
        key: screen == 1 ? _form : _resetForm,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          
          children: (screen == 1 ? <Widget>[
            (
            formInput(context: widget.context, hint: "رقم الهاتف",
              validator: (val){
                if (val.length != 9) return "يجب أن يتكون رقم الهاتف من ٩ أرقام";
              }, data: _data, key: "phone",
              isPhoneNumber: true,
              icon: null
            )),
            SizedBox(height: 50,),
            Container(
              height: 60,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                child: RaisedButton(
                  color: color,
                  onPressed: (!_loading) ? () {
                   setState(() {
                      _saved = true;
                    });
                    _form.currentState.save();
                    if (_form.currentState.validate()) {
                      sendCode();
                      setState(() {
                        _loading = true;
                      });
                    }
                  } : null,
                  child: _loading ? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                  ) : Text(
                    "إرسال كود التفعيل",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
            )
          ]
          :
          [
             formInput(context: widget.context, data: _resetData, key: "code", validator: (val) {
              if (val == "") return 'مطلوب';
              if (val.length != 6) return 'غير صالح';
            }, keyboardType: TextInputType.number, hint: "الرمز", icon: Icons.confirmation_number),
            SizedBox(height: 20,),
            formInput( context: widget.context, data: _resetData, key: "password", validator: (val) {
              if (val == "") return 'مطلوب';
              if (val.length < 8) return 'يجب أن لا تقل كلمة السر عن ٨ حروف';
            }, icon: Icons.lock, hint: "كلمة السر الجديدة",isPassword: true),
            SizedBox(height: 20,),
            formInput(context: widget.context, data: _resetData, key: "password_confirmation", validator: (val) {
              if (val == "") return 'مطلوب';
              if (val != _resetData['password']) return 'غير متوافقة';
            }, icon: Icons.lock, hint: "تأكيد كلمة السر",isPassword: true),
            SizedBox(height: 50,),
            Container(
              height: 60,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                child: RaisedButton(
                  color: color,
                  onPressed: (!_loading) ? () {
                   setState(() {
                      _saved = true;
                    });
                    _resetForm.currentState.save();
                    if (_resetForm.currentState.validate()) {
                      resetCode();
                      setState(() {
                        _loading = true;
                      });
                    }
                  } : null,
                  child: _loading ? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                  ) : Text(
                    "إرسال كود التفعيل",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
            )
          ])..insertAll(0, [
            Text(
              "تغيير كلمة السر",
              style: TextStyle(
                  fontSize: 22, color: color),
              textDirection: TextDirection.rtl
            ),
            SizedBox(height: 20),
            Text("قم بكتابة رقم هاتفك المربوط بالحساب وسيتم إرسال كود مكون من ٦ أرقام لتغيير كلمة السر",
                style: TextStyle(fontSize: 20),textDirection: TextDirection.rtl,),            
            SizedBox(height: 50)
          ]),
        ),
      ),
    );
  }

}
