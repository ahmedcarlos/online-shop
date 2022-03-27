import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'requests_details.dart';
class PasswordChanged extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    //orange colors
    Color color=Color(0xFFFB9A6E);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: width*.9,
          height: height*.5,
          child: CircleAvatar(
            backgroundColor: color.withOpacity(.4),
            child: Padding(
              padding:  EdgeInsets.only(top: height*.19),
              child: Column(
                children: <Widget>[
                  Text('تم تغير كلمة السر',style: TextStyle(fontSize: 45,color:color,fontFamily:'Almarai',),textAlign: TextAlign.center,),
                  Container(height: 5,),
                  Icon(Icons.done,color: color,size: 150,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
