import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop/services/user.dart';
class AccountAdjustment extends StatefulWidget {
  @override
  AccountAdjustmentState createState() {
    return AccountAdjustmentState();
  }
}
class AccountAdjustmentState extends State<AccountAdjustment> {
  //Controller of all text field to validator on submit
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmationController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  // the currencies
  var _currencies = ['الخرطوم', 'الجزيرة', 'سنار'];
  // the first currencies
  var name = 'الخرطوم';
  //orange color
  Color color=Color(0xFFFB9A6E);
  // GlobalKey of form
  var _formKey = GlobalKey<FormState>();
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
          backgroundColor: Colors.white,
          appBar: AppBar(
              elevation: 0.0,
              backgroundColor: Colors.white,
              centerTitle: true,
              title: Text(
                'تعديل الحساب',
                style: TextStyle(
                    color: color,
                    fontFamily: 'Almarai',
                    fontSize: 30),
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.settings_power,
                    color: color,
                  ),
                  onPressed: () {
                    User.logout(context);
                  },
                )
              ],
              ),
          body: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                //////////
                //userName TextField
                Padding(
                    padding: EdgeInsets.only(
                        top: screenHeight,
                        left: screenWidth,
                        right: screenWidth),
                    child: formInput(
                        hint: "الإسم",
                        icon: Icons.person,
                        // ignore: missing_return
                        validator: (String v) {
                          if (v == "") return "مطلوب";
                        }
                    )),
                //////////////////
                // password TextField
                Padding(
                    padding: EdgeInsets.only(
                        top: screenHeight,
                        left: screenWidth,
                        right: screenWidth),
                    child: formInput(
                        hint: "كلمة السر",
                        icon: Icons.lock,
                        // ignore: missing_return
                        validator: (String v) {
                          if (v == "") return "مطلوب";
                        }
                    )),
                ///////////////////
                // passwordConfirmation TextField
                Padding(
                    padding: EdgeInsets.only(
                        top: screenHeight,
                        left: screenWidth,
                        right: screenWidth),
                    child: formInput(
                        hint: "تأكيد كلمة السر",
                        icon: Icons.lock,
                        // ignore: missing_return
                        validator: (String v) {
                          if (v == "") return "مطلوب";
                        }
                    )),
                //////////////
                // email TextField
                Padding(
                    padding: EdgeInsets.only(
                        top: screenHeight,
                        left: screenWidth,
                        right: screenWidth),
                    child: formInput(
                        hint: "البريد الإلكتروني",
                        icon: Icons.email,
                        // ignore: missing_return
                        validator: (String v) {
                          if (v == "") return "مطلوب";
                        }
                    )),
                ///////////
                // phoneNumber TextField
                Padding(
                    padding: EdgeInsets.only(
                        top: screenHeight,
                        left: screenWidth,
                        right: screenWidth),
                    child: formInput(
                        hint: "XXXXXXXXXX",
                        icon: Icons.phone,
                        // ignore: missing_return
                        validator: (String v) {
                          if (v == "") return "مطلوب";
                        },
                        isPhoneNumber: true
                    )),
                /////////////////////////
                //DropdownButton
                Padding(
                    padding: EdgeInsets.only(
                        top: screenHeight,
                        left: screenWidth,
                        right: screenWidth),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(17.5),
                      child: Container(
                        color: Colors.deepOrangeAccent[100],
                        child: Center(
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none
                                ),
                                suffixIcon: Icon(Icons.add_location,color:color,),
                                prefixIcon: Icon(Icons.edit,color: Colors.white70,size: 40,)
                            ),

                            iconEnabledColor:color,
                            isExpanded: true,
                            icon: Icon(Icons.add_location,color: color,size: 0,),
                            items: _currencies.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Row(textDirection: TextDirection.rtl,
                                  children: <Widget>[
                                    Text(value,textDirection: TextDirection.rtl,style: TextStyle(fontFamily:'Tajawal',),),
                                  ],
                                ),
                              );
                            }).toList(),
                            value: name,
                            onChanged: (String newValueSelected) {
                              setState(() {
                                name = newValueSelected;
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
                        borderRadius: BorderRadius.all(Radius.circular(17.5)),
                        child: RaisedButton(
                          padding: EdgeInsets.all(12),
                          color: color,
                          textColor: Colors.white,
                          child: Center(
                            child: Text(
                              'تعديل',
                              style: TextStyle(
                                  fontFamily: 'Almarai', fontSize: 35),
                            ),
                          ),
                          elevation: 1,
                          onPressed: () {
                            setState(() {
                              if (_formKey.currentState.validate())
                                print('');
                            });
                          },
                        ))),
              ],
            ),
          ),
          ////////////////////////////////
          //bottomNavigationBar
          /*
          bottomNavigationBar: BottomNavigationBar(
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
                  icon: IconButton(icon: Icon(Icons.home,color:color,size: 35,),
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
          */
        )
    );
  }//end of build widget
  formInput({String hint, IconData icon =Icons.add_circle, Function validator, bool isPhoneNumber = false,}) {
    getTheBorder({Color color = Colors.transparent, double width = 0}) =>
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(17.5),
          borderSide: BorderSide(width: width, color: color),
        );
    return TextFormField(
        validator: (s) {
          return validator(s);
        },
        textAlign: isPhoneNumber ? TextAlign.left : TextAlign.right,
        textDirection: isPhoneNumber ? TextDirection.ltr : TextDirection.rtl,
        decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: Colors.grey.withOpacity(0.5),
              fontSize: 16,
              fontFamily: 'Almarai',
            ),
            fillColor: Color.fromRGBO(245, 245, 245, 1),
            filled: true,
            border: isPhoneNumber
                ? getTheBorder(width: 2, color: color)
                : getTheBorder(),
            enabledBorder: isPhoneNumber
                ? getTheBorder(width: 2, color: color)
                : getTheBorder(),
            focusedBorder: getTheBorder(width: 2, color: color),
            errorBorder: getTheBorder(
                width: 2, color: Color.fromRGBO(242, 53, 36, 1)),
            suffixIcon: Icon(
              icon, color: Color(0xFFFB9A6E),),
            contentPadding: isPhoneNumber
                ? EdgeInsets.only(top: 0, bottom: 0)
                : EdgeInsets.all(5),
            prefixIcon: isPhoneNumber ?
            ClipRRect(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(17.5),
                  topLeft: Radius.circular(17.5)),
              child: Container(
                margin: EdgeInsets.only(right: 10),
                width: 60,
                decoration: BoxDecoration(
                  color: color,
                  // Color.fromRGBO(254, 234, 226, 1)
                  border: Border(
                    top: BorderSide(width: 2, color: color),
                    left: BorderSide(width: 2, color: color),
                    bottom: BorderSide(width: 2, color: color),
                  ),
                  // borderRadius: BorderRadius.only(topLeft:Radius.circular(17.5),bottomLeft:Radius.circular(17.5)),
                ),
                alignment: Alignment.center,
                child: Text("+249", style: TextStyle(
                    color: Colors.white
                ),),
              ),
            ) : Icon(Icons.edit),
            errorStyle: TextStyle(
                fontFamily: 'Almarai',
                color: Color.fromRGBO(242, 53, 36, 1)
            )
        )
    );
  }
}//end of class
