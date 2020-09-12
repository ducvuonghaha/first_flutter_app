import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fruit_flutter/database/databaseFavorites.dart';
import 'package:fruit_flutter/fruit.dart';
import 'package:fruit_flutter/model/favorite_fruits_model.dart';
import 'package:fruit_flutter/search.dart';

void main() {
  runApp(Favorites());
}

class Favorites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FavoritesPage(
        title: 'aaa',
      ),
    );
  }
}

class FavoritesPage extends StatefulWidget {
  FavoritesPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<FavoritesPage> {
  ScrollController scrollController = new ScrollController();
  DBFavorites dbFavorites = new DBFavorites();
  FavoriteFruits favoriteFruits;
  List<FavoriteFruits> favoriteFruitsList;

  @override
  void dispose() {
    // TODO: implement dispose
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // getDialog(context, widget.text);
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
        // if (index == 2) {
        //   Navigator.push(context,
        //       new MaterialPageRoute(builder: (context) => Favorites()));
        // }
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite vegetables list'),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: FutureBuilder(
              future: dbFavorites.getFavorites(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  favoriteFruitsList = snapshot.data;
                  return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    controller: scrollController,
                    itemBuilder: /*1*/ (context, i) {
                      return ListTile(
                        title: new Row(
                          children: <Widget>[
                            Container(
                              child: Image.asset(
                                'assets/images/' + favoriteFruitsList[i].imageF,
                                width: 80,
                                height: 100,
                              ),
                            ),
                            new Container(
                              child: Row(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            8, 0, 0, 8),
                                        child: new Text(
                                          favoriteFruitsList[i].nameF,
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
                                          width: 190,
                                          child: new Text(
                                            favoriteFruitsList[i].descriptionsF,
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
                                  IconButton(
                                    onPressed: () {
                                      showToastSuccess('Bạn chán ăn ' +
                                          favoriteFruitsList[i].nameF +
                                          ' rồi à ? ☹');
                                      dbFavorites.deleteFavorites(
                                          favoriteFruitsList[i].idF);
                                      setState(() {
                                        favoriteFruitsList.removeAt(i);
                                      });
                                    },
                                    icon: Icon(Icons.clear),
                                    iconSize: 25,
                                    // alreadySaved ? Icons.favorite : Icons.favorite_border,
                                    // color: alreadySaved ? Colors.red : null,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    itemCount: favoriteFruitsList == null
                        ? 0
                        : favoriteFruitsList.length,
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
              title: Text(
                'Home',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              )),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, color: Colors.grey),
            title: Text(
              'Search',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite, color: Colors.green),
            title: Text('Favorites',
                style: TextStyle(color: Colors.green, fontSize: 16)),
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
