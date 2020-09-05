import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import 'package:fruit_flutter/fruits_model.dart';
import 'package:fruit_flutter/search.dart';

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
  // List<String> names = ['Apples', 'Avocado', 'Blackberries', 'Apples'];
  //
  // List<String> descriptions = [
  //   'Green or red, they are generally round and tasty',
  //   'One of the oiliest, richest fruits money can buy',
  //   'Find them on back-roads and fences in the Northwest',
  //   'Green or red, they are generally round and tasty'
  // ];
  //
  // List<String> images = [
  //   'apple.jpeg',
  //   'avocado.jpg',
  //   'blackberries.jpg',
  //   'apple.jpeg'
  // ];

  ScrollController scrollController = new ScrollController();

  @override
  void dispose() {
    // TODO: implement dispose
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 0;

    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
        if (index == 0) {
          Navigator.push(
              context, new MaterialPageRoute(builder: (context) => Fruit()));
        }
        if (index == 1) {
          Navigator.push(
              context, new MaterialPageRoute(builder: (context) => Search()));
        }
      });
    }

    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 28, left: 8),
                  child: Text(
                    'SEPTEMBER 2020',
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
                new ListView.builder(
                  // reverse: true,
                  controller: scrollController,
                  itemBuilder: (_, int index) => EachList(fruits[index]),
                  itemCount: fruits.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                ),
              ]),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, color: Colors.grey),
            title: Text('Search',
                style: TextStyle(color: Colors.grey, fontSize: 16)),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite, color: Colors.grey),
            title: Text('Favorites',
                style: TextStyle(color: Colors.grey, fontSize: 16)),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class EachList extends StatelessWidget {
  // final String name;
  // final String description;
  //
  // final String path = 'assets/images/';
  // final String images;

  final Fruits fruits;

  EachList(this.fruits);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Card(
      child: new Container(
        child: new Row(
          children: <Widget>[
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: <Widget>[
                new Container(
                  child: Image.asset(
                    fruits.image,
                    width: 350,
                    height: 250,
                  ),
                ),
                ClipRect(
                  child: BackdropFilter(
                    filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: new Container(
                      decoration: new BoxDecoration(
                          color: Colors.grey.shade200.withOpacity(0.8)),
                      width: 350,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
                            child: new Text(
                              fruits.name,
                              style: TextStyle(
                                  fontSize: 28, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 10, left: 10, bottom: 10),
                            child: new Text(
                              fruits.descriptions,
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
