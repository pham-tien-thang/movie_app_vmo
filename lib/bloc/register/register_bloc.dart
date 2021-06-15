import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_vmo/common/toast.dart';
import 'package:movie_app_vmo/database/database_app.dart';
import 'package:movie_app_vmo/event/register/register_event.dart';
import 'package:movie_app_vmo/model/user_model.dart';
import 'package:movie_app_vmo/state/register_state.dart';
import '../../event/login/hidden_password.dart';

class RegisterBloc extends Bloc<registerPressed, RegisterState> {
  RegisterBloc({registerState}) : super(registerState);
  DatabaseMovie db = new DatabaseMovie();
  //----------------------------------------------------------------------
  String _errMail(registerPressed e) {
    if (e.userMail!.isEmpty) {
      return "Nhập Email";
    } else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(e.userMail.toString())) {
      return "Sai định dạng mail";
    } else {
      return "";
    }
  }

  //---------------------------------------------------------------------
  String _errPhone(registerPressed e) {
    print("chech ky tu" + e.phone!.length.toString());
    if (e.phone!.length > 11 || e.phone!.length < 10) {
      return "Nhập từ 10-11 ký tự";
    } else {
      return "";
    }
  }

  //---------------------------------------------------------------------
  String _errPassWord(registerPressed e) {
    // print("chech ky tu"+ e.password!.length.toString());
    if (e.password!.length > 20 || e.password!.length < 6) {
      return "Nhập từ 6-20 ký tự";
    } else {
      return "";
    }
  }

  //-----------------------------------
  bool _success(bool? isErrorName, bool? isErrorEmail, bool? isErrorPhone,
      bool? isErrorPass) {
    if (isErrorEmail! || isErrorName! || isErrorPhone! || isErrorPass!) {
      return false;
    } else {
      return true;
    }
  }
  Stream<RegisterState> _insert(User user,RegisterState state2,bool notEmty) async* {
 if(notEmty){
   print("đã tồn tại");
   yield Failure(
       isErrMail:state2.isErrMail,
       isErrPhone: state2.isErrPhone,
       errMail:state2.errMail,
       errPassword:state2.errPassword,
       errPhone:state2.errPhone,
       errName:state2.errName,
       isErrPassword:state2.isErrPassword,
       isErrName:state2.isErrName,
       success:state2.success
   );
 }
 else{
   print('aaaa');
   try {
     var insert = await db.insertUser(user);
     print(insert);
   } catch (e) {
     print(e.toString());
   };
   print("không tồn tại");
   yield Success(
       isErrMail:state2.isErrMail,
       isErrPhone: state2.isErrPhone,
       errMail:state2.errMail,
       errPassword:state2.errPassword,
       errPhone:state2.errPhone,
       errName:state2.errName,
       isErrPassword:state2.isErrPassword,
       isErrName:state2.isErrName,
       success:state2.success
   );
 }


  }

  @override
  Stream<RegisterState> mapEventToState(registerPressed event) async* {
    if (event is RegisterEvent) {
      RegisterState? state2 = state;
      state2.errName = (event.name!.length < 3 || event.name!.length > 20)
          ? "Nhập từ 3-20 ký tự"
          : "";
      state2.isErrName = (event.name!.length < 3 || event.name!.length > 20);

      state2.errMail = _errMail(event);
      state2.isErrMail = !_errMail(event).isEmpty;

      state2.errPhone = _errPhone(event);
      state2.isErrPhone = !_errPhone(event).isEmpty;

      state2.errPassword = _errPassWord(event);
      state2.isErrPassword = !_errPassWord(event).isEmpty;

      print(state2.errPhone);
      state2.success = _success(state2.isErrName, state2.isErrMail,
          state2.isErrPhone, state2.isErrPassword);
      print(state2.success.toString());
      yield state2;
      if (state2.success == true) {
      //  List<User> _listUser;
       //  db.deleteUser("admin24");
      //   db.deleteUser("thang");
      //   db.deleteUser("thắng");
       // db.deleteUser("admin243");
      var   _listUser = await db.getUserByName(event.name??"");
        print(_listUser.length.toString()+"length");
        User user = new User(
            userName: event.name,
            userAvatar:"",
            userMail: event.userMail,
            userPhone: int.parse(event.phone??"0"),
            userPassword: event.password);
  yield* _insert(user, state2, _listUser.isNotEmpty);
      }
    }
  }
}
