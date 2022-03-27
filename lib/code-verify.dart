import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop/home.dart';
import 'package:shop/services/fetch.dart';
import 'package:shop/services/user.dart';
class CodeVerifiyPage extends StatefulWidget {
  @override
  _CodeVerifiyPageState createState() => _CodeVerifiyPageState();
}

class _CodeVerifiyPageState extends State<CodeVerifiyPage> {
  int timer = 120;
  String timerString = "2:00";
  DateTime lastSent = DateTime.now();
  String code = "";
  bool loading = false;
  GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();
  List<FocusNode> fieldsKeys = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];
  List<String> codes = ["","","","","",""];
  Color color=Color(0xFFFB9A6E);
  @override
  void initState() {
    super.initState();
    updateTimer();
  }


  void resenCode() async {
    var data = {"user_id": User.user.id};
    var response = await post("auth/code-resend", data);
    print(response);
  }

  void verifiyCode() async {
    var data = {"code":codes.join(""), "user_id": User.user.id};
    print(data);
    var response = await post("auth/code-v", data);
    print(response);
    if (response['success'] == true) {
        User.saveUserSingleData("activited", true);
        Navigator.of(context).pop();
        Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) =>RootPage(),
        ));
    }
    else if (response['message'] != null) {
      _scaffold.currentState.showSnackBar(SnackBar(
        content: Text(response['message'], textAlign: TextAlign.center,style: TextStyle(color:Colors.white,fontFamily: 'Almarai'),),
        backgroundColor: Color.fromRGBO(235,68,90, 1),
        duration: Duration(milliseconds: 3000),
      ));
      setState(() {
        loading = false;
        code = "";
      });
    }

    print(response);
  }
  

  
  void updateTimer() async {
    if (timer > 0)
      Future.delayed(Duration(seconds: 1)).then((s) {
        setState(() {
          timerString = _printDuration(Duration(seconds: timer));
          timer--;
          updateTimer();
        });
      });
  }

  String _printDuration(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  logout(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          titlePadding: EdgeInsets.all(0),
          title: Text("تسجيل الخروج"),
          content: Text("هل حقاً تريد تسجيل الخروج من حسابك؟"),
          actions: <Widget>[
            FlatButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text('إلغاء')),
            FlatButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text('تسجيل الخروج')),
          ],
        );

      }
      );
  }

  bool codeEntred() {
    for (var i = 0; i < codes.length; i++) 
      if (codes[i] == "") return false;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Theme(
      data: ThemeData(
        fontFamily: 'Almarai',
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          key: _scaffold,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: color,
                ),
                onPressed: () {
                  User.logout(context);
                }),
          ),
          body: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                 "تأكيد رقم الهاتف",
                  style: TextStyle(
                      fontSize: 22, color: color),
                ),
                SizedBox(height: 40),
                Text("تم إرسال كود التفعيل للرقم:",
                    style: TextStyle(fontSize: 20)),
                SizedBox(height: 15),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: "249${User.user?.phone}+ ",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      TextSpan(
                          text: "يرجى إدخاله أدناه  ",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontFamily: 'Almarai'))
                    ],
                  ),
                ),
                SizedBox(height: 50),
                Container(
                    width: double.infinity,
                    child: Center(
                      child: Container(
                        height: 100,
                        width: screenWidth,
                        child: Directionality(
                          textDirection: TextDirection.ltr,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              codeInput(
                                context:context,
                                width: (screenWidth * 0.8)*0.15,
                                index: 0
                              ),
                              codeInput(
                                context:context,
                                width: (screenWidth * 0.8)*0.15,
                                index: 1
                              ),
                              codeInput(
                                context:context,
                                width: (screenWidth * 0.8)*0.15,
                                index: 2
                              ),
                              codeInput(
                                context:context,
                                width: (screenWidth * 0.8)*0.15,
                                index: 3
                              ),
                              codeInput(
                                context:context,
                                width: (screenWidth * 0.8)*0.15,
                                index: 4
                              ),
                              codeInput(
                                context:context,
                                width: (screenWidth * 0.8)*0.15,
                                index: 5
                              ),
                            ],
                          ),
                        )
                      ),
                    )),
                timer > 0 ?
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(
                      fontFamily: 'Almarai',
                    ),
                    children: [
                      TextSpan(
                          text: "سيصل الكود خلال",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      TextSpan(
                          text: " $timerString",
                          style: TextStyle(
                              fontSize: 20,
                              color: color,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'Almarai'))
                    ],
                  ),
                )
                :
                Container()
                ,
                SizedBox(height: 30,),
                Container(
                  height: 70,
                  padding: EdgeInsets.symmetric(horizontal:20),
                  decoration: BoxDecoration(
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    child: RaisedButton(
                      color: color,
                      onPressed: (codeEntred() && !loading) ? () {
                        setState(() {
                          loading = true;
                          verifiyCode();
                        });
                      } : null,
                      child: loading ? CircularProgressIndicator() :Text(
                        "تأكيد",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                    ),
                  ),
                ),
                SizedBox(height:50),
                (
                  timer == 0 ?
                  GestureDetector(
                  onTap: () {
                    setState(() {
                      timer = 120;
                      timerString = "2:00";
                      updateTimer();
                      resenCode();
                    });
                  },
                  child: Text(
                    "إعادة إرسال الكود",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize:25,
                      color: color
                    ),
                )) : Container()
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container codeInput({BuildContext context, double width, int index}) {
    var theBorder =  OutlineInputBorder(
      borderSide: BorderSide(width:2,color:color)
    );
    return Container(
      width: width,
      child: TextField(
        focusNode: fieldsKeys[index],
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          border: theBorder,
          focusedBorder: theBorder,
          enabledBorder: theBorder,
          errorBorder: theBorder,
          counterText: "",
        ),
        onChanged: (val){
          setState(() {
            codes[index] = val;
          });
          if (val != "")
          fieldsKeys[index+1].requestFocus();
        },
        maxLength: 1,
        keyboardType: TextInputType.numberWithOptions(),
        inputFormatters: <TextInputFormatter>[
            WhitelistingTextInputFormatter.digitsOnly,
          ],
      ),
    );
  }
}
