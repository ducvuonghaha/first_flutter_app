import 'package:flutter/cupertino.dart';

class Fruits {
  int id;
  String name;
  String descriptions;
  String image;

  Fruits(
      {this.id,
      @required this.name,
      @required this.descriptions,
      @required this.image});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'descriptions': descriptions,
      'image': image,
    };
  }
}
