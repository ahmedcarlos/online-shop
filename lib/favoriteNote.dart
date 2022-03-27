class Note{
  int _id;
  String _image;
  String _name;
  String _color;
  String _price;
  Note(this._name,this._color,this._image,this._price);


  Note.withId(this._id,this._name,this._color,this._image,this._price);
  int get id=> _id;
  String get image=> _image;
  String get name=> _name;
  String get color=> _color;
  String get price=> _price;
  set image(String newImage){
    this._image=newImage;
  }
  set name(String newName){
    this._name=newName;
  }
  set color(String newColor){
    this._color=newColor;
  }
  set price(String newPrice){
    this._price=newPrice;
  }
  Map<String,dynamic> toMap(){
    var map =Map<String,dynamic>();
    if(id!=null){
      map['id']=_id;
    }
    map['image']=_image;
    map['name']=name;
    map['color']=_color;
    map['price']=_price;
  return map;
  }
  Note.fromMapObject(Map<String,dynamic>map){
    this._id=map['id'];
    this._image=map['color'];
    this._name=map['name'];
    this._price=map['price'];
  }
}