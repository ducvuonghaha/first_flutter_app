import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fruit_flutter/database/databaseUser.dart';

import 'model/user_model.dart';

void main() {
  runApp(SignUp());
}

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Đăng ký',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SignUpPage(title: 'Đăng ký'),
    );
  }
}

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final DBUsers dbUsers = new DBUsers();
  Users users;

  // List<Users> usersList;

  bool obscuretext = true;
  bool obscuretextR = true;

  void toggle() {
    setState(() {
      obscuretext = !obscuretext;
    });
  }

  void toggleR() {
    setState(() {
      obscuretextR = !obscuretextR;
    });
  }

  String usernameERR;
  String passERR;
  String repassERR;
  String emailERR;
  String phoneERR;

  TextEditingController username = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController repassword = new TextEditingController();
  TextEditingController fullname = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController phone = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Image.asset(
                  'assets/images/fruit_logo.jpg',
                  width: 180,
                  height: 130,
                ),
              ),
              Text(
                'FILL IN AND JOIN WITH US !',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TextField(
                  controller: username,
                  decoration: InputDecoration(
                    labelText: 'username',
                    errorText: usernameERR,
                    labelStyle:
                        TextStyle(color: Color(0xff888888), fontSize: 15),
                    errorStyle: TextStyle(
                      color: Colors.red,
                      wordSpacing: 5.0,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Stack(
                  alignment: AlignmentDirectional.centerEnd,
                  children: <Widget>[
                    TextField(
                      controller: password,
                      obscureText: obscuretext,
                      decoration: InputDecoration(
                        errorText: passERR,
                        labelText: 'password',
                        labelStyle:
                            TextStyle(color: Color(0xff888888), fontSize: 15),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: FlatButton(
                        onPressed: toggle,
                        child: Image.asset(
                          obscuretext
                              ? 'assets/images/eye.png'
                              : 'assets/images/remove_eye.png',
                          width: 20,
                          height: 20,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Stack(
                alignment: AlignmentDirectional.centerEnd,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: TextField(
                      controller: repassword,
                      obscureText: obscuretextR,
                      decoration: InputDecoration(
                        errorText: repassERR,
                        labelText: 're-password',
                        labelStyle:
                            TextStyle(color: Color(0xff888888), fontSize: 15),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: FlatButton(
                      onPressed: toggleR,
                      child: Image.asset(
                        obscuretextR
                            ? 'assets/images/eye.png'
                            : 'assets/images/remove_eye.png',
                        width: 20,
                        height: 20,
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TextField(
                  controller: fullname,
                  decoration: InputDecoration(
                    labelText: 'full-name',
                    labelStyle:
                        TextStyle(color: Color(0xff888888), fontSize: 15),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TextField(
                  controller: email,
                  decoration: InputDecoration(
                    errorText: emailERR,
                    labelText: 'email',
                    labelStyle:
                        TextStyle(color: Color(0xff888888), fontSize: 15),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TextField(
                  controller: phone,
                  decoration: InputDecoration(
                    errorText: phoneERR,
                    labelText: 'phone',
                    labelStyle:
                        TextStyle(color: Color(0xff888888), fontSize: 15),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 25, 0, 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: FutureBuilder(
                      future: dbUsers.getUsers(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<Users> userList = snapshot.data;
                          return RaisedButton(
                            color: Colors.green,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            onPressed: () {
                              setState(() {
                                signUpClick(userList);
                              });
                            },
                            child: Text(
                              "SIGN UP",
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
            ],
          ),
        ),
      ),
    );
  }

  void signUpClick(List<Users> usersList) {
    setState(() {
      String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
      RegExp regExp = new RegExp(pattern);

      String patternEmail =
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
      RegExp regExpEmail = new RegExp(patternEmail);

      if (username.text.contains('@fruit.com')) {
        usernameERR = null;
      }

      if (password.text.length > 6) {
        passERR = null;
      }

      if (repassword.text.length > 6) {
        repassERR = null;
      }

      if (regExpEmail.hasMatch(email.text)) {
        emailERR = null;
      }

      if (regExp.hasMatch(phone.text)) {
        phoneERR = null;
      }

      if (username.text == '' ||
          password.text == '' ||
          repassword.text == '' ||
          fullname.text == '' ||
          email.text == '' ||
          phone.text == '') {
        showToastWarnning('Chưa điền đầy đủ thông tin');
      } else if (!username.text.contains('@fruit.com')) {
        usernameERR = 'Tài khoản không hợp lệ';
        showToastWarnning('Tài khoản phải có đuôi @fruit.com');
      } else if (password.text.length <= 6) {
        passERR = 'Mật khẩu không hợp lệ';
        showToastWarnning('Mật khẩu phải trên 6 ký tự');
      } else if (repassword.text != password.text) {
        repassERR = 'Chưa khớp mật khẩu';
        showToastWarnning('Mật khẩu chưa khớp');
      } else if (!regExpEmail.hasMatch(email.text)) {
        emailERR = 'Sai định dạng';
        showToastWarnning('Email không hợp lệ');
      } else if (!regExp.hasMatch(phone.text)) {
        phoneERR = 'Sai định dạng';
        showToastWarnning('Số điện thoại không hợp lệ');
      } else if (usersList.length != 0) {
        for (int i = 0; i < usersList.length; i++) {
          if (usersList[i].username == username.text) {
            usersList.clear();
            showToastWarnning('Tài khoản đã tồn tại');
            break;
          } else if (i == usersList.length - 1) {
            users = new Users(
                username: username.text,
                password: password.text,
                fullname: fullname.text,
                email: email.text,
                phone: phone.text);
            dbUsers.insertUser(users);
            usersList.clear();
            showToastSuccess('Thêm tài khoản thành công');
            break;
          }
        }

        // for (int i = 0; i < usersList.length; i++) {
        //
        // }
      } else {
        users = new Users(
            username: username.text,
            password: password.text,
            fullname: fullname.text,
            email: email.text,
            phone: phone.text);
        dbUsers.insertUser(users);
        usersList.clear();
        showToastSuccess('Thêm tài khoản thành công');
      }
    });
  }

  void showToastWarnning(String text) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.yellowAccent,
      ),
      child: Row(
        children: [
          Icon(Icons.warning),
          SizedBox(
            width: 12.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: SizedBox(
              child: Text(text),
            ),
          ),
        ],
      ),
    );

    FToast fToast = FToast(context);
    fToast.showToast(
        child: toast,
        gravity: ToastGravity.BOTTOM,
        toastDuration: Duration(seconds: 2));
  }

  void showToastSuccess(String text) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.green,
      ),
      child: Row(
        children: [
          Icon(Icons.check),
          SizedBox(
            width: 12.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: SizedBox(
              child: Text(text),
            ),
          ),
        ],
      ),
    );

    FToast fToast = FToast(context);
    fToast.showToast(
        child: toast,
        gravity: ToastGravity.BOTTOM,
        toastDuration: Duration(seconds: 2));
  }
}
