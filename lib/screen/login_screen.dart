import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_vmo/bloc/login/login_bloc.dart';
import 'package:movie_app_vmo/bloc/login/remember_bloc.dart';
import 'package:movie_app_vmo/common/toast.dart';
import 'package:movie_app_vmo/event/login/login_event.dart';
import 'package:movie_app_vmo/screen/home_screen.dart';
import 'package:movie_app_vmo/state/login_state.dart';
import '../bloc/login/pass_word_bloc.dart';
import '../event/login/hidden_password.dart';
import 'package:movie_app_vmo/event/login/remember_event.dart';
import 'package:movie_app_vmo/screen/register_screen.dart';
class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);
  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  TextEditingController _name = new TextEditingController();
  TextEditingController _passWord = new TextEditingController();
  final String _login = "LOGIN";
  final String _rememberpassword = "Ghi nhớ mật khẩu";
   final String _noAccount = " Chưa có tài khoản? ";
   final String _registerNow = "Đăng ký ngay";
  bool _obscuretext = true;
  bool _checkBox = false;
  @override
  Widget build(BuildContext context) {
    var _mediaQuery = MediaQuery.of(context).size;
    print(MediaQuery.of(context).size);
    return Scaffold(
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: MultiBlocProvider(
          providers: [
            BlocProvider<PassWordBloc>(
              create: (context)=>PassWordBloc(obscuretext: _obscuretext),
            ),
            BlocProvider<RememberBloc>(
              create: (BuildContext context) => RememberBloc(checkbox: false),
            ),
            BlocProvider<LoginBloc>(
              create: (BuildContext context) => LoginBloc(
                loginState: new LoginState(
                    isErrName: false,
                    isErrPassword: false,
                    errPassword: "",
                    errName: "",
                    success: false)
              ),
            ),
          ],

          child: GestureDetector(
            onTap: (){
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
                BlocListener<LoginBloc, LoginState>(
                  // listenWhen: (previousState, state) {
                  // return previousState.runtimeType != state.runtimeType;
                  // },
                  listener: (context, state) {
                    if(state is FailureLogin){
                      showToast("Sai tài khoản hoặc mật khẩu", context, Colors.grey, Icons.close);
                    }
                    else if(state is SuccessLogin){
                      showToast("Đã đăng nhập vào "+_name.text, context, Colors.greenAccent, Icons.check);
                      Navigator.pushReplacement(
                          context, new MaterialPageRoute(builder: (context) => HomeScreen()));
                    }
                  },
                  child:   _loginForm(_mediaQuery),
                )

              ],
            ),
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  Widget _loginForm(var mediaQuery) {

    return Container(
      width: mediaQuery.width,
      height: mediaQuery.height/1.3 ,
      child: SingleChildScrollView(

        child:BlocBuilder<LoginBloc, LoginState>(
          builder: (context,state){
            return  Column(
              children: [
                Text(
                  _login,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: "coiny",
                      fontSize: 30,
                      color: Colors.white),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Stack(
                    alignment: state.isErrName!? Alignment(0.8, -0.25):Alignment(0.8, 0.0),
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                        child: TextField(
                          controller: _name,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            errorText: state.errName==""?null:state.errName,
                              labelText: "Tên người dùng",
                              labelStyle: TextStyle(color: Colors.white),
                              fillColor: Colors.white,
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
                              hintText: 'Email',
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
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Stack(
                    alignment: state.isErrPassword!? Alignment(0.8, -0.25):Alignment(0.8, 0.0),
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                        child: BlocBuilder<PassWordBloc, bool>(
                            builder: (context,obs){
                              return TextField(
                                controller: _passWord,
                                obscureText: obs,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  errorText: state.isErrPassword!?state.errPassword:null,
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
                              );
                            }
                        ),
                      ),
                      BlocBuilder<PassWordBloc, bool>(
                          builder:(context,obs) {
                            return   GestureDetector(
                              onTap: (){
                                context.read<PassWordBloc>().add(HiddenPassword.hidden);
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
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        BlocBuilder<RememberBloc,bool>(
                          builder: (context,check){
                            return Theme(
                              data: ThemeData(unselectedWidgetColor: Colors.white),
                              child: Checkbox(
                                activeColor: Colors.white,
                                checkColor: Colors.black,
                                value: check,
                                onChanged: (v) {
                                  context.read<RememberBloc>().add(remember.check);
                                },
                              ),
                            );
                          },
                        ),
                        Text(
                          _rememberpassword,
                          style: TextStyle(
                              fontSize: mediaQuery.width / 25, color: Colors.white),
                        )
                      ],
                    ),
                  ],
                ),
                BlocBuilder<RememberBloc,bool>(
                  builder: (context,check){
                    return Theme(
                      data: ThemeData(unselectedWidgetColor: Colors.white),
                      child:    ElevatedButton(
                        style:ElevatedButton.styleFrom(
                            side: BorderSide(width: 2.0, color: Colors.white54,),
                            onPrimary: Colors.black87,
                            primary: Colors.transparent,
                            minimumSize: Size(mediaQuery.width/1.5, 50),
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(2)),
                            )),
                        onPressed: () {
                          FocusScopeNode currentFocus = FocusScope.of(context);
                          if (currentFocus.hasFocus) {
                            currentFocus.unfocus();
                          }
                          context.read<LoginBloc>().add(LoginPressed(
                              password: _passWord.text,
                              name: _name.text
                          ));
                        },
                        child: Text("Đăng nhập",style: TextStyle(color: Colors.white),),
                      ),
                    );
                  },
                ),

                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _noAccount,
                      style: TextStyle(fontSize: mediaQuery.width / 25,
                          color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        FocusScopeNode currentFocus = FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                      },
                      child: InkWell(
                        onTap: (){
                          Navigator.push(
                              context, new MaterialPageRoute(builder: (context) => RegisterScreen()));
                        },
                        child: Text(
                          _registerNow,
                          style: TextStyle(
                              fontSize: mediaQuery.width / 25,
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            );
          },
        ),

      ),
    );

  }
}
