import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

Widget formInput({String hint, IconData icon = null, Function validator, 
    bool isPhoneNumber = false,BuildContext context, data = null, String key = null,
    TextInputType keyboardType = TextInputType.text, bool isPassword = false, bool isLoginOrSignupInput = false}) {
    Color color=Color(0xFFFB9A6E);

    getTheBorder({Color color = Colors.transparent, double width = 0}) => OutlineInputBorder(
          borderRadius: BorderRadius.circular(17.5),
          borderSide: BorderSide(width: width, color: color),
        );
    return TextFormField(
        validator: (s) {
          return validator(s);
        },
        onSaved: (val) {
          if (data !=null) data[key] = val;
        },
        textAlign: isPhoneNumber ? TextAlign.left : TextAlign.right,
        textDirection: isPhoneNumber ? TextDirection.ltr : TextDirection.rtl,
        obscureText: isPassword,
        decoration: InputDecoration(
          
          hintText: hint,
          hintStyle: TextStyle(
            color:  Colors.grey.withOpacity(0.5),
            fontSize: 16,
            fontFamily: 'Almarai',
          ),
          fillColor: Color.fromRGBO(245, 245, 245, 1),
          filled: true,
          border: isPhoneNumber || !isLoginOrSignupInput ? getTheBorder(width: 2, color: color) : getTheBorder(),
          enabledBorder: isPhoneNumber || !isLoginOrSignupInput ? getTheBorder(width: 2, color: color) : getTheBorder(),
          focusedBorder: getTheBorder(width: 2, color: color),
          errorBorder: getTheBorder(width:2, color: Color.fromRGBO(242, 53, 36,1)),
          suffixIcon: Icon(icon, color:  color,),
          contentPadding: isPhoneNumber ? EdgeInsets.only(top:0,bottom: 0) : EdgeInsets.all(5),
          prefixIcon: isPhoneNumber ? 
            ClipRRect(
              borderRadius: BorderRadius.only(bottomLeft:Radius.circular(17.5),topLeft:Radius.circular(17.5)),
              child: Container(
                margin: EdgeInsets.only(right:10),
                width:60,
                decoration: BoxDecoration(
                  color:color,
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
            ) : null,
          errorStyle: TextStyle(
            fontFamily: 'Almarai',
          )
        ),
        keyboardType: isPhoneNumber ? TextInputType.number : keyboardType,
          inputFormatters: (keyboardType == TextInputType.number || isPhoneNumber) ? <TextInputFormatter>[
            WhitelistingTextInputFormatter.digitsOnly,
          ] : [],
      );
  }