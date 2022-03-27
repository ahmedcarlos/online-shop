import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shop/account_adjustment.dart';
import 'package:shop/code-verify.dart';
import 'package:shop/services/user.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'login.dart';
import 'favorite.dart';
import 'shopping_cart.dart';
import 'Product_details.dart';
import 'completedRequests.dart';
import 'package:http/http.dart' as http;
import 'package:shop/services/fetch.dart';
// ignore: must_be_immutable
class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> with TickerProviderStateMixin {
  Color color=Color(0xFFFB9A6E);
  TabController controller;
  final page = [
    {
      "icon":Icons.shopping_basket,
    },
    {
      "icon": Icons.shopping_cart,
    },
    {
      "icon": Icons.favorite,
    },
    {
      "icon": Icons.home,
    },
    {
      "icon": Icons.person,
    },
  ];

  List<Widget> pages =  [
    CompletedRequests(),
    ShoppingCart(),
    Favorite(),
    MyHomePage(),
    LoginPage(),
  ];

  @override
  void initState() {
    super.initState();
    controller = TabController(length: page.length, vsync: this,initialIndex: 3);
    User.storage.ready.then((_){
      if (User.checkIfExis()) {
        setState(() {
          pages[pages.length - 1] = User.user.activited ? AccountAdjustment() : CodeVerifiyPage();
          print(pages);
        });
      }
    });
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
          // ignore: missing_return
          onWillPop: () {
            if (Platform.isAndroid) User.exitApp(context);
          },
          child: DefaultTabController(
          length: page.length,
          child: Scaffold(
            body: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: controller,
              children: List.generate(
                5,
                (index) => pages[index],
              ),
            ),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                  border: Border(top: BorderSide(width:3, color:color))
              ),
              child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  onTap: (int index) {
                    setState(() {
                      controller.animateTo(index, duration: Duration(milliseconds: 1));
                    });
                  },
                  elevation: 0,
                  items: (page.map((p)=>
                      BottomNavigationBarItem(
                          icon: CircleAvatar(
                              backgroundColor: controller.index == page.indexOf(p) ?  color.withOpacity(0.3) : Colors.transparent,
                              child: Icon(p['icon'],color:color,size: 30,)
                          ),
                          title: Container()
                      )).toList())
              ),
            ),
        ),
      ),
    );
  }

}
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
@override
  void initState(){
super.initState();
}
  //to send the image to Product_details
 static String image='images/6.jpg';
static String name='اسم المنتج';
String names=getName();
  String images=getImage();
  //to toggle show and not show in drawer
  bool toggle1=false;
  bool toggle2=false;
  bool toggle3=false;
  bool toggle4=false;
  //orange colors
  Color color=Color(0xFFFB9A6E);
  // index in bottomNavigationBar
  int value=0;
  //to open endDrawer
  GlobalKey<ScaffoldState> _globalKey=GlobalKey<ScaffoldState>();
  //PageViewController
  final controller = PageController();
  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return  Scaffold(
          backgroundColor: Colors.white,
        key: _globalKey,
          endDrawer:getDrawer(),
    appBar: AppBar(
      title: Text('متجري',style: TextStyle(color:color,fontFamily:'Almarai',fontSize: 30),),
      centerTitle: true,
      backgroundColor: Colors.white,
elevation: 0,
      actions: <Widget>[
        IconButton(
            onPressed: (){
              setState(() {
                _globalKey.currentState.openEndDrawer();
              });
            },
            icon: Icon(Icons.sort,color:color,textDirection: TextDirection.rtl,size: 35,))
      ],
    ),
    body: Container(
    width: width,
    height: height,
      child: ListView(
children: <Widget>[
  //search par
  Padding(
    padding: const EdgeInsets.only(left:30,right:30,bottom: 10),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: SizedBox(
        width: 50,
        height: 40,
        child: Center(
          child: TextField(
            cursorColor: Colors.grey,
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(17.5),
                  borderSide: BorderSide(width: 0,color: Colors.transparent)
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(17.5),
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
      ),),),
  ///////////////////////////////
  //PageView and theSmoothPageIndicator
  SizedBox(
    height: 140,
    child: Material(
      elevation: 3,
      child: Stack(
        children:<Widget>[
          PageView(
            controller: controller,
            reverse: true,
            children: <Widget>[
              Image.asset("images/1.jpg",fit: BoxFit.fill,),
              Image.asset("images/2.jpg",fit: BoxFit.fill,),
              Image.asset("images/3.jpg",fit: BoxFit.fill,),
            ],
          ),
          Positioned(
              bottom: 5,
              child: Container(
                width: width,
                child: Center(
                  child: SmoothPageIndicator(
                    textDirection: TextDirection.rtl,
                    controller: controller,  // PageController
                    count:  3,
                    effect:  WormEffect(
                      dotColor:  Colors.white,
                      activeDotColor: color,
                      paintStyle: PaintingStyle.fill,
                    ),  // your preferred effect
                  ),
                ),
              )
          )
        ],
      ),
    ),
  ),
  ////////////////////////
  SizedBox(height: 15,),
  Text('الاكثر مبيعا',
    textAlign: TextAlign.right,
    style:TextStyle(
      fontFamily: 'Almarai',
    fontSize: 22
    ),),
  SizedBox(height: 15,),
  ///////////////////////
  //horizontal ListView.builder
  SizedBox(
    height: 281,
    child: Padding(
      padding: EdgeInsets.all(3.0),
      child: ListView.builder(
          reverse: true,
          scrollDirection: Axis.horizontal,
          itemCount: 3,
          itemBuilder: (BuildContext context,int position) {
            return GestureDetector(child: getProduct("images/8.jpg",name),
            onTap: (){
              setState(() {
                image="images/8.jpg";
                name="اسم المنتج";
              });
              Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) =>ProductDetails(),
              ));
            },
            );
          }),
    ),
  ),
  ////////////////////////
  SizedBox(height: 20,),
  ListTile(
    leading: Text('المزيد',
      style:TextStyle(
          fontFamily:'Tajawal',
          fontSize: 18,
          color: color
      ),
    ),
    trailing: Text('اثاث ومستللزمات المنزل',
      textDirection: TextDirection.rtl,
      style:TextStyle(
          fontFamily: 'Almarai',
          fontSize: 22
      ),),
  ),
    ////////////////////////
  // horizontal ListView.builder
    SizedBox(
      height: 281,
      child: Padding(
        padding: EdgeInsets.all(3.0),
        child: ListView.builder(
          reverse: true,
          scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (BuildContext context,int position){
        return GestureDetector(child: getProduct('images/6.jpg',name),
          onTap: (){
            setState(() {
             image='images/6.jpg';
             name="اسم المنتج";
            });
            Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) =>ProductDetails(),
            ));
          },);
        }),
      ),
    ),
  /////////////////
  SizedBox(height: 20,),
  ListTile(
    leading: Text('المزيد',
      style:TextStyle(
          fontFamily:'Tajawal',
          fontSize: 18,
          color: color
      ),
    ),
    trailing: Text('وصل حديثا',
      textDirection: TextDirection.rtl,
      style:TextStyle(
          fontFamily: 'Almarai',
          fontSize: 22
      ),),
  ),
  ////////////////////
  // horizontal ListView.builder
  SizedBox(
    height: 281,
    child: Padding(
      padding: EdgeInsets.all(3.0),
      child: ListView.builder(
          reverse: true,
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (BuildContext context,int position){
            return GestureDetector(child: getProduct('images/13.jpg',name),  onTap: (){
              setState(() {
                image='images/13.jpg';
                name="اسم المنتج";
              });
              Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) =>ProductDetails(),
              ));
            },);
          }),
    ),
  ),
  /////////////end of ListView
],
      ),
    ),
          ///////////////////////
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
                    icon: CircleAvatar(
                      backgroundColor: Colors.deepOrange.withOpacity(.5),
                      child: Icon(Icons.home,color: Colors.deepOrange,size: 35,),
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
          /////////////////
        );
  }//end of build Widget
  //getProduct
  Widget getProduct(String image,String name){
    return Padding(
      padding: EdgeInsets.only(left:8.0,right: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: SizedBox(
          width: 150,
          height: 220,
          child: Container(
            decoration: BoxDecoration(
              border:Border(
                  top: BorderSide(
                    width: 1,
                    color: Colors.grey,
                  ),
                left: BorderSide(
                width: 1,
                color: Colors.grey,
              ),
                  right: BorderSide(
                    width: 1,
                    color: Colors.grey,
                  )
              )
            ),
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
                width: 150,
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
        ),
      ),
    );
  }
  static getImage()=>image;
static getName()=>name;
  //getEndDrawer
  Drawer getDrawer(){
    return  Drawer(
      child: ListView(
        children: <Widget>[
          ListTile(
            title: Text('التصنيفات',textAlign: TextAlign.right,style: TextStyle(fontFamily: 'Almarai'),),
          ),
          Container(
            color: Color.fromRGBO(254, 232, 224, 1),
            child:   ListTile(
              title: Text('اثاث ومستلزمات المنزل',textAlign: TextAlign.right,style: TextStyle(fontFamily: 'Almarai'),),
              leading: IconButton(
                onPressed: (){
                  setState(() {toggle1=!toggle1;});
                },
                icon: toggle1?Icon(Icons.arrow_drop_up,color: color,size: 40,):Icon(Icons.arrow_drop_down,color: color,size: 40,),
              ),
            ),
          ),
          Container(
            child: toggle1?getType():Container(height: 5,),
          ),
          Container(
            color: Color.fromRGBO(254, 232, 224, 1),
            child: ListTile(
              title: Text('الملابس ',textAlign: TextAlign.right,style: TextStyle(fontFamily: 'Almarai'),),
              leading: IconButton(
                onPressed: (){
                  setState(() {toggle2=!toggle2;});
                },
                icon: toggle2?Icon(Icons.arrow_drop_up,color: color,size: 40,):Icon(Icons.arrow_drop_down,color: color,size: 40,),
              ),
            ),
          ),
          Container(child: toggle2?getType():Container(height: 5,),),
          Container(
            color:Color.fromRGBO(254, 232, 224, 1),
            child: ListTile(
              title: Text('الاحزية',textAlign: TextAlign.right,style: TextStyle(fontFamily: 'Almarai'),),
              leading: IconButton(
                onPressed: (){
                  setState(() {toggle3=!toggle3;});
                },
                icon: toggle3?Icon(Icons.arrow_drop_up,color: color,size: 40,):Icon(Icons.arrow_drop_down,color: color,size: 40,),
              ),
            ),
          ),
          Container(child: toggle3?getType():Container(height: 5,),),
          Container(
            color: Color.fromRGBO(254, 232, 224, 1),
            child: ListTile(
              title: Text('الالكترونيات',textAlign: TextAlign.right,style: TextStyle(fontFamily: 'Almarai'),),
              leading: IconButton(
                onPressed: (){
                  setState(() {toggle4=!toggle4;});
                },
                icon: toggle4?Icon(Icons.arrow_drop_up,color: color,size: 40,):Icon(Icons.arrow_drop_down,color: color,size: 40,),
              ),
            ),
          ),
          Container(child:toggle4?getType():Container(),),
        ],
      ),
    );
  }
  //the type od product in EndDrawer
  Widget getType(){
    return Column(
      children: <Widget>[
        ListTile(title: Text('النوع الاول',textAlign: TextAlign.right,style: TextStyle(color: Colors.grey,fontFamily: 'Tajawal'),),),
        ListTile(title: Text('النوع الاول',textAlign: TextAlign.right,style: TextStyle(color: Colors.grey,fontFamily: 'Tajawal'),),),
        ListTile(title: Text('النوع الاول',textAlign: TextAlign.right,style: TextStyle(color: Colors.grey,fontFamily: 'Tajawal'),),),
      ],
    );
  }
}//end of state class