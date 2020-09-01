import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Fruit());
}

class Fruit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'list'),
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


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(

        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Padding(
                padding: const EdgeInsets.only(top: 8, left: 8),
                child: Text(
                  'JULY 2019',
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'In season today',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                ),


              ),



            ]),
      ),
    );
  }

}
