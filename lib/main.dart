import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
//import 'dart:io';
//import 'dart:convert';

import 'tree.dart';
import 'vlc.dart';
import 'news.dart';
import 'weather.dart';

var cout_men = 0;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Анчих',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Анчих'),
    );
  }
}

// Главное окно
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //int _cout_men = 0;
  String text = "Ни одна кнопка не нажата";

  var size, height, width;

  void naveel_home() {
    cout_men = 0;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const MyHomePage(title: 'Анчих')));
  }

  void naveel_news() {
    cout_men = 3;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const MySecondPage(title: 'Новости')));
  }

  void naveel_camera() {
    cout_men = 1;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const MyThirdPage(title: 'Камера')));
  }

  void naveel_tree() {
    cout_men = 2;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                const MyFourPage(title: 'Генеалогическое древо')));
  }

  void naveel_weather() {
    cout_men = 4;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const MyWeatherPage(title: 'Погода')));
  }

  void onItemTapped(index) {
    cout_men = index;
    text = 'Меню пока не выбрано';
    if (index == 0) {
      naveel_home();
    } else if (index == 1) {
      naveel_camera();
    } else if (index == 2) {
      naveel_tree();
    } else if (index == 3) {
      naveel_news();
    } else if (index == 4) {
      naveel_weather();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;

var drawerTextColor = TextStyle(
  color: Colors.grey[600],
);
var tilePadding = const EdgeInsets.only(left: 8.0, right: 8, top: 8);
var myDrawer = Drawer(
  backgroundColor: Colors.grey[300],
  elevation: 0,
  child: Column(
    children: [
      DrawerHeader(
        child: Icon(
          Icons.settings_rounded,
          size: 64,
        ),
      ),
      Padding(
        padding: tilePadding,
        child: ListTile(
          // onTap: naveel_camera,
          leading: Icon(Icons.home),
          title: Text(
            'L O G I N',
            style: drawerTextColor,
          ),
        ),
      ),
      Padding(
        padding: tilePadding,
        child: ListTile(
          leading: Icon(Icons.settings),
          title: Text(
            'S E T T I N G S',
            style: drawerTextColor,
          ),
        ),
      ),
      Padding(
        padding: tilePadding,
        child: ListTile(
          leading: Icon(Icons.info),
          title: Text(
            'A B O U T',
            style: drawerTextColor,
          ),
        ),
      ),
      Padding(
        padding: tilePadding,
        child: ListTile(
          leading: Icon(Icons.logout),
          title: Text(
            'L O G O U T',
            style: drawerTextColor,
          ),
        ),
      ),
    ],
  ),
);
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Center(
          child: Text(widget.title),
        ),
      ),
       drawer: myDrawer,
      body: Center(
          //Padding ( padding: EdgeInsets.all(40))
          child: Stack(fit: StackFit.expand, children: <Widget>[
        Image(
          image: AssetImage('assets/images/gory.jpg'),
          width: width,
          height: height,
          fit: BoxFit.fill,
        ),
        Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              child: Container(
                width: width / 15,
                height: height / 40,
              ),
            ),
            Container(
              child: Row(
                children: [
                  SizedBox(
                    child: Container(
                      width: width / 15,
                      height: height / 20,
                    ),
                  ),
                  Container(
                    //width: width / 2.5,
                    //height: height / 3,
                    child: Material(
                      color: Colors.purple,
                      elevation: 100,
                      shadowColor: Colors.blue,
                      borderRadius: BorderRadius.circular(28),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Stack(
                        alignment: Alignment.bottomCenter, //Here
                        children: [
                          InkWell(
                            onTap: naveel_camera,
                            child: Column(
                              children: [
                                Ink.image(
                                  image: const NetworkImage(
                                    'https://parik123.nethouse.ru/static/img/0000/0007/4203/74203883.jjd8539p5b.W665.jpg',
                                  ),
                                  height: height / 4,
                                  width: width / 2.5,
                                  fit: BoxFit.fill,
                                ),
                                const Text(
                                  'Камера',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    child: Container(
                      width: width / 15,
                      height: height / 20,
                    ),
                  ),
                  Container(
                    //width: width / 2.5,
                    //height: height / 3,
                    child: Material(
                      color: Colors.yellow,
                      elevation: 100,
                      shadowColor: Colors.blue,
                      borderRadius: BorderRadius.circular(28),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Stack(
                        alignment: Alignment.bottomCenter, //Here
                        children: [
                          InkWell(
                            onTap: naveel_tree,
                            child: Column(
                              children: [
                                Ink.image(
                                  image: const NetworkImage(
                                    'https://flomaster.top/uploads/posts/2023-10/1697495070_flomaster-top-p-drevo-rodoslovnoe-risunok-instagram-2.jpg',
                                  ),
                                  height: height / 4,
                                  width: width / 2.5,
                                  fit: BoxFit.fill,
                                ),
                                const Text(
                                  'Древо',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              child: Container(
                width: width / 15,
                height: height / 40,
              ),
            ),
            Container(
              child: Row(
                children: [
                  SizedBox(
                    child: Container(
                      width: width / 15,
                      height: height / 20,
                    ),
                  ),
                  Container(
                    //width: width / 2.5,
                    //height: height / 3,
                    child: Material(
                      color: Colors.yellow,
                      elevation: 100,
                      shadowColor: Colors.blue,
                      borderRadius: BorderRadius.circular(28),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Stack(
                        alignment: Alignment.bottomCenter, //Here
                        children: [
                          InkWell(
                            onTap: naveel_news,
                            child: Column(
                              children: [
                                Ink.image(
                                  image: const NetworkImage(
                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTlsFj9c_fnn37WyQR0aqNNb3o3rRvjc9SYqhlKFMywtjbjrcIxJHLxsJs2akLOL7HvxJo&usqp=CAU',
                                  ),
                                  height: height / 4,
                                  width: width / 2.5,
                                  fit: BoxFit.fill,
                                ),
                                const Text(
                                  'Новости',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    child: Container(
                      width: width / 15,
                      height: height / 20,
                    ),
                  ),
                  Container(
                    //width: width / 2.5,
                    //height: height / 3,
                    child: Material(
                      color: Colors.yellow,
                      elevation: 100,
                      shadowColor: Colors.blue,
                      borderRadius: BorderRadius.circular(28),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Stack(
                        alignment: Alignment.bottomCenter, //Here
                        children: [
                          InkWell(
                            onTap: naveel_weather,
                            child: Column(
                              children: [
                                Ink.image(
                                  image: const NetworkImage(
                                    'https://play-lh.googleusercontent.com/yXfCpQijMAa6f4thnannzhFNXsk9w-uj0W6rOM4hPaZ2pGqClRDWSfMk4yYzqtqR1-FH',
                                  ),
                                  height: height / 4,
                                  width: width / 2.5,
                                  fit: BoxFit.fill,
                                ),
                                const Text(
                                  'Погода',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ])),
      bottomNavigationBar: NavigationExample(),
    );
  }
}

class NavigationExample extends StatefulWidget {
  const NavigationExample({super.key});

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  void naveel_home() {
    cout_men = 0;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const MyHomePage(title: 'Анчих')));
  }

  void naveel_news() {
    cout_men = 3;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const MySecondPage(title: 'Новости')));
  }

  void naveel_camera() {
    cout_men = 1;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const MyThirdPage(title: 'Камера')));
  }

  void naveel_tree() {
    cout_men = 2;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                const MyFourPage(title: 'Генеалогическое древо')));
  }

  void naveel_weather() {
    cout_men = 4;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const MyWeatherPage(title: 'Погода')));
  }

  void onItemTapped(index) {
    cout_men = index;
    if (index == 0) {
      naveel_home();
    } else if (index == 1) {
      naveel_camera();
    } else if (index == 2) {
      naveel_tree();
    } else if (index == 3) {
      naveel_news();
    } else if (index == 4) {
      naveel_weather();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      onDestinationSelected: (int index) {
        onItemTapped(index);
      },
      indicatorColor: Colors.amber,
      selectedIndex: cout_men,
      destinations: const <Widget>[
        NavigationDestination(
          selectedIcon: Icon(Icons.home),
          icon: Icon(Icons.home_outlined),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(Icons.camera),
          label: 'Камера',
        ),
        NavigationDestination(
          icon: Icon(Icons.elderly_woman_outlined),
          label: 'Древо',
        ),
        NavigationDestination(
          icon: Icon(Icons.fiber_new_sharp),
          label: 'Новости',
        ),
        NavigationDestination(
          icon: Icon(Icons.cloud_queue_outlined),
          label: 'Погода',
        ),
        NavigationDestination(
          icon: Badge(
            label: Text('new'),
            child: Icon(Icons.messenger_sharp),
          ),
          label: 'смс',
        ),
      ],
    );
  }
}
