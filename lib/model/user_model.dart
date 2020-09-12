import 'package:flutter/cupertino.dart';

class Users {
  int id;
  String username;
  String fullname;
  String password;
  String phone;
  String email;

  Users(
      {this.id,
      @required this.username,
      @required this.password,
      @required this.fullname,
      @required this.email,
      @required this.phone});

  Map<String, dynamic> toMap() {
    return {
      'idU': id,
      'usernameU': username,
      'passwordU': password,
      'fullnameU': fullname,
      'emailU': email,
      'phoneU': phone,
    };
  }
}
