import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class RequestsDetails extends StatefulWidget {
  @override
  _RequestsDetailsState createState() => _RequestsDetailsState();
}

class _RequestsDetailsState extends State<RequestsDetails> {
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
        title: Text('تفاصيل الطلبات',textDirection: TextDirection.rtl,style: TextStyle(color: color,fontFamily:'Almarai',fontSize: 30),),
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
              child: Card(
                elevation: 3,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        children: <Widget>[
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
                                child: Row(
                                  textDirection: TextDirection.rtl,
                                  children: <Widget>[
                                    Image.asset('images/8.jpg',height: 100,),
                                    SizedBox(width: 10,),
                                    Column(
                                      textDirection: TextDirection.rtl,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text('اسم المنتج',textDirection: TextDirection.rtl,textAlign: TextAlign.right,style: TextStyle(fontFamily:'Almarai',fontSize: 20),),
                                        SizedBox(height: 10,),
                                        Row(
                                          textDirection: TextDirection.rtl,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text('الكمية : ',textDirection: TextDirection.rtl,textAlign: TextAlign.right,style: TextStyle(fontFamily:'Almarai',fontSize: 20),),
                                            SizedBox(width: 5,),
                                            Text('2',textDirection: TextDirection.rtl,textAlign: TextAlign.right,style: TextStyle(fontFamily:'Almarai',fontSize: 20,color: color),),
                                          ],
                                        ),
                                        SizedBox(height: 10,),
                                        Row(
                                          textDirection: TextDirection.rtl,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text('السعر : ',textDirection: TextDirection.rtl,textAlign: TextAlign.right,style: TextStyle(fontFamily:'Almarai',fontSize: 20),),
                                            SizedBox(width: 5,),
                                            Text('600 جنيه',textDirection: TextDirection.rtl,textAlign: TextAlign.right,style: TextStyle(fontFamily:'Almarai',fontSize: 20,color: color),),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),),
                              SizedBox(width: 5,),

                            ],
                          ),
                        ],
                      ),

                    ),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Row(
                                  textDirection: TextDirection.rtl,
                                  children: <Widget>[
                                    Image.asset('images/8.jpg',height: 100,),
                                    SizedBox(width: 10,),
                                    Column(
                                      textDirection: TextDirection.rtl,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text('اسم المنتج',textDirection: TextDirection.rtl,textAlign: TextAlign.right,style: TextStyle(fontFamily:'Almarai',fontSize: 20),),
                                        SizedBox(height: 10,),
                                        Row(
                                          textDirection: TextDirection.rtl,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text('الكمية : ',textDirection: TextDirection.rtl,textAlign: TextAlign.right,style: TextStyle(fontFamily:'Almarai',fontSize: 20),),
                                            SizedBox(width: 5,),
                                            Text('2',textDirection: TextDirection.rtl,textAlign: TextAlign.right,style: TextStyle(fontFamily:'Almarai',fontSize: 20,color: color),),
                                          ],
                                        ),
                                        SizedBox(height: 10,),
                                        Row(
                                          textDirection: TextDirection.rtl,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text('السعر : ',textDirection: TextDirection.rtl,textAlign: TextAlign.right,style: TextStyle(fontFamily:'Almarai',fontSize: 20),),
                                            SizedBox(width: 5,),
                                            Text('600 جنيه',textDirection: TextDirection.rtl,textAlign: TextAlign.right,style: TextStyle(fontFamily:'Almarai',fontSize: 20,color: color),),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),),
                              SizedBox(width: 5,),

                            ],
                          ),
                        ],
                      ),

                    ),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Row(
                                  textDirection: TextDirection.rtl,
                                  children: <Widget>[
                                    Image.asset('images/8.jpg',height: 100,),
                                    SizedBox(width: 10,),
                                    Column(
                                      textDirection: TextDirection.rtl,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text('اسم المنتج',textDirection: TextDirection.rtl,textAlign: TextAlign.right,style: TextStyle(fontFamily:'Almarai',fontSize: 20),),
                                        SizedBox(height: 10,),
                                        Row(
                                          textDirection: TextDirection.rtl,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text('الكمية : ',textDirection: TextDirection.rtl,textAlign: TextAlign.right,style: TextStyle(fontFamily:'Almarai',fontSize: 20),),
                                            SizedBox(width: 5,),
                                            Text('2',textDirection: TextDirection.rtl,textAlign: TextAlign.right,style: TextStyle(fontFamily:'Almarai',fontSize: 20,color: color),),
                                          ],
                                        ),
                                        SizedBox(height: 10,),
                                        Row(
                                          textDirection: TextDirection.rtl,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text('السعر : ',textDirection: TextDirection.rtl,textAlign: TextAlign.right,style: TextStyle(fontFamily:'Almarai',fontSize: 20),),
                                            SizedBox(width: 5,),
                                            Text('600 جنيه',textDirection: TextDirection.rtl,textAlign: TextAlign.right,style: TextStyle(fontFamily:'Almarai',fontSize: 20,color: color),),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),),
                              SizedBox(width: 5,),

                            ],
                          ),
                        ],
                      ),

                    ),
                  ],
                ),
              )
    ),
          ],
        ),
      ),

    );
  }
}
