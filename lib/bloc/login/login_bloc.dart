import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_vmo/common/toast.dart';
import 'package:movie_app_vmo/database/database_app.dart';
import 'package:movie_app_vmo/event/login/login_event.dart';
import 'package:movie_app_vmo/event/register/register_event.dart';
import 'package:movie_app_vmo/model/user_model.dart';
import 'package:movie_app_vmo/state/login_state.dart';
import 'package:movie_app_vmo/state/register_state.dart';
import '../../event/login/hidden_password.dart';

class LoginBloc extends Bloc<LoginPressed, LoginState> {
  LoginBloc({loginState}) : super(loginState);
  DatabaseMovie db = new DatabaseMovie();

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
  //----------------------------------------------------------------------
  String _errPassWord(LoginPressed e) {
    // print("chech ky tu"+ e.password!.length.toString());
    if (e.password!.length > 20 || e.password!.length < 6) {
      return "Nhập từ 6-20 ký tự";
    } else {
      return "";
    }
  }

  //-----------------------------------
  bool _success(bool? isErrorName,
      bool? isErrorPass) {
    if (isErrorName! ||isErrorPass!) {
      return false;
    } else {
      return true;
    }
  }
  Stream<LoginState> _login(LoginState state2,bool notEmty) async* {
    if(notEmty){
      print("đăng nhập ok");
      yield SuccessLogin(
          errPassword:state2.errPassword,
          errName:state2.errName,
          isErrPassword:state2.isErrPassword,
          isErrName:state2.isErrName,
          success:state2.success
      );
    }
  else {
      print("đăng nhập thất bại");
      yield FailureLogin(
          errPassword:state2.errPassword,
          errName:state2.errName,
          isErrPassword:state2.isErrPassword,
          isErrName:state2.isErrName,
          success:state2.success
      );
    }


  }

  @override
  Stream<LoginState> mapEventToState(LoginPressed event) async* {
    if (event is LoginEvent) {
      LoginState? state2 = state;
      state2.errName = (event.name!.length < 3 || event.name!.length > 20)
          ? "Nhập từ 3-20 ký tự"
          : "";
      state2.isErrName = (event.name!.length < 3 || event.name!.length > 20);
print("state name la"+ state.errName.toString() );
      state2.errPassword = _errPassWord(event);
      state2.isErrPassword = !_errPassWord(event).isEmpty;

      state2.success = _success(state2.isErrName,state2.isErrPassword);

      yield state2;
      if (state2.success == true) {
        //  List<User> _listUser;
        //  db.deleteUser("admin24");
        //   db.deleteUser("thang");
        //   db.deleteUser("thắng");
        // db.deleteUser("admin243");
        var   _listUser = await db.getUserByNameAndPassWord(event.name??"",event.password??"");
        print(_listUser.length.toString()+"length");
        // User user = new User(
        //     userName: event.name,
        //     userAvatar:"",
        //     userMail: event.userMail,
        //     userPhone: int.parse(event.phone??"0"),
        //     userPassword: event.password);
        yield* _login(state2, _listUser.isNotEmpty);
      }
    }
  }
}
