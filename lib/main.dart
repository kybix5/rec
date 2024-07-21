import 'package:flutter/material.dart';
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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Center(
          child: Text(widget.title),
        ),
      ),
      body: Center(
        //Padding ( padding: EdgeInsets.all(40))
        child: Column(
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
                    width: width / 2.5,
                    height: height / 3,
                    child: Material(
                      color: Colors.blue,
                      elevation: 8,
                      borderRadius: BorderRadius.circular(28),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: InkWell(
                        splashColor: Colors.black,
                        onTap: naveel_camera,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Ink.image(
                              image: const NetworkImage(
                                "https://parik123.nethouse.ru/static/img/0000/0007/4203/74203883.jjd8539p5b.W665.jpg",
                              ),
                              height: height / 4,
                              width: width / 3,
                            ),
                            const Text(
                              'Камера',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ],
                        ),
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
                    width: width / 2.5,
                    height: height / 3,
                    child: Material(
                      color: Colors.blue,
                      elevation: 8,
                      borderRadius: BorderRadius.circular(28),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: InkWell(
                        splashColor: Colors.black,
                        onTap: naveel_tree,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Ink.image(
                              image: const NetworkImage(
                                "https://flomaster.top/uploads/posts/2023-10/1697495070_flomaster-top-p-drevo-rodoslovnoe-risunok-instagram-2.jpg",
                              ),
                              height: height / 4,
                              width: width / 3,
                            ),
                            const Text(
                              'Древо',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ],
                        ),
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
                    width: width / 2.5,
                    height: height / 3,
                    child: Material(
                      color: Colors.blue,
                      elevation: 8,
                      borderRadius: BorderRadius.circular(28),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: InkWell(
                        splashColor: Colors.black,
                        onTap: naveel_news,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Ink.image(
                              image: const NetworkImage(
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTlsFj9c_fnn37WyQR0aqNNb3o3rRvjc9SYqhlKFMywtjbjrcIxJHLxsJs2akLOL7HvxJo&usqp=CAU",
                              ),
                              height: height / 4,
                              width: width / 3,
                            ),
                            const Text(
                              'Новости',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ],
                        ),
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
                    width: width / 2.5,
                    height: height / 3,
                    child: Material(
                      color: Colors.blue,
                      elevation: 8,
                      borderRadius: BorderRadius.circular(28),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: InkWell(
                        splashColor: Colors.black,
                        onTap: naveel_weather,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Ink.image(
                              image: const NetworkImage(
                                "https://play-lh.googleusercontent.com/yXfCpQijMAa6f4thnannzhFNXsk9w-uj0W6rOM4hPaZ2pGqClRDWSfMk4yYzqtqR1-FH",
                              ),
                              height: height / 4,
                              width: width / 3,
                            ),
                            const Text(
                              'Погода',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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
          label: 'Home1',
        ),
        NavigationDestination(
          icon: Icon(Icons.camera),
          label: 'Камера1',
        ),
        NavigationDestination(
          icon: Icon(Icons.elderly_woman_outlined),
          label: 'Древо1',
        ),
        NavigationDestination(
          icon: Icon(Icons.fiber_new_sharp),
          label: 'Новости',
        ),
        NavigationDestination(
          icon: Icon(Icons.cloud_queue_outlined),
          label: 'Погода1',
        ),
        NavigationDestination(
          icon: Badge(
            label: Text('2'),
            child: Icon(Icons.messenger_sharp),
          ),
          label: 'смс1',
        ),
      ],
    );
  }
}
