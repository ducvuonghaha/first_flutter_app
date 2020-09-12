import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fruit_flutter/database/databaseUser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'fruit.dart';
import 'model/user_model.dart';
import 'signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var username = preferences.getString('username');
  runApp(MaterialApp(home: username == null ? MyApp() : Fruit()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'demo login'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DBUsers dbUsers = new DBUsers();
  Users users;

  //show/hide password
  bool _obscureText = true;
  int updateIndex;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  //editText
  TextEditingController username = new TextEditingController();
  TextEditingController password = new TextEditingController();
  String usernameERR;
  String passERR;

  TextEditingController newpassword = new TextEditingController();
  TextEditingController renewpassword = new TextEditingController();
  TextEditingController usernameUD = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbUsers = new DBUsers();
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //   dbUsers = new DBUsers();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: Container(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.fromLTRB(30, 50, 30, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                    width: 240,
                    height: 150,
                    child: Image.asset('assets/images/fruit_logo.jpg')),
                Text(
                  'Welcome Back !',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 20, 0, 0),
                  child: TextField(
                      controller: username,
                      decoration: InputDecoration(
                          labelText: "Username",
                          errorText: usernameERR,
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
                              errorText: passERR,
                              labelStyle: TextStyle(
                                  color: Color(0xff888888), fontSize: 15))),
                    ),
                    FlatButton(
                      onPressed: _toggle,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                        child: new Image.asset(
                          _obscureText
                              ? 'assets/images/eye.png'
                              : 'assets/images/remove_eye.png',
                          width: 20,
                          height: 20,
                        ),
                        // style: TextStyle(
                        //     color: Colors.blue,
                        //     fontWeight: FontWeight.bold,
                        //     fontSize: 12)),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 20),
                  child: SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: FutureBuilder(
                        future: dbUsers.getUsers(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<Users> usersList = snapshot.data;
                            return RaisedButton(
                              color: Colors.green,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              onPressed: () {
                                setState(() {
                                  // showToastSuccess(usersList[1].password);
                                  onSignInClick(usersList);
                                });
                              },
                              child: Text(
                                "SIGN IN",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            );
                          }
                          return CircularProgressIndicator();
                        }),
                  ),
                ),
                Container(
                    width: double.infinity,
                    child: Column(
                      children: <Widget>[
                        FutureBuilder(
                            future: dbUsers.getUsers(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                List<Users> usersList = snapshot.data;
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            Expanded(
                                          child: SizedBox(
                                            height: 500,
                                            child: AlertDialog(
                                              contentPadding:
                                                  const EdgeInsets.fromLTRB(
                                                      15, 15, 15, 15),
                                              backgroundColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              ),
                                              content:
                                                  Builder(builder: (context) {
                                                // Get available height and width of the build area of this widget. Make a choice depending on the size.
                                                var height =
                                                    MediaQuery.of(context)
                                                        .size
                                                        .height;
                                                var width =
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width;
                                                usernameUD.text = username.text;
                                                return SingleChildScrollView(
                                                  child: Container(
                                                    height: height - 310,
                                                    width: width - 20,
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 20),
                                                          child: Text(
                                                            'Forgot your password ?',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .green,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 20),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 20),
                                                          child: TextField(
                                                            controller:
                                                                usernameUD,
                                                            decoration:
                                                                InputDecoration(
                                                                    hintText:
                                                                        'Your account'),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 20),
                                                          child: TextField(
                                                            controller:
                                                                newpassword,
                                                            decoration:
                                                                InputDecoration(
                                                              hintText:
                                                                  'New password',
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 20),
                                                          child: TextField(
                                                            controller:
                                                                renewpassword,
                                                            decoration:
                                                                InputDecoration(
                                                              hintText:
                                                                  'Re-password',
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 20.0),
                                                          child: RaisedButton(
                                                            color: Colors.green,
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            8))),
                                                            onPressed: () {
                                                              setState(() {
                                                                changePassword(
                                                                    usersList);
                                                              });
                                                            },
                                                            child: Text(
                                                              "CHANGE",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }),
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                                  },
                                  child: Text(
                                    "FORGOT PASSWORD?",
                                    style: TextStyle(
                                        color: Colors.green, fontSize: 15),
                                  ),
                                );
                              }
                              return Center(child: CircularProgressIndicator());
                            }),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 80, 0, 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "NEW USER?",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 15),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (context) => SignUp()));
                                  },
                                  child: Text(
                                    "SIGN UP",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void changePassword(List<Users> userList) {
    setState(() {
      if (newpassword.text == '' || renewpassword.text == '') {
        showToastWarning('Chưa điền đủ thông tin');
      } else if (newpassword.text != renewpassword.text) {
        showToastWarning('Chưa trùng mật khẩu');
      } else if (newpassword.text.length <= 6) {
        showToastWarning('Mật khẩu phải nhiều hơn 6 ký tự');
      } else {
        for (int i = 0; i < userList.length; i++) {
          if (userList[i].username == usernameUD.text) {
            users = userList[i];
            users.password = newpassword.text;
            dbUsers.updateUser(users);
            showToastSuccess('Đổi mật khẩu thành công');
            newpassword.clear();
            renewpassword.clear();
            users = null;
            userList.clear();
            break;
          } else if (i == userList.length - 1) {
            showToastWarning('Không có tài khoản này');
            break;
          }
        }
      }
    });
  }

  void onSignInClick(List<Users> usersList) {
    setState(() async {
      if (username.text.contains('@fruit.com')) {
        usernameERR = null;
      }

      if (password.text.length > 6) {
        passERR = null;
      }

      if (username.text == '' || password.text == '') {
        showToastWarning('Chưa nhập tên tài khoản hoặc mật khẩu');
      } else if (!username.text.contains('@fruit.com')) {
        usernameERR = 'Tài khoản không hợp lệ';
        showToastWarning('Tài khoản phải có đuôi @fruit.com');
      } else if (password.text.length <= 6) {
        passERR = 'Mật khẩu phải trên 6 ký tự';
      } else {
        for (int i = 0; i < usersList.length; i++) {
          if (usersList[i].username == username.text &&
              usersList[i].password == password.text) {
            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            preferences.setString('username', usersList[i].username);

            Navigator.push(
                context, new MaterialPageRoute(builder: (context) => Fruit()));
            showToastSuccess("Đăng nhập thành công");
            getDialog(context, "Xin chào " + usersList[i].username + " !");
            break;
          } else if (i == usersList.length - 1) {
            showToastWarning("Sai tài khoản hoặc mật khẩu");
            break;
          }
        }
      }
      // showToastSuccess(usersList.length.toString());
    });
  }

  void getDialog(BuildContext context, String text) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.green,
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
      toastDuration: Duration(seconds: 1),
    );
  }

  void showToastWarning(String text) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.yellow,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.warning),
          SizedBox(
            width: 12.0,
          ),
          SizedBox(
              width: 200,
              child: Text(
                text,
              )),
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
