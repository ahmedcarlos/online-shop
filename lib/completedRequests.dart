import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop/requests_details.dart';
class CompletedRequests extends StatefulWidget {
  @override
  _CompletedRequestsState createState() => _CompletedRequestsState();
}

class _CompletedRequestsState extends State<CompletedRequests> {
  //orange colors
  Color color=Color(0xFFFB9A6E);
  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text('الطلبات المكتملة',textDirection: TextDirection.rtl,style: TextStyle(color: color,fontFamily:'Almarai',fontSize: 30),),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_forward,color: color,size: 30,),
            onPressed: (){
              Navigator.of(context).pop();
            },
          )
        ],
      ),
      body: Container(
        width: width,
        height: height,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20),
              child: GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) =>RequestsDetails(),
                  ));
                },
                child: Card(
                  elevation: 3,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                       textDirection: TextDirection.rtl,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('تم الطلب يوم 1/1/2020',textDirection: TextDirection.rtl,textAlign: TextAlign.right,style: TextStyle(color: color,fontFamily:'Almarai',fontSize: 20),),
                        SizedBox(height: 15,),
                        Row(
                          textDirection: TextDirection.rtl,
                          children: <Widget>[
                            Text('رقم الطلبية',textDirection: TextDirection.rtl,textAlign: TextAlign.right,style: TextStyle(fontFamily:'Almarai',fontSize: 20),),
                            SizedBox(width: 15,),
                            Text('40003',textDirection: TextDirection.rtl,textAlign: TextAlign.right,style: TextStyle(color: color,fontFamily:'Almarai',fontSize: 20),),
                          ],
                        ),
                        SizedBox(height: 15,),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                              children: <Widget>[
                                Image.asset('images/8.jpg',height: 100,),
                                SizedBox(height: 3,),
                                Text('اسم المنتج',textDirection: TextDirection.rtl,textAlign: TextAlign.right,style: TextStyle(fontFamily:'Almarai',fontSize: 20),),
                              ],
                            ),),
                            SizedBox(width: 5,),
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  Image.asset('images/8.jpg',height: 100,),
                                  SizedBox(height: 3,),
                                  Text('اسم المنتج',textDirection: TextDirection.rtl,textAlign: TextAlign.right,style: TextStyle(fontFamily:'Almarai',fontSize: 20),),
                                ],
                              ),),
                            SizedBox(width: 5,),
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  Image.asset('images/8.jpg',height: 100,),
                                  SizedBox(height: 3,),
                                  Text('اسم المنتج',textDirection: TextDirection.rtl,textAlign: TextAlign.right,style: TextStyle(fontFamily:'Almarai',fontSize: 20),),
                                ],
                              ),),
                          ],
                        ),
                        SizedBox(height: 15,),
                        Row(
                          children: <Widget>[
                            Text('تم التسليم',textDirection: TextDirection.rtl,textAlign: TextAlign.left,style: TextStyle(color: color,fontFamily:'Almarai',fontSize: 22),),
                          ],
                        ),
                      ],
                    ),
                  ),

                ),
              ),
            )
          ],
        ),
      ),

    );
  }
}
