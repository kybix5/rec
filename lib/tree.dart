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

class TreeScreenWidget extends StatefulWidget {
  @override
  _TreeScreenWidgetState createState() => _TreeScreenWidgetState();
}

class _TreeScreenWidgetState extends State<TreeScreenWidget> {
  final _search = TextEditingController();

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
    return Column(
      children: <Widget>[
        Expanded(
          child: ListBuilderState(),
        ),
        TextField(
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
      ],
    );
  }
}

class ListBuilderState extends StatefulWidget {
  const ListBuilderState({super.key});

  @override
  State<ListBuilderState> createState() => _ListBuilderState();
}

class _ListBuilderState extends State<ListBuilderState> {
  Future<String> download() async {
    if (tableObjsJson.length > 1) {
      return Future.value("Data download"); // return your response
    } else {
      var request =
          await HttpClient().getUrl(Uri.parse('https://anchih.e-rec.ru/api'));
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
        Uri.parse('https://anchih.e-rec.ru/api/person?id=' + id_person));
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
                      for (var i = 1; i <= obj_person.length - 1; i++)
                        Card(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(obj_person[i]["kinship"]),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(obj_person[i]["name"]),
                                  const SizedBox(
                                    width: 10,
                                  ),
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
