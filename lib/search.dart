import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fruit_flutter/fruit.dart';
import 'package:fruit_flutter/fruits_model.dart';

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
      appBar: AppBar(
        title: Text(
          'Search some vegetables...',
          style: TextStyle(fontSize: 18),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: DataSearch());
            },
          )
        ],
      ),
      drawer: Drawer(),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
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
            icon: Icon(Icons.home, color: Colors.grey),
            title: Text('Home', style: TextStyle(color: Colors.grey)),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              color: Colors.blue,
            ),
            title: Text(
              'Search',
              style: TextStyle(color: Colors.blue, fontSize: 16),
            ),
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
  final Fruits fruits;

  EachList(this.fruits);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Card(
      child: new Row(
        children: <Widget>[
          Container(
            child: Image.asset(
              fruits.image,
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
                    fruits.name,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                  child: SizedBox(
                    width: 230,
                    child: new Text(
                      fruits.descriptions,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                      // textAlign: TextAlign.justify,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.favorite_border,
          ),
        ],
      ),
    );
  }
}

class DataSearch extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    //action for app bar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //leading icon on the left of the app bar
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    for (int i = 0; i < fruits.length; i++) {
      if (query == fruits[i].name) {
        return Card(
          child: Container(
            child: Row(
              children: <Widget>[
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: <Widget>[
                    Container(
                      child: Image.asset(
                        fruits[i].image,
                        width: 350,
                        height: 250,
                      ),
                    ),
                    ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200.withOpacity(0.7)),
                          width: 350,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 8, 10, 10),
                                child: Text(
                                  fruits[i].name,
                                  style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 10, left: 10, bottom: 10),
                                child: Text(
                                  fruits[i].descriptions,
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
    for (int i = 0; i < fruits.length; i++) {
      if (query != fruits[i].name) {
        return Center(
          child: Container(
            height: 100,
            width: 100,
            child: Card(
              color: Colors.redAccent,
              child: Center(
                child: Text('Nothing'),
              ),
            ),
          ),
        );
      } else if (query == '') {
        return Center(
          child: Container(
            height: 100,
            width: 100,
            child: Card(
              color: Colors.redAccent,
              child: Center(
                child: Text('Nothing'),
              ),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //show when someone search for something
    final suggestionList = query.isEmpty
        ? fruits
        : fruits.where((p) => p.name.startsWith(query)).toList();

    return ListView.builder(
      itemBuilder: (context, final index) => ListTile(
        onTap: () {
          query = suggestionList[index].name;
          showResults(context);
        },
        title: RichText(
            text: TextSpan(
                text: suggestionList[index].name.substring(0, query.length),
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                children: [
              TextSpan(
                  text: suggestionList[index].name.substring(query.length),
                  style: TextStyle(color: Colors.grey))
            ])),
        leading: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Image.asset(
            suggestionList[index].image,
            width: 80,
            height: 100,
          ),
        ),
      ),
      itemCount: suggestionList.length,
    );
  }
}
