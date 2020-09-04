import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'fruit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'demo login'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // int _counter = 0;

  //show/hide password
  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  //editText
  TextEditingController username = new TextEditingController();
  TextEditingController password = new TextEditingController();
  String usernameERR = 'Tài khoản không hợp lệ';
  String passERR = 'Mật khẩu phải trên 6 ký tự';
  bool userInvalid = true;
  bool passInvalid = true;

  // void _incrementCounter() {
  //   setState(() {
  //     // This call to setState tells the Flutter framework that something has
  //     // changed in this State, which causes it to rerun the build method below
  //     // so that the display can reflect the updated values. If we changed
  //     // _counter without calling setState(), then the build method would not be
  //     // called again, and so nothing would appear to happen.
  //     _counter++;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      // appBar: AppBar(
      //   // Here we take the value from the MyHomePage object that was created by
      //   // the App.build method, and use it to set our appbar title.
      //   title: Text(widget.title),
      // ),
      body: Container(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        constraints: BoxConstraints.expand(),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.fromLTRB(30, 40, 30, 0),
            child: Column(
              // Column is also a layout widget. It takes a list of children and
              // arranges them vertically. By default, it sizes itself to fit its
              // children horizontally, and tries to be as tall as its parent.
              //
              // Invoke "debug painting" (press "p" in the console, choose the
              // "Toggle Debug Paint" action from the Flutter Inspector in Android
              // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
              // to see the wireframe for each widget.
              //
              // Column has various properties to control how it sizes itself and
              // how it positions its children. Here we use mainAxisAlignment to
              // center the children vertically; the main axis here is the vertical
              // axis because Columns are vertical (the cross axis would be
              // horizontal).
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    width: 80,
                    height: 80,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Color(0xffd8d8d8)),
                    child: FlutterLogo()),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Hello\nWelcome Back',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 20, 0, 0),
                  child: TextField(
                      controller: username,
                      decoration: InputDecoration(
                          labelText: "Username",
                          errorText: userInvalid ? usernameERR : null,
                          labelStyle: TextStyle(
                              color: Color(0xff888888), fontSize: 15))),
                ),
                Stack(
                  alignment: AlignmentDirectional.centerEnd,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 0, 0),
                      child: TextField(
                          controller: password,
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                              labelText: "Password",
                              errorText: passInvalid ? passERR : null,
                              labelStyle: TextStyle(
                                  color: Color(0xff888888), fontSize: 15))),
                    ),
                    FlatButton(
                      onPressed: _toggle,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                        child: new Text(_obscureText ? "SHOW" : "HIDE",
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 12)),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 60),
                  child: SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: RaisedButton(
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      onPressed: onSignInClick,
                      child: Text(
                        "SIGN IN",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 0),
                  child: Container(
                      height: 70,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "NEW USER? SIGN UP",
                            style: TextStyle(color: Colors.grey, fontSize: 15),
                          ),
                          Text(
                            "FORGOT PASSWORD?",
                            style: TextStyle(color: Colors.blue, fontSize: 15),
                          )
                        ],
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void onSignInClick() {
    setState(() {
      final String user = 'ducvuong@fruit.com';
      final String pass = 'meovuong201099';

      if (username.text.contains('@fruit.com')) {
        userInvalid = false;
      }

      if (password.text.length >= 6) {
        passInvalid = false;
      }

      if (!username.text.contains('@fruit.com')) {
        userInvalid = true;
      } else if (password.text.length < 6) {
        passInvalid = true;
      } else if (!(username.text == user)) {
        showToastErr("Không có tài khoản " + username.text);
      } else if (!(password.text == pass)) {
        showToastErr("Sai mật khẩu");
      } else {
        Navigator.push(
            context, new MaterialPageRoute(builder: (context) => Fruit()));

        showToastSuccess("Đăng nhập thành công");

        showDialogg(context, "Xin chào " + username.text + " !");
      }
    });
  }

  void showDialogg(BuildContext context, String text) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.blue,
              title: Text(
                text,
                style: TextStyle(color: Colors.white),
              ),
            ));
  }

  void showToastErr(String text) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.redAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.cancel),
          SizedBox(
            width: 12.0,
          ),
          Text(text),
        ],
      ),
    );

    FToast fToast = FToast(context);
    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
  }

  void showToastSuccess(String text) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.green,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check),
          SizedBox(
            width: 12.0,
          ),
          Text(text),
        ],
      ),
    );

    FToast fToast = FToast(context);
    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
  }
}
