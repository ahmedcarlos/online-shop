import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class ShoppingCart extends StatefulWidget {
  @override
  ShoppingCartState createState() {
    return ShoppingCartState();
  }
}
class ShoppingCartState extends State<ShoppingCart> {
  // orange color
  Color color=Color(0xFFFB9A6E);
  //index of bottomNavigationBar
  var value =0;
  // product count
  var count=0;
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            title: Text('عربة التسوق',style: TextStyle(color: color,fontSize: 30,fontFamily: 'Almarai',),),
          ),
          body: Container(
            width: screenWidth,
            height: screenHeight,
            child:
            Column(
              children: <Widget>[
                Expanded(
                  flex: 7,
                  child: ListView(
                    padding: EdgeInsets.only(top: 20),
                    children: <Widget>[
                      // the shopping card product details
                      Center(
                        child: SizedBox(
                          width: screenWidth*.9,
                          height: 200,
                          child: Card(
                            elevation:3 ,
                            child: Padding(
                              padding:EdgeInsets.all(15.0),
                              child: Row(
                                textDirection: TextDirection.rtl,
                                children: <Widget>[
                                  Expanded(
                                    child: SizedBox(
                                        height: 180,
                                        child: Image.asset('images/8.jpg',fit:  BoxFit.fitHeight,)),
                                  ),
                                  Container(width: 8,),
                                  Expanded(
                                    child: Column(
                                      textDirection:TextDirection.rtl,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Expanded(
                                          child: Text('اسم المنتج',style: TextStyle(
                                              fontSize: 18,
                                            fontFamily: 'Almarai',
                                          ),),
                                          flex: 1,
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Row(
                                            textDirection: TextDirection.rtl,
                                            children: <Widget>[
                                              Text(' :السعر',style: TextStyle(
                                                  fontSize: 15,
                                                fontFamily: 'Almarai',
                                              ),),
                                              Container(width: 5,),
                                              Text('300جنيه',style: TextStyle(
                                                  fontSize: 15,
                                                  color: color,
                                                fontFamily:'Tajawal',
                                              ),),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Row(
                                            textDirection: TextDirection.rtl,
                                            children: <Widget>[
                                              Text(' :اللون',style: TextStyle(
                                                  fontSize: 15,
                                                fontFamily: 'Almarai',
                                              ),),
                                              Container(width: 5,),
                                              Text('اسود',style: TextStyle(
                                                  fontSize: 15,
                                                  color: color,
                                                fontFamily:'Tajawal',
                                              ),),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Row(
                                            textDirection: TextDirection.rtl,
                                            children: <Widget>[
                                              Text('الكمية : ',textDirection: TextDirection.rtl,style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: 'Almarai',
                                              ),textAlign: TextAlign.right,),
                                              SizedBox(
                                                width: 90,
                                                height: 50,
                                                child: Container(
                                                  color: Colors.grey[200],
                                                  child: Row(
                                                    textDirection: TextDirection.rtl,
                                                    children: <Widget>[
                                                      Expanded(child: Center(child: IconButton(icon: Icon(Icons.add,color: color,),
                                                      onPressed: (){
                                                        setState(() {
                                                          count++;
                                                        });
                                                      },
                                                      )),),
                                                      VerticalDivider(width: 1,),
                                                      Expanded(child: Center(child: Text('$count',textDirection: TextDirection.rtl,textAlign: TextAlign.center,style: TextStyle(color: Colors.black),)),),
                                                      VerticalDivider(width: 1,),
                                                      Expanded(child: Center(child: IconButton(icon: Icon(Icons.remove,color: color,),
                                                        onPressed: (){
                                                          setState(() {
                                                            if(count>=1)
                                                            count--;
                                                          });
                                                        },
                                                      )),),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      ////////////////////
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                      padding: EdgeInsets.all(20),
                      height: 144,
                      width: screenWidth,
                      child: Column(
                        textDirection: TextDirection.rtl,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            textDirection: TextDirection.rtl,
                            children: <Widget>[
                              Text(':المبلغ الكلي',style: TextStyle(fontFamily: 'Almarai',fontSize: 20),),
                              Container(width: 10,),
                              Text('300جنيه',style: TextStyle(fontSize: 18,color: color,fontFamily:'Tajawal',),)
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:18.0,right: 18,top: 10,bottom: 5),
                            child: ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                                child: RaisedButton(
                                  padding: EdgeInsets.only(top: 7,bottom: 7),
                                  color: color,
                                  textColor: Colors.white,
                                  child: Center(
                                    child: Text(
                                      'متابعة الدفع',
                                      style: TextStyle(
                                          fontFamily: 'Almarai', fontSize: 23),
                                    ),
                                  ),
                                  elevation: 1,
                                  onPressed: () {
                                  },
                                )),
                          )
                        ],
                      ),
                      decoration:BoxDecoration(
                          border: Border(
                              top: BorderSide(
                                  width: 1,
                                  color: Colors.black
                              ),
                              bottom: BorderSide(
                                  width: 1,
                                  color: color
                              )
                          )
                      )
                  ),
                ),
              ],
            ),
          ),
          /////////////////////////////////////
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
                    icon: CircleAvatar(
                      backgroundColor: Colors.deepOrange.withOpacity(.5),
                      child: Icon(Icons.local_grocery_store,color: Colors.deepOrange,size: 35,),
                    ),
                    title: Text('')
                ),
                BottomNavigationBarItem(
                    icon: IconButton(icon: Icon(Icons.favorite,color:color,size: 35,),
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
                    icon: IconButton(icon: Icon(Icons.person,color: color,size: 35,),
                      onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>LoginPage(),
                        ));
                      },
                    ),
                    title: Text('')
                ),
              ],
            ),
          ),
          */
        );
  }
}