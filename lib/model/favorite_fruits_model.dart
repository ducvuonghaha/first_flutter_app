import 'package:flutter/cupertino.dart';

class FavoriteFruits {
  int idF;
  String nameF;
  String descriptionsF;
  String imageF;

  FavoriteFruits(
      {this.idF,
      @required this.nameF,
      @required this.descriptionsF,
      @required this.imageF});

  Map<String, dynamic> toMap() {
    return {
      'idF': idF,
      'nameF': nameF,
      'descriptionsF': descriptionsF,
      'imageF': imageF,
    };
  }
}
