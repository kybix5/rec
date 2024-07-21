import 'package:flutter/material.dart';
import 'package:rec/vlc.dart';
import 'dart:io';
import 'dart:convert';

import 'main.dart';
import 'vlc.dart';
import 'news.dart';
import 'weather.dart';

String arrayObjsT = '{"table": []}';
var tableObjsJson = jsonDecode(arrayObjsT)['table'] as List;
var tableTemp = jsonDecode(arrayObjsT)['table'] as List;
var obj_person = jsonDecode(arrayObjsT)['table'] as List;

// древо окно
class MyFourPage extends StatefulWidget {
  const MyFourPage({super.key, required this.title});

  final String title;

  @override
  State<MyFourPage> createState() => _MyFourPageState();
}

class _MyFourPageState extends State<MyFourPage> {
  // static String arrayObjsT = '{"table": []}';

  final _search = TextEditingController();

  //var tableObjsJson = jsonDecode(arrayObjsT)['table'] as List;

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

  //var tableTemp = jsonDecode(arrayObjsT)['table'] as List;

  void onQueryChanged(String query) {
    print(_search.text);
    String myString = 'Hello';

    tableTemp.clear();

    for (int i = 0; i < tableObjsJson.length; i++) {
      myString = tableObjsJson[i]["name"];
      if (myString.contains(_search.text)) {
        tableTemp.add({
          "n_id": tableObjsJson[i]["n_id"],
          "name": tableObjsJson[i]["name"],
          "age": tableObjsJson[i]["age"],
          "birthday": tableObjsJson[i]["birthday"]
        });
      }
    }
    print(tableTemp);
    setState(() {
      _ListBuilderState;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: TextField(
          controller: _search,
          onChanged: onQueryChanged,
          cursorColor: Colors.grey,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none),
            hintText: 'Поиск..',
            hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
            prefixIcon: Container(
              padding: EdgeInsets.all(15),
              child: Icon(Icons.search),
              width: 12,
              height: 5,
            ),
          ),
        ),
      ),
      body: _ListBuilderState(),
      bottomNavigationBar: NavigationExample(),
    );
  }
}

class _ListBuilderState extends StatelessWidget {
  Future<String> download() async {
    if (tableObjsJson.length > 1) {
      return Future.value("Data download"); // return your response
    } else {
      var request = await HttpClient()
          .getUrl(Uri.parse('http://45.140.19.137/webtrees/api'));
      // sends the request
      var response = await request.close();
      // transforms and prints the response
      await for (var contents in response.transform(Utf8Decoder())) {
        tableObjsJson = jsonDecode(contents)['table'] as List;
        tableTemp = jsonDecode(contents)['table'] as List;
      }
      return Future.value("Data download"); // return your response
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: download(), // function where you call your api
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          // AsyncSnapshot<Your object type>
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Text('Идет загрузка...'));
          } else {
            if (snapshot.hasError)
              return Center(child: Text('Error: ${snapshot.error}'));
            else {
              return Center(
                child: ListView.builder(
                  padding: EdgeInsets.all(8),
                  itemCount: tableTemp.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: ListTile(
                        leading: Icon(Icons.man),
                        title: Text(tableTemp[index]["name"]),
                        // ignore: prefer_interpolation_to_compose_strings
                        subtitle: Text(
                          "${"Возрасть:" + tableTemp[index]["age"]} год.рождения:" +
                              tableTemp[index]["birthday"],
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.info),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return _alert_list(tableTemp[index]["n_id"]);
                                });
                          },
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          }
        });
  }
}

class _alert_list extends StatelessWidget {
  String id_person;
  _alert_list(this.id_person);

  Future<String> get_person() async {
    var request = await HttpClient().getUrl(
        Uri.parse('http://45.140.19.137/webtrees/api/person?id=' + id_person));
    // sends the request
    var response = await request.close();
    // transforms and prints the response
    await for (var contents in response.transform(Utf8Decoder())) {
      obj_person = jsonDecode(contents)['person'] as List;
    }
    return Future.value("Data download"); // return your response
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: get_person(), // function where you call your api
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          // AsyncSnapshot<Your object type>
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Text('Идет загрузка...'));
          } else {
            if (snapshot.hasError)
              return Center(child: Text('Error: ${snapshot.error}'));
            else {
              return AlertDialog(
                title: Center(
                  child: Column(
                    children: [
                      Text(obj_person[0]["name"]),
                      //for (final word in obj_person)
                      for (var i = 1; i <= obj_person.length-1; i++)
                        Card(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(obj_person[i]["kinship"]),
                                  const SizedBox(width: 10,),
                                  Text(obj_person[i]["name"]),
                                  const SizedBox(width: 10,),
                                  InkWell(
                                    child: const Icon(Icons.info),
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return _alert_list(
                                                obj_person[i]["n_id"]);
                                          });
                                    },
                                  ),
                                ],
                              ),
                              Text(
                                obj_person[i]["birthday"],
                                style: const TextStyle(fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              );
            }
          }
        });
  }
}
