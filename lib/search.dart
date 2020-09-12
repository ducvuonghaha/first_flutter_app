import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fruit_flutter/database/databaseFavorites.dart';
import 'package:fruit_flutter/database/databaseUser.dart';
import 'package:fruit_flutter/model/favorite_fruits_model.dart';

import 'database/databaseFruits.dart';
import 'favorites.dart';
import 'fruit.dart';
import 'model/fruits_model.dart';
import 'model/user_model.dart';

void main() {
  runApp(Search());
}

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
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
  final DbFruitsManager dbFruitsManager = new DbFruitsManager();
  final DBFavorites dbFavorites = new DBFavorites();
  final DBUsers dbUsers = new DBUsers();
  Fruits fruits;

  // FavoriteFruits favoriteFruits;
  List<Fruits> fruitsList;
  List<FavoriteFruits> favoriteFruitsList;
  List<Users> usersList;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    scrollController.dispose();
  }

  saveFavorites(int index) {
    FavoriteFruits favoriteFruits = new FavoriteFruits(
        idF: fruitsList[index].id,
        nameF: fruitsList[index].name,
        descriptionsF: fruitsList[index].descriptions,
        imageF: fruitsList[index].image);
    dbFavorites.insertFavorites(favoriteFruits);
    showToastSuccess("Bạn thích ăn " + fruitsList[index].name + " lắm hả? ♥");
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
        // if (index == 1) {
        //   Navigator.push(
        //       context, new MaterialPageRoute(builder: (context) => Search()));
        // }
        if (index == 2) {
          Navigator.push(context,
              new MaterialPageRoute(builder: (context) => Favorites()));
        }
      });
    }

    // TODO: implement build
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
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            FutureBuilder(
                future: dbUsers.getUsers(),
                builder: (context, snapshot) {
                  usersList = snapshot.data;
                  return DrawerHeader(
                    decoration: BoxDecoration(color: Colors.green),
                    child: Column(
                      children: <Widget>[],
                    ),
                  );
                })
          ],
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: FutureBuilder(
              future: dbFruitsManager.getFruitList(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  fruitsList = snapshot.data;
                  return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    controller: scrollController,
                    itemBuilder: /*1*/ (context, i) {
                      return Center(
                        child: ListTile(
                          title: new Row(
                            children: <Widget>[
                              Container(
                                child: Image.asset(
                                  'assets/images/' + fruitsList[i].image,
                                  width: 80,
                                  height: 100,
                                ),
                              ),
                              new Container(
                                child: Row(
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              8, 0, 0, 8),
                                          child: new Text(
                                            fruitsList[i].name,
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                            overflow: TextOverflow.clip,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              8, 0, 0, 0),
                                          child: SizedBox(
                                            width: 185,
                                            child: new Text(
                                              fruitsList[i].descriptions,
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                              overflow: TextOverflow.clip,
                                              // textAlign: TextAlign.justify,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    FutureBuilder(
                                      future: dbFavorites.getFavorites(),
                                      builder: (context, snapshot1) {
                                        if (snapshot1.hasData) {
                                          favoriteFruitsList = snapshot1.data;
                                          for (int j = 0;
                                              j < favoriteFruitsList.length;
                                              j++) {
                                            if (fruitsList[i].name ==
                                                favoriteFruitsList[j].nameF) {
                                              return IconButton(
                                                icon: Icon(
                                                  Icons.favorite,
                                                  color: Colors.red,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    saveFavorites(i);
                                                  });
                                                },
                                                iconSize: 20,
                                                color: null,
                                              );
                                            }
                                          }
                                        }
                                        return IconButton(
                                          icon: Icon(
                                            Icons.favorite_border,
                                            color: null,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              saveFavorites(i);
                                            });
                                          },
                                          iconSize: 20,
                                          color: null,
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            // NEW lines from here...
                          },
                        ),
                      );
                    },
                    itemCount: fruitsList == null ? 0 : fruitsList.length,
                  );
                }
                return CircularProgressIndicator();
              }),
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
              color: Colors.green,
            ),
            title: Text(
              'Search',
              style: TextStyle(color: Colors.green, fontSize: 16),
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

  void showToastSuccess(String text) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.greenAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check),
          SizedBox(
            width: 10.0,
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

class DataSearch extends SearchDelegate<String> {
  final DbFruitsManager dbFruitsManager = new DbFruitsManager();
  final DBFavorites dbFavorites = new DBFavorites();
  Fruits fruit;
  var fruits = [];
  List<FavoriteFruits> favoritesList;

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
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
    // TODO: implement buildLeading
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
    // TODO: implement buildResults
    return FutureBuilder(
      future: dbFruitsManager.getFruitList(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          fruits = snapshot.data;
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
                              'assets/images/' + fruits[i].image,
                              width: 350,
                              height: 250,
                            ),
                          ),
                          ClipRect(
                            child: BackdropFilter(
                              filter:
                                  ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color:
                                        Colors.grey.shade200.withOpacity(0.7)),
                                width: 350,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 8, 10, 10),
                                      child: Text(
                                        fruits[i].name,
                                        style: TextStyle(
                                            fontSize: 28,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 10, left: 10, bottom: 0),
                                      child: Text(
                                        fruits[i].descriptions,
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 45, 0, 0),
                                      child: Center(
                                        child: FutureBuilder(
                                            future: dbFavorites.getFavorites(),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                favoritesList = snapshot.data;
                                                for (int j = 0;
                                                    j < favoritesList.length;
                                                    j++) {
                                                  if (fruits[i].name ==
                                                      favoritesList[j].nameF) {
                                                    return IconButton(
                                                      onPressed: () {},
                                                      icon:
                                                          Icon(Icons.favorite),
                                                      color: Colors.red,
                                                      padding:
                                                          EdgeInsets.all(0.0),
                                                      iconSize: 50,
                                                    );
                                                  }
                                                }
                                                return IconButton(
                                                  onPressed: () {
                                                    // NEW lines from here...
                                                  },
                                                  icon: Icon(
                                                      Icons.favorite_border),
                                                  color: null,
                                                  padding: EdgeInsets.all(0.0),
                                                  iconSize: 50,
                                                );
                                              }
                                              return IconButton(
                                                onPressed: () {
                                                  // NEW lines from here...
                                                },
                                                icon:
                                                    Icon(Icons.favorite_border),
                                                color: null,
                                                padding: EdgeInsets.all(0.0),
                                                iconSize: 50,
                                              );
                                            }),
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
            if (query != fruits[i].name && query != '') {
              return Card(
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Stack(
                        alignment: AlignmentDirectional.center,
                        children: <Widget>[
                          ClipRect(
                            child: BackdropFilter(
                              filter:
                                  ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                              child: Container(
                                // decoration: BoxDecoration(
                                //     color: Colors.grey.shade200.withOpacity(0.7)),
                                width: 350,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Image.asset(
                                        'assets/images/sad.jpg',
                                        width: 100,
                                        height: 100,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 15, 0, 0),
                                      child: Center(
                                        child: Text(
                                          'Không có loại rau này...',
                                          style: TextStyle(
                                              fontSize: 28,
                                              fontWeight: FontWeight.bold),
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
            } else if (query == '') {
              return Card(
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Stack(
                        alignment: AlignmentDirectional.center,
                        children: <Widget>[
                          ClipRect(
                            child: BackdropFilter(
                              filter:
                                  ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                              child: Container(
                                // decoration: BoxDecoration(
                                //     color: Colors.grey.shade200.withOpacity(0.7)),
                                width: 350,
                                child: Column(
                                  children: [
                                    Center(
                                      child: Image.asset(
                                        'assets/images/point_up.gif',
                                        width: 200,
                                        height: 230,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 8, 10, 10),
                                      child: Center(
                                        child: Text(
                                          'Bạn chưa nhập loại rau nào...',
                                          style: TextStyle(
                                              fontSize: 28,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center,
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
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return FutureBuilder(
      future: dbFruitsManager.getFruitList(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          fruits = snapshot.data;
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
                      text:
                          suggestionList[index].name.substring(0, query.length),
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                      children: [
                    TextSpan(
                        text:
                            suggestionList[index].name.substring(query.length),
                        style: TextStyle(color: Colors.grey))
                  ])),
              leading: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Image.asset(
                  'assets/images/' + suggestionList[index].image,
                  width: 80,
                  height: 100,
                ),
              ),
            ),
            itemCount: suggestionList.length,
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
