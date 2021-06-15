import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_vmo/bloc/register/password_register_bloc.dart';
import 'package:movie_app_vmo/bloc/register/register_bloc.dart';
import 'package:movie_app_vmo/common/toast.dart';
import 'package:movie_app_vmo/event/login/hidden_password.dart';
import 'package:movie_app_vmo/event/register/register_event.dart';
import 'package:movie_app_vmo/state/register_state.dart';
class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);
  @override
  _RegisterScreen createState() => _RegisterScreen();
}

class _RegisterScreen extends State<RegisterScreen> {
  final String _register = "Sign Up";
  TextEditingController _email = new TextEditingController();
  TextEditingController _passWord = new TextEditingController();
  TextEditingController _phone = new TextEditingController();
  TextEditingController _name = new TextEditingController();
  bool _obscuretext = true;

  @override
  Widget build(BuildContext context) {
    var _mediaQuery = MediaQuery.of(context).size;
    print(MediaQuery.of(context).size);
    return Scaffold(
      body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child:MultiBlocProvider(
        providers: [
        BlocProvider<PassWordRegisterBloc>(
        create: (context)=>PassWordRegisterBloc(obscuretext: _obscuretext),
    ),
          BlocProvider<RegisterBloc>(
            create: (context)=>RegisterBloc(registerState: new RegisterState(
              isErrMail: false,
              isErrName: false,
              isErrPassword: false,
              isErrPhone: false,
              errPassword: "",
              errMail: "",
              errPhone: "",
              errName: "",
              success: false
            )),
          ),
    ],
          child:  GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Container(
                  width: _mediaQuery.width,
                  height: _mediaQuery.height,
                  child: Hero(
                    tag: "background",
                    child: Image.asset(
                      'assets/login.jpg',
                      fit: BoxFit.fill,
                      alignment: Alignment.topLeft,
                    ),
                  ),
                ),

                BlocListener<RegisterBloc, RegisterState>(
                  // listenWhen: (previousState, state) {
                  // return previousState.runtimeType != state.runtimeType;
                  // },
                  listener: (context, state) {
                    if(state is Failure){
                      showToast("Người dùng đã tồn tại", context, Colors.grey, Icons.close);
                    }
                    else if(state is Success){
                      showToast("Đăng ký thành công", context, Colors.greenAccent, Icons.check);
                      Navigator.of(context).pop();
                    }
                  },
                  child:  _registerForm(_mediaQuery),
                )
              ],
            ),
          ),
          )

      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _registerForm(var mediaQuery) {
    return
      SafeArea(
        child: BlocBuilder<RegisterBloc, RegisterState>(
            builder:(context,state) {
              return     Container(
                width: mediaQuery.width,
                height: mediaQuery.height / 1.1,
                child: SingleChildScrollView(
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        _register,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: "coiny",
                            fontSize: 30,
                            color: Colors.white),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Stack(
                          alignment: state.isErrName!?Alignment(0.8, -0.25):Alignment(0.8, 0.0),
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                              child: TextField(
                                controller: _name,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  errorText: state.isErrName!?state.errName:null,
                                    labelText: "Tên người dùng",
                                    labelStyle: TextStyle(color: Colors.white),
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5.0),
                                        borderSide:
                                        BorderSide(color: Colors.white, width: 1.0)),
                                    errorBorder:OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5.0),
                                        borderSide:
                                        BorderSide(color: Colors.red, width: 1.0)),
                                    disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5.0),
                                        borderSide:
                                        BorderSide(color: Colors.white, width: 1.0)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5.0),
                                        borderSide:
                                        BorderSide(color: Colors.white, width: 1.0)),
                                    contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5.0),
                                        borderSide:
                                        BorderSide(color: Colors.white, width: 1.0)),
                                    //  fillColor: Colors.red,
                                    hintText: 'Tên người dùng',
                                    hintStyle: TextStyle(color: Colors.white)),
                              ),
                            ),
                            Container(
                              width: 30,
                              child: Icon(
                                Icons.person,
                                size: mediaQuery.width / 15,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Stack(
                          alignment: state.isErrMail!?Alignment(0.8, -0.25):Alignment(0.8, 0.0),
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                              child: TextField(
                                controller: _email,
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                    errorText: !state.isErrMail!?null:state.errMail,
                                    labelText: "Email",
                                    labelStyle: TextStyle(color: Colors.white),
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5.0),
                                        borderSide:
                                        BorderSide(color: Colors.white, width: 1.0)),
                                    errorBorder:OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5.0),
                                        borderSide:
                                        BorderSide(color: Colors.red, width: 1.0)),
                                    disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5.0),
                                        borderSide:
                                        BorderSide(color: Colors.white, width: 1.0)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5.0),
                                        borderSide:
                                        BorderSide(color: Colors.white, width: 1.0)),
                                    contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5.0),
                                        borderSide:
                                        BorderSide(color: Colors.white, width: 1.0)),
                                    //  fillColor: Colors.red,
                                    hintText: 'Email',
                                    hintStyle: TextStyle(color: Colors.white)),
                              ),
                            ),
                            Container(
                              width: 30,
                              child: Icon(
                                Icons.email,
                                size: mediaQuery.width / 15,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Stack(
                          alignment:state.isErrPhone!?Alignment(0.8, -0.25):Alignment(0.8, 0.0),
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                              child: TextField(
                                controller: _phone,
                                keyboardType: TextInputType.phone,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  //errorText: state.isErrPhone!?null:state.errPhone,
                                    errorText: !state.isErrPhone!?null:state.errPhone,
                                    labelText: "Số điện thoại",
                                    labelStyle: TextStyle(color: Colors.white),
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5.0),
                                        borderSide:
                                        BorderSide(color: Colors.white, width: 1.0)),
                                    errorBorder:OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5.0),
                                        borderSide:
                                        BorderSide(color: Colors.red, width: 1.0)),
                                    disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5.0),
                                        borderSide:
                                        BorderSide(color: Colors.white, width: 1.0)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5.0),
                                        borderSide:
                                        BorderSide(color: Colors.white, width: 1.0)),
                                    contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5.0),
                                        borderSide:
                                        BorderSide(color: Colors.white, width: 1.0)),
                                    //  fillColor: Colors.red,
                                    hintText: 'Số điện thoại',
                                    hintStyle: TextStyle(color: Colors.white)),
                              ),
                            ),
                            Container(
                              width: 30,
                              child: Icon(
                                Icons.phone,
                                size: mediaQuery.width / 15,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child:
                        BlocBuilder<PassWordRegisterBloc, bool>(
                            builder:(context,obs) {
                              return  Stack(
                                alignment: state.isErrPassword!?Alignment(0.8, -0.25):Alignment(0.8, 0.0),
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                                    child: TextField(
                                      controller: _passWord,
                                      obscureText: obs,
                                      style: TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                          errorText: !state.isErrPassword!?null:state.errPassword,
                                          labelStyle: TextStyle(color: Colors.white),
                                          labelText: "Mật khẩu",
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(5.0),
                                              borderSide:
                                              BorderSide(color: Colors.white, width: 1.0)),
                                          disabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(5.0),
                                              borderSide:
                                              BorderSide(color: Colors.white, width: 1.0)),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(5.0),
                                              borderSide:
                                              BorderSide(color: Colors.white, width: 1.0)),
                                          contentPadding:
                                          EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(5.0),
                                              borderSide:
                                              BorderSide(color: Colors.white, width: 1.0)),
                                          //  fillColor: Colors.red,
                                          hintText: 'Mật khẩu',
                                          hintStyle: TextStyle(color: Colors.white)),
                                    ),
                                  ),
                                  BlocBuilder<PassWordRegisterBloc, bool>(
                                      builder:(context,obs) {
                                        return   GestureDetector(
                                          onTap: (){
                                            context.read<PassWordRegisterBloc>().add(HiddenPassword.hidden);
                                          },
                                          child: Container(
                                            width: 30,
                                            child: Icon(obs?Icons.lock:Icons.lock_open,
                                                size: mediaQuery.width / 15,
                                                color: Colors.white),

                                          ),
                                        );
                                      }
                                  ),
                                ],
                              );
                            }
                        ),

                      ),
                      Theme(
                        data: ThemeData(unselectedWidgetColor: Colors.white),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              side: BorderSide(
                                width: 2.0,
                                color: Colors.white54,
                              ),
                              onPrimary: Colors.black87,
                              primary: Colors.transparent,
                              minimumSize: Size(mediaQuery.width / 1.5, 50),
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(2)),
                              )),
                          onPressed: () {
                            FocusScopeNode currentFocus = FocusScope.of(context);
                            if (currentFocus.hasFocus) {
                              currentFocus.unfocus();}
                            context.read<RegisterBloc>().add(registerPressed(
                                userMail: _email.text,
                              password: _passWord.text,
                              phone: _phone.text,
                              name: _name.text
                            ));
                          },
                          child: Text(
                            "Đăng ký",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              );
            }
        ),
      );


  }
}
