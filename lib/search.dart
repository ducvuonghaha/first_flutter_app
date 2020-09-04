import 'dart:ui';

import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fruit_flutter/fruit.dart';

void main() {
  runApp(Search());
}

class Search extends StatelessWidget {
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
  List<String> names = ['Apples', 'Avocado', 'Blackberries', 'Apples'];

  List<String> descriptions = [
    'Green or red, they are generally round and tasty',
    'One of the oiliest, richest fruits money can buy',
    'Find them on back-roads and fences in the Northwest',
    'Green or red, they are generally round and tasty'
  ];

  List<String> images = [
    'apple.jpeg',
    'avocado.jpg',
    'blackberries.jpg',
    'apple.jpeg'
  ];

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
      });
    }

    return Scaffold(
      // appBar: AppBar(
      //   title: SearchBar(onSearch: ,onItemFound: ,),
      // ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new ListView.builder(
                  // reverse: true,
                  controller: scrollController,
                  itemBuilder: (_, int index) => EachList(this.names[index],
                      this.descriptions[index], this.images[index]),
                  itemCount: this.names.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                ),
              ]),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.grey),
            title: Text('Home', style: TextStyle(color: Colors.grey)),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              color: Colors.orange,
            ),
            title: Text(
              'Search',
              style: TextStyle(color: Colors.orange, fontSize: 16),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite, color: Colors.grey),
            title: Text('Favorites',
                style: TextStyle(color: Colors.grey, fontSize: 16)),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

class EachList extends StatelessWidget {
  final String name;
  final String description;

  final String path = 'assets/images/';
  final String images;

  EachList(this.name, this.description, this.images);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Card(
      child: new Row(
        children: <Widget>[
          Container(
            child: Image.asset(
              path + images,
              width: 80,
              height: 100,
            ),
          ),
          new Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 0, 8),
                  child: new Text(
                    name,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                  child: SizedBox(
                    width: 293,
                    child: new Text(
                      description,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
