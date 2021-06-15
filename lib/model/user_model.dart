import 'package:movie_app_vmo/database/database_app.dart';

class User{
String? userName ;
 String? userAvatar ;
String? userPassword ;
 int? userPhone;
 String? userMail ;
 User({this.userName,this.userAvatar,this.userPassword,this.userPhone,this.userMail});
Map<String,dynamic> toMap(){
  return {
    DatabaseMovie.USER_NAME: userName,
    DatabaseMovie.USER_AVATAR: userAvatar,
    DatabaseMovie.USER_PASSWORD:userPassword,
    DatabaseMovie.USER_PHONE: userPhone,
    DatabaseMovie.USER_MAIL:userMail,
  };
}
}