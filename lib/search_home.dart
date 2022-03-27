import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class SearchHomePage extends StatefulWidget {
  @override
  _SearchHomePageState createState() => _SearchHomePageState();
}
class _SearchHomePageState extends State<SearchHomePage> {
  @override
  void initState(){
    super.initState();
  }
  //to send the image to Product_details
  //to toggle show and not show in drawer
  bool toggle1=false;
  bool toggle2=false;
  bool toggle3=false;
  bool toggle4=false;
  bool toggle5=false;
  bool toggle6=false;
  bool toggle7=false;
  bool toggle8=false;
  //orange colors
  Color color=Color(0xFFFB9A6E);
  //to open endDrawer
  GlobalKey<ScaffoldState> _globalKey=GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return  Scaffold(
      backgroundColor: Colors.white,
      key: _globalKey,
      endDrawer:getDrawer(),
      body: Container(
        width: width,
        height: height,
        padding: EdgeInsets.only(top: 40,right: 20,left: 20,),
        child: ListView(
          children: <Widget>[
            //search par
            Row(
              children: <Widget>[
                Expanded(
                  flex: 8,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      height: 40,
                      child: Center(
                        child: TextField(
                          cursorColor: Colors.grey,
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.5),
                                borderSide: BorderSide(width: 0,color: Colors.transparent)
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.5),
                                borderSide: BorderSide(width: 0,color:Colors.transparent)
                            ),
                            filled: true,
                            fillColor: Color.fromRGBO(245, 245, 245, 1),
                            hintText:'عن ماذا تبحث',
                            hintStyle: TextStyle(fontFamily:'Tajawal'),
                            suffixIcon: IconButton(
                              padding: EdgeInsets.all(1),
                              onPressed: (){},
                              icon: Icon(Icons.search,),
                            ),),),
                      ),
                    ),),
                ),
                Expanded(
                  child:  IconButton(
                      onPressed: (){
                        setState(() {
                          _globalKey.currentState.openEndDrawer();
                        });
                      },
                      icon: Icon(Icons.dehaze,color:color,textDirection: TextDirection.rtl,size: 35,)),
                )
              ],
            ),
            ///////////////////////////////
            SizedBox(height: 15,),
            Text('عثرنا لى 50 منتج',
              textAlign: TextAlign.right,
              style:TextStyle(
                  fontFamily: 'Almarai',
                  fontSize: 22
              ),),
            SizedBox(height: 15,),
            ///////////////////////
            //horizontal ListView.builder
      Container(
        height: height-170,
        padding: EdgeInsets.only(right: 20,),
        child: GridView.count(
         // padding: EdgeInsets.all(10),
          crossAxisCount: 2,
          childAspectRatio: 16.0/25.0,
          children: <Widget>[
            getProduct('images/8.jpg', 'اسم المنتج'),
            getProduct('images/8.jpg', 'اسم المنتج'),
            getProduct('images/8.jpg', 'اسم المنتج'),
            getProduct('images/8.jpg', 'اسم المنتج'),
            getProduct('images/8.jpg', 'اسم المنتج'),
          ]
        ),
      )
            /////////////end of ListView
          ],
        ),
      ),
      /////////////////
    );
  }//end of build Widget
  //getProduct
  Widget getProduct(String image,String name){
    return SizedBox(
      width: 150,
      height: 220,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            SizedBox(child: Image.asset(image,fit: BoxFit.fill,),
              height: 120,
              width: 170,),
            SizedBox(height: 10,),
            SizedBox(
                height:34,
                child: Text(name,style: TextStyle(fontSize: 22,fontFamily: 'Almarai',),)),
            SizedBox(
                height: 24,
                child: Text('300 جنيه',style: TextStyle(color: color,fontFamily:'Tajawal'),)),
            SizedBox(
              height: 20,
              width: 150,
              child: Row(textDirection: TextDirection.rtl,
                children: <Widget>[
                  Icon(Icons.star,color: Colors.yellow,),
                  Icon(Icons.star,color: Colors.yellow,),
                  Icon(Icons.star,color: Colors.yellow,),
                  Icon(Icons.star,color: Colors.yellow,),
                  Icon(Icons.star,color: Colors.yellow,)
                ],
              ),
            ),
            SizedBox(height: 20,),
            SizedBox(
              height: 45,
              width: 170,
              child: GestureDetector(
                onTap: (){},
                child: Container(
                  color: color,
                  padding: EdgeInsets.all(5),
                  child: Text('اضف الى العربة',textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 19,fontFamily: 'Almarai',),),
                ),
              ),
            )

          ],),
      ),
    );
  }
  //getEndDrawer
  Drawer getDrawer(){
    return  Drawer(
      child: ListView(
        padding: EdgeInsets.only(top: 40),
        children: <Widget>[
          ListTile(
            title: Text('السعر',textAlign: TextAlign.right,style: TextStyle(fontFamily: 'Almarai',color:color),),
          ),
          ListTile(
            title: Text('من الأعلى الى الأدنى',textAlign: TextAlign.right,style: TextStyle(fontFamily: 'Tajawal',color: toggle1?color:Colors.black),),
         onTap: (){
              setState(() {
                toggle1=true;
                toggle2=false;
              });

         },
          ),
          ListTile(
            title: Text('من الأدنى الى الأعلى',textAlign: TextAlign.right,style: TextStyle(fontFamily: 'Tajawal',color: toggle2?color:Colors.black),),
          onTap: (){
              setState(() {
                toggle2=true;
                toggle1=false;
              });

          },
          ),
          ListTile(
            title: Text('القياس',textAlign: TextAlign.right,style: TextStyle(fontFamily: 'Almarai',color:color),),
          ),
          Row(
            textDirection: TextDirection.rtl,
            children: <Widget>[
              SizedBox(width: 15,),
              GestureDetector(
                  child: Text('XL',textAlign: TextAlign.right,style: TextStyle(fontFamily: 'Tajawal',color: toggle3?color:Colors.black),),
                onTap: (){
                  setState(() {
                    toggle3=true;
                    toggle4=false;
                    toggle5=false;
                  });
                },

              ),SizedBox(width: 15,),
              GestureDetector(
                  onTap: (){
                    setState(() {
                      toggle4=true;
                      toggle3=false;
                      toggle5=false;
                    });
                  },
                  child: Text('S',textAlign: TextAlign.right,style: TextStyle(fontFamily: 'Tajawal',color: toggle4?color:Colors.black),)),SizedBox(width: 15,),
              GestureDetector(
                  onTap: (){
                    setState(() {
                      toggle5=true;
                      toggle4=false;
                      toggle3=false;
                    });
                  },
                  child: Text('M',textAlign: TextAlign.right,style: TextStyle(fontFamily: 'Tajawal',color: toggle5?color:Colors.black),)),
            ],
          ),
          ListTile(
            title: Text('اللون',textAlign: TextAlign.right,style: TextStyle(fontFamily: 'Almarai',color:color),),
          ),
          Row(
            textDirection: TextDirection.rtl,
            children: <Widget>[
              SizedBox(width: 15,),
              GestureDetector(
                  onTap: (){
                    setState(() {
                      toggle6=true;
                      toggle7=false;
                      toggle8=false;
                    });
                  },
                  child: Text('احمر',textAlign: TextAlign.right,style: TextStyle(fontFamily: 'Tajawal',color: toggle6?color:Colors.black),)),SizedBox(width: 15,),
              GestureDetector(
                  onTap: (){
                    setState(() {
                      toggle7=true;
                      toggle6=false;
                      toggle8=false;
                    });
                  },
                  child: Text('ابيض',textAlign: TextAlign.right,style: TextStyle(fontFamily: 'Tajawal',color: toggle7?color:Colors.black),)),SizedBox(width: 15,),
              GestureDetector(
                  onTap: (){
                    setState(() {
                      toggle8=true;
                      toggle7=false;
                      toggle6=false;
                    });
                  },
                  child: Text('اسود',textAlign: TextAlign.right,style: TextStyle(fontFamily: 'Tajawal',color: toggle8?color:Colors.black),)),
            ],
          ),
          Padding(
              padding: EdgeInsets.only(
                  top: 70,
                left: 50,
                right: 50,
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(22)),
                  child: RaisedButton(
                    padding: EdgeInsets.all(12),
                    color: color,
                    textColor: Colors.white,
                    child: Center(
                      child:Text(
                        'تعيين',
                        style: TextStyle(
                            fontFamily: 'Almarai', fontSize: 25),
                      ),
                    ),
                    elevation: 1,
                    onPressed: (){}
                  ))),
        ],
      ),
    );
  }
}//end of state class