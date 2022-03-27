import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localstorage/localstorage.dart';
import 'package:shop/home.dart';
// import 'package:onesignal_flutter/onesignal_flutter.dart';
class User {
  static User user = null;
  static final LocalStorage storage = new LocalStorage('jesh_ehssan');
  String token;
  bool activited;
  String phone = "";
  num id;
  User({this.token, this.activited, this.phone, this.id});
  static bool checkIfExis() {
    String savedToken = User.storage.getItem("token");
    bool savedActivited = User.storage.getItem("activited");
    String savedPhone = User.storage.getItem("phone");
    int savedId = User.storage.getItem("user_id");
    if (savedToken != null)
    User.user = User(token:savedToken, activited:savedActivited, phone:savedPhone, id: (savedId));
    return savedToken != null;
  }

  static void saveToken(String token, bool activited, String phone, num user_id) {
    User.storage.setItem("token", token);
    User.storage.setItem("activited", activited);
    User.storage.setItem("phone", phone);
    User.storage.setItem("user_id", user_id);
    User.user = User(token:token, activited:activited, phone: phone, id: user_id);
    // OneSignal.shared.sendTag("role", role);
    // OneSignal.shared.sendTag("user_id", user_id);
  }

  static void deleteToken() {
    User.storage.setItem("token", null);
    // OneSignal.shared.deleteTag("role");
    User.user = null;
  }

  static void saveUserSingleData(String key, var value) {
    User.storage.setItem(key, value);
  }

  static void logout(context) {
  Color color=Color(0xFFFB9A6E);
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Theme(
        data:ThemeData(
          fontFamily: 'Almarai',
        ),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            title: Text("تسجيل الخروج"),
            content: Text("هل حقاً تريد تسجيل الخروج من حسابك؟"),
            actions: <Widget>[
              FlatButton(onPressed: (){
                Navigator.pop(context);
              }, child: Text('إلغاء', style: TextStyle(
                color: color
              ),)),
              FlatButton(onPressed: (){
                Navigator.pop(context);
                User.deleteToken();
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) =>RootPage(),
                ));            }, child: Text('تسجيل الخروج', style: TextStyle(
                  color: color
                ),)),
            ],
          ),
        ),
      );

    }
    );
  }

  static initOneSignal() async {
    // OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    // OneSignal.shared.init(
    //   "8de4e7cc-4abf-4f8d-a7c5-59913a5c50e7",
    //   iOSSettings: {
    //     OSiOSSettings.autoPrompt: false,
    //     OSiOSSettings.inAppLaunchUrl: false
    //   }
    // );
    // OneSignal.shared.setInFocusDisplayType(OSNotificationDisplayType.notification);

    // The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
    // await OneSignal.shared.promptUserForPushNotificationPermission(fallbackToSettings: true);
  }

  static void exitApp(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // titlePadding: EdgeInsets.all(0),
          title: Text(" الخروج من الطبيق"),
          content: Text("هل حقاً تريد الخروج  من التطبيق؟"),
          actions: <Widget>[
            FlatButton(onPressed: (){
              Navigator.pop(context);
            },
                child: Text('إلغاء')),
            FlatButton(onPressed: (){
                  SystemNavigator.pop();
            }, child: Text(' نعم')),
          ],
        );

      }
      );
  }
}