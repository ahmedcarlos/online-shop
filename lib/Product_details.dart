import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'home.dart';
import 'dart:async';
import 'favoriteNote.dart';
import 'utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';
// ignore: must_be_immutable
class ProductDetails extends StatefulWidget {
  @override
  ProductDetailsState createState() {
    return ProductDetailsState();
  }
}
class ProductDetailsState extends State<ProductDetails> {
  void initState() {
    super.initState();
  }
  List<Note> noteList;
  int count=0;
  String _image="";
  String _name="";
  String _color="";
  String _price="";
  void updateListView(){
    final Future<Database> dbFuture=helper.initializeDatabase();
    dbFuture.then((database){
      Future<List<Note>> noteListFuture=helper.getNoteList();
      noteListFuture.then((noteList) {
        setState(() {
          this.noteList=noteList;
          this.count=noteList.length;
        });
      });
    });

  }
  void _save()async{
    setState(() {
      note.name=_name;
      note.image=_image;
      note.price=_price;
      note.color=_color;
    });
    int result;
    result =await helper.insertNote(note);
    if(result!=0){
      _showAlertDialod('status', 'Success');
    }
    else{
      _showAlertDialod('status', 'Problem');
    }
    updateListView();
  }
  void _delete()async{
    int result;
    result =await helper.deleteNote(note.id);
    if(result!=0){
      _showAlertDialod('status', 'Success');
    }
    else{
      _showAlertDialod('status', 'Problem');
    }
    updateListView();
  }
  void _showAlertDialod(String title ,String message){
    AlertDialog alertDialog =AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context,builder: (_)=>alertDialog);
  }
  //PageViewController
  final controller = PageController();
  // the orange color
  Color color=Color(0xFFF8875c);
  // to toggle the color of favorite Icon
  bool toggle=false;
  DatabaseHelper helper =DatabaseHelper();
  Note note;
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    ThemeData themeData=ThemeData(
      primaryColor:color,
    );
    return MaterialApp(
        theme: themeData,
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            actions: <Widget>[
              IconButton(
                icon:Icon( Icons.arrow_back,color: color,textDirection: TextDirection.rtl,size: 35,),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              ),
            ],
            elevation: 0,
            backgroundColor: Colors.white,
          ),
          body: Container(
            width: screenWidth,
            height: screenHeight,
            child: ListView(
              children: <Widget>[
                ////////////////////////
                // PageView and SmoothPageIndicator
                Padding(
                  padding: const EdgeInsets.only(left:40.0,right: 40),
                  child: SizedBox(
                    height: 200,
                    child: Material(
                      elevation: 3,
                      child: Stack(
                        children:<Widget>[
                          PageView(
                            controller: controller,
                            reverse: true,
                            children: <Widget>[
                              Image.asset(MyHomePage().createState().images,fit: BoxFit.fitWidth,),
                              Image.asset(MyHomePage().createState().images,fit: BoxFit.fitWidth,),
                              Image.asset(MyHomePage().createState().images,fit: BoxFit.fitWidth,),
                            ],
                          ),
                          Positioned(
                              bottom: 5,
                              child: Container(
                                width: screenWidth*.8,
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
                ),
                /////////////////////////////
                SizedBox(height: 15,),
                Divider(height: 2,color: color,),
                /////
                // Column of all Product details
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    textDirection:TextDirection.rtl,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(MyHomePage().createState().names,style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Almarai',
                        ),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
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
                                fontFamily:'Tajawal'
                            ),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          textDirection: TextDirection.rtl,
                          children: <Widget>[
                            Text(' :اللون',style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Almarai',
                            ),),
                            SizedBox(width: 15,),
                            Text('اسود',style: TextStyle(
                                fontSize: 15,
                                color: color,
                                fontFamily:'Tajawal'
                            ),),
                            SizedBox(width: 15,),
                            Text('احمر',style: TextStyle(
                                fontSize: 15,
                                fontFamily:'Tajawal'
                            ),),
                            SizedBox(width: 15,),
                            Text('ابيض',style: TextStyle(
                                fontSize: 15,
                                fontFamily:'Tajawal'
                            ),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: screenWidth,
                          child: Row(
                            textDirection: TextDirection.rtl,
                            children: <Widget>[
                              Expanded(
                                flex: 8,
                                child: RaisedButton(
                                  elevation: 0,
                                  color: color,
                                  onPressed: (){},
                                  child: Text('اضف الى العربة',style: TextStyle(color: Colors.white,fontSize:15,fontFamily: 'Almarai',),textAlign: TextAlign.center,),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: IconButton(
                                  icon: Icon(Icons.favorite,color: toggle?Colors.red:Colors.grey),
                                  onPressed: (){
                                    setState(() {
if(toggle){
  _delete();
}
else{
  _save();
}
                                      toggle=!toggle;
                                    });
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('التقيمات',style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Almarai',
                        ),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
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
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('التعليقات',style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Almarai',
                        ),),
                      ),
                      ListTile(
                        trailing: CircleAvatar(
                          child: Icon(Icons.person),
                          backgroundColor: Colors.grey,
                        ),
                        title: Text('اسم المعلق',style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Almarai',
                          color: color,
                        ),textAlign: TextAlign.right,),
                        subtitle:  Text('نص نص نص نص نص نص نص نص نص نص نص نص نص نص نص نص  ',style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Tajawal',
                        ),),
                      ),
                      SizedBox(height: 5,),
                      ListTile(
                        trailing: CircleAvatar(
                          backgroundColor: Colors.grey,
                          child: Icon(Icons.person),
                        ),
                        title: Text('اسم المعلق',style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Almarai',
                            color: color
                        ),textAlign: TextAlign.right,),
                        subtitle:  Text('نص نص نص نص نص نص نص نص نص نص نص نص نص نص نص نص نص ',style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Tajawal',
                        ),),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
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
          ),*/
        )
    );
  }

}