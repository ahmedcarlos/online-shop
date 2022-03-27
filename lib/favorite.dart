import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'favoriteNote.dart';
import 'utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';
class Favorite extends StatefulWidget {
  @override
  FavoriteState createState() {
    return FavoriteState();
  }
}
class FavoriteState extends State<Favorite> {
  void initState() {
    super.initState();
    updateListView();
  }
  DatabaseHelper databaseHelper =DatabaseHelper();
  List<Note> noteList;
  int count =0;
void updateListView(){
  final Future<Database> dbFuture=databaseHelper.initializeDatabase();
  dbFuture.then((database){
    Future<List<Note>> noteListFuture=databaseHelper.getNoteList();
    noteListFuture.then((noteList) {
      setState(() {
        this.noteList=noteList;
        this.count=noteList.length;
      });
    });
  });
}
  //orange color
  Color color=Color(0xFFFB9A6E);
  //index of bottomNavigationBar
  var value =0;
  @override
  Widget build(BuildContext context) {
    if(noteList==null){
      noteList=List<Note>();
    }
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            title:  Text('المفضلة',style:TextStyle(color: color,fontSize: 25,fontFamily: 'Almarai',),),
            centerTitle: true,
          ),
          body: Container(
            width: screenWidth,
            height: screenHeight,
child: ListView.builder(
padding: EdgeInsets.only(top: 20),
    itemCount: count,
    itemBuilder: (BuildContext context,int position) {
      return Center(
        child: SizedBox(
          width: screenWidth * .9,
          height: 200,
          child: Card(
            elevation: 3,
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Row(
                textDirection: TextDirection.rtl,
                children: <Widget>[
                  Expanded(
                    child: SizedBox(
                        height: 180,
                        child: Image.asset(
                          this.noteList[position].image, fit: BoxFit.fitHeight,)),
                  ),
                  Container(width: 8,),
                  Expanded(
                    child: Column(
                      textDirection: TextDirection.rtl,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Text(this.noteList[position].name, style: TextStyle(
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
                              Text(' :السعر', style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Almarai',
                              ),),
                              Container(width: 5,),
                              Text(this.noteList[position].price, style: TextStyle(
                                  fontSize: 15,
                                  color: color,
                                  fontFamily: 'Tajawal'
                              ),),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Row(
                            textDirection: TextDirection.rtl,
                            children: <Widget>[
                              Text(' :اللون', style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Almarai',
                              ),),
                              Container(width: 5,),
                              Text(this.noteList[position].color, style: TextStyle(
                                  fontSize: 15,
                                  color: color,
                                  fontFamily: 'Tajawal'
                              ),),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            width: 160,
                            child: RaisedButton(
                              elevation: 0,
                              color: color,
                              onPressed: () {},
                              child: Text('اضف الى العربة', style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontFamily: 'Almarai',),
                                textAlign: TextAlign.center,),
                            ),
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
      );
    }
),
          ),
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
                    icon: CircleAvatar(
                      backgroundColor: Colors.deepOrange.withOpacity(.5),
                      child: Icon(Icons.favorite,color: Colors.deepOrange,size: 35,),
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