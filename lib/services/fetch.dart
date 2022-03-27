//import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'dart:convert';
import 'package:shop/services/user.dart';
post(url, data) async {
  Map<String,String> headers = {
    'Content-type' : 'application/json', 
    'Accept': 'application/json',
  };
  if (User.user != null) {
    headers['Authorization'] = 'Bearer ${User.user.token}';
  }
  final http.Response response = await http.post("https://sust-software-shop.herokuapp.com/api/"+url,body:json.encode(data).toString(), headers:headers );
  var responseJson = json.decode(response.body.toString());
  return responseJson;
}
get(url) async {
  Map<String,String> headers = {
    'Content-type' : 'application/json', 
    'Accept': 'application/json',
  };
  if (User.user != null) {
    headers['Authorization'] = 'Bearer ${User.user.token}';
  }
  final http.Response response = await http.get("https://slati/api/"+url, headers:headers );
  var responseJson = json.decode(response.body.toString());
  return responseJson;
}
postWithFiles(url, data, List files) async {
  var uri = Uri.parse("https://sust-software-shop.herokuapp.com/api/${url}");
  // create multipart request
  var request = new http.MultipartRequest("POST", uri);
  for (var i=0;i<files.length;i++) {
    var stream = new http.ByteStream(DelegatingStream.typed(files[i]['file'].openRead()));
        // get file length
    var length = await files[i]['file'].length();
    var multipartFile = new http.MultipartFile(files[i]['name'], stream, length,
        filename: basename(files[i]['file'].path));
    // add file to multipart
    request.files.add(multipartFile);
  }

  // string to uri

  // multipart that takes file
  request.fields.addAll(data);
  request.headers.addAll({
    'Content-type' : 'application/json', 
    'Accept': 'application/json',
    'Authorization': 'Bearer ${User.user.token}'
  });
  // send
  var response = await request.send();
  return  response.stream.transform(utf8.decoder);
}
getBytes(url) {
    Map<String,String> headers = {
      'Content-type' : 'application/json', 
      'Accept': 'application/json',
    };
    if (User.user != null) {
      headers['Authorization'] = 'Bearer ${User.user.token}';
    }
   return http.get("https://sust-software-shop.herokuapp.com//api/$url", headers: headers);
}