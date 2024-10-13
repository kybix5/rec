import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';

import 'main.dart';
import 'tree.dart';
import 'vlc.dart';
import 'news.dart';

class WeatherScreenWidget extends StatefulWidget {
  final Function(int) onTabChanged;

  WeatherScreenWidget({required this.onTabChanged});
  @override
  _WeatherScreenWidgetState createState() => _WeatherScreenWidgetState();
}

class _WeatherScreenWidgetState extends State<WeatherScreenWidget> {
  static String arrayObjsT = '{"weather": []}';

  var tableObjsJson = jsonDecode(arrayObjsT)['weather'] as List;

  Future<String> download() async {
    var getdata = false;
    var request = await HttpClient()
        .getUrl(Uri.parse('https://anchih.e-rec.ru/api/weather'));
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
            return Center(
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: tableObjsJson.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: Column(
                        children: [
                          ListTile(
                            //leading: CircleAvatar(child: Text('C')),
                            title: Column(
                              children: [
                                Text(
                                  tableObjsJson[index]["city"] as String,
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  tableObjsJson[index]["temperature"] as String,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            subtitle: Center(
                              child: Text(
                                tableObjsJson[index]["short"] as String,
                                style: const TextStyle(fontSize: 8),
                              ),
                            ),

                            //trailing: Icon(Icons.favorite_rounded),
                            //isThreeLine: true,
                            onTap: () {
                              AlertDialog alert = AlertDialog(
                                title: Column(
                                  children: [
                                    Text(
                                      tableObjsJson[index]["temperature"]
                                          as String,
                                      style: const TextStyle(fontSize: 24),
                                    ),
                                    Text(
                                      tableObjsJson[index]["short"] as String,
                                      style: const TextStyle(fontSize: 24),
                                    ),
                                  ],
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
                        ],
                      ),
                    );
                  }),
            );
          }
        }
      },
    );
  }
}
