import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';

import 'main.dart';
import 'tree.dart';
import 'vlc.dart';
import 'news.dart';

// погода окно
class MyWeatherPage extends StatefulWidget {
  const MyWeatherPage({super.key, required this.title});

  final String title;

  @override
  State<MyWeatherPage> createState() => _MyWeatherPageState();
}

class _MyWeatherPageState extends State<MyWeatherPage> {
  static String arrayObjsT = '{"weather": []}';

  var tableObjsJson = jsonDecode(arrayObjsT)['weather'] as List;

  void update() async {
    setState(() {});
  }

  void naveel_home() {
    cout_men = 0;
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => MyHomePage(title: 'Анчих')));
  }

  void naveel_news() {
    cout_men = 3;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MySecondPage(title: 'Новости')));
  }

  void naveel_camera() {
    cout_men = 1;
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => MyThirdPage(title: 'Камера')));
  }

  void naveel_tree() {
    cout_men = 2;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MyFourPage(title: 'Генеалогическое древо')));
  }

  void naveel_weather() {
    cout_men = 4;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MyWeatherPage(title: 'Погода')));
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

  Future<String> download() async {
    var getdata = false;
    var request = await HttpClient()
        .getUrl(Uri.parse('http://45.140.19.137/webtrees/api/weather'));
    // sends the request
    var response = await request.close();
    // transforms and prints the response
    await for (var contents in response.transform(Utf8Decoder())) {
      tableObjsJson = jsonDecode(contents)['weather'] as List;
      var getdata = true;
    }
    return Future.value("Data download"); // return your response
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: download(), // function where you call your api
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        // AsyncSnapshot<Your object type>
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: Text('Идет загрузка'));
        } else {
          if (snapshot.hasError)
            return Center(child: Text('Error: ${snapshot.error}'));
          else {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                title: Text(widget.title),
              ),
              body: Center(
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: update,
                      child: const Text('Обновить'),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                          child: Column(
                        children: [
                          for (final word in tableObjsJson)
                            Column(
                              children: [
                                ListTile(
                                  //leading: CircleAvatar(child: Text('C')),
                                  title: Text(
                                    word["city"] as String,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Row(
                                    //mainAxisAlignment:MainAxisAlignment.center, //центру
                                    children: [
                                      Text(
                                        word["temperature"] as String,
                                        style: TextStyle(fontSize: 24),
                                      ),
                                      Text(
                                        word["short"] as String,
                                        style: const TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  //trailing: Icon(Icons.favorite_rounded),
                                  //isThreeLine: true,
                                  onTap: () {
                                    AlertDialog alert = AlertDialog(
                                      title: Text(
                                        word["short"],
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    );
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return alert;
                                      },
                                    );
                                  },
                                ),
                                const Divider(
                                  //height: 20,
                                  indent: 0,
                                  endIndent: 0,
                                  color: Colors.black,
                                  //thickness: 2,
                                ),
                              ],
                            ),
                        ],
                      )),
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.shifting,
                selectedFontSize: 20,
                selectedIconTheme: IconThemeData(color: Colors.amberAccent),
                selectedItemColor: Colors.amberAccent,
                selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: "Home ",
                    backgroundColor: Colors.blue,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.camera),
                    label: "камера",
                    backgroundColor: Colors.blue,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.elderly_woman_outlined),
                    label: "Древо",
                    backgroundColor: Colors.blue,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.fiber_new_sharp),
                    label: "Новости",
                    backgroundColor: Colors.blue,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.cloud_queue_outlined),
                    label: "Погода",
                    backgroundColor: Colors.blue,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.settings),
                    label: "settings",
                    backgroundColor: Colors.blue,
                  ),
                ],
                currentIndex: cout_men,
                onTap: onItemTapped,
                // selectedItemColor: Colors.amber[800],
              ),
            ); // snapshot.data  :- get your object which is pass from your downloadData() function
          }
        }
      },
    );
  }
}
