import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fruit_flutter/database/databaseUser.dart';
import 'file:///C:/Users/Asus/Desktop/Flutter/fruit_flutter/lib/database/databaseFruits.dart';
import 'package:fruit_flutter/favorites.dart';
import 'package:fruit_flutter/main.dart';
import 'package:fruit_flutter/search.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'model/fruits_model.dart';
import 'model/user_model.dart';

void main() {
  runApp(Fruit());
}

class Fruit extends StatelessWidget {
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
  DBUsers dbUsers = new DBUsers();

  Fruits fruits;
  Users users;

  List<Fruits> fruitsList;
  List<Users> usersList;

  String username = '';

  Future getUsername() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      username = preferences.getString('username');
    });
  }

  Future logOut(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('username');
    showToastSuccess('Đăng xuất thành công');
    Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
  }

  // Fruits newfruits = new Fruits(
  //     name: 'Apples',
  //     descriptions: 'Green or red, they are generally round and tasty',
  //     image: 'apple.jpg');
  // Fruits newfruits2 = new Fruits(
  //     name: 'Avocado',
  //     descriptions: 'One of the oiliest, richest fruits money can buy',
  //     image: 'avocado.jpg');
  // Fruits newfruits3 = new Fruits(
  //     name: 'Blackberries',
  //     descriptions: 'Find them on back-roads and fences in the Northwest',
  //     image: 'blackberries.jpg');
  // Fruits newfruits4 = new Fruits(
  //     name: 'Asparagus',
  //     descriptions: 'It is been used a food and medicine for millennium',
  //     image: 'asparagus.jpg');
  // Fruits newfruits5 = new Fruits(
  //     name: 'Artichokes',
  //     descriptions: 'The armadillo of vegetables',
  //     image: 'artichokes.jpg');
  // Fruits newfruits6 = new Fruits(
  //     name: 'Cantaloupe',
  //     descriptions: 'A fruit so tasty there is a utensil just for it',
  //     image: 'cantaloupe.jpg');
  // Fruits newfruits7 = new Fruits(
  //     name: 'Cauliflower',
  //     descriptions: 'Looks like white broccoli and explodes when cut',
  //     image: 'cauliflower.jpg');

  void initState() {
    // TODO: implement initState
    super.initState();
    dbUsers = new DBUsers();
    getUsername();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 0;
    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
        // if (index == 0) {
        //   Navigator.push(
        //       context, new MaterialPageRoute(builder: (context) => Fruit()));
        // }
        if (index == 1) {
          Navigator.push(
              context, new MaterialPageRoute(builder: (context) => Search()));
        }
        if (index == 2) {
          Navigator.push(context,
              new MaterialPageRoute(builder: (context) => Favorites()));
        }
      });
    }

    // if (fruits == null) {
    //   dbFruitsManager
    //       .insertFruit(newfruits)
    //       .then((id) => {print('Fruit added to database ${id}')});
    //   dbFruitsManager
    //       .insertFruit(newfruits2)
    //       .then((id) => {print('Fruit added to database ${id}')});
    //
    //   dbFruitsManager
    //       .insertFruit(newfruits3)
    //       .then((id) => {print('Fruit added to database ${id}')});
    //
    //   dbFruitsManager
    //       .insertFruit(newfruits4)
    //       .then((id) => {print('Fruit added to database ${id}')});
    //
    //   dbFruitsManager
    //       .insertFruit(newfruits5)
    //       .then((id) => {print('Fruit added to database ${id}')});
    //
    //   dbFruitsManager
    //       .insertFruit(newfruits6)
    //       .then((id) => {print('Fruit added to database ${id}')});
    //
    //   dbFruitsManager
    //       .insertFruit(newfruits7)
    //       .then((id) => {print('Fruit added to database ${id}')});
    // }

    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            FutureBuilder(
                future: dbUsers.getUserbyName(username),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    usersList = snapshot.data;
                    String fullname = usersList[0].fullname;
                    return DrawerHeader(
                      decoration: BoxDecoration(color: Colors.green),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: [
                              Image.asset(
                                'assets/images/avatar.png',
                                width: 24,
                                height: 24,
                              ),
                              Center(
                                child: Text(
                                  fullname,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }

                  return CircularProgressIndicator();
                }),
            GestureDetector(
                onTap: () {
                  setState(() {
                    logOut(context);
                  });
                },
                child: Text('Log out !'))
          ],
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Flex(direction: Axis.horizontal, children: [
            Expanded(
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
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 28),
                      ),
                    ),
                    Center(
                      child: FutureBuilder(
                          future: dbFruitsManager.getFruitList(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              fruitsList = snapshot.data;
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount:
                                    fruitsList == null ? 0 : fruitsList.length,
                                scrollDirection: Axis.vertical,
                                controller: scrollController,
                                itemBuilder: (BuildContext context, int index) {
                                  Fruits fr = fruitsList[index];
                                  return Card(
                                    child: Container(
                                      child: Row(
                                        children: <Widget>[
                                          Stack(
                                            alignment: AlignmentDirectional
                                                .bottomStart,
                                            children: <Widget>[
                                              Container(
                                                child: Image.asset(
                                                  'assets/images/${fr.image}',
                                                  width: 350,
                                                  height: 250,
                                                ),
                                              ),
                                              ClipRect(
                                                child: BackdropFilter(
                                                  filter: new ImageFilter.blur(
                                                      sigmaX: 10.0,
                                                      sigmaY: 10.0),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors
                                                            .grey.shade200
                                                            .withOpacity(0.8)),
                                                    width: 350,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  10,
                                                                  8,
                                                                  10,
                                                                  10),
                                                          child: Text(
                                                            ' ${fr.name}',
                                                            style: TextStyle(
                                                                fontSize: 28,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 10,
                                                                  left: 10,
                                                                  bottom: 10),
                                                          child: Text(
                                                            '${fr.descriptions}',
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                            ),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
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
                                },
                              );
                            }

                            return Center(child: CircularProgressIndicator());
                          }),
                    ),
                  ]),
            ),
          ]),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.green,
            ),
            title: Text(
              'Home',
              style: TextStyle(color: Colors.green),
            ),
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

  void showToastSuccess(String text) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.green,
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
      toastDuration: Duration(seconds: 1),
    );
  }
}
//
//
