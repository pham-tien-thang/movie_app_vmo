import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_vmo/database/database_app.dart';
class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  var _listUser = [];
  DatabaseMovie db = new DatabaseMovie();
  _getList()async{
    _listUser = await db.getAlluser();
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {

    var _mediaQuery = MediaQuery.of(context).size;
    print(MediaQuery.of(context).size);
    return Scaffold(
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child:  _home(_mediaQuery),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _home(var mediaQuery) {
    return Container(
      width: mediaQuery.width,
      height: mediaQuery.height / 1.3,
      color: Colors.grey,
      child: ListView.builder(
        shrinkWrap: true,
        controller: new ScrollController(),
        itemCount: 2,
        itemBuilder: (context, index) {
          return Container(
            width: mediaQuery.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text("jjmmkkm")
              ],
            ),
          );
        },
      ),
    );
  }
}
