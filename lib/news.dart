import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';

import 'main.dart';
import 'tree.dart';
import 'vlc.dart';
import 'weather.dart';

// новости окно
class MySecondPage extends StatefulWidget {
  const MySecondPage({super.key, required this.title});

  final String title;

  @override
  State<MySecondPage> createState() => _MySecondPageState();
}

class _MySecondPageState extends State<MySecondPage> {
  static String arrayObjsT = '{"news": []}';

  var tableObjsJson = jsonDecode(arrayObjsT)['news'] as List;


  Future<String> download() async {
    var getdata = false;
    var request = await HttpClient()
        .getUrl(Uri.parse('http://45.140.19.137/webtrees/api/news'));
    // sends the request
    var response = await request.close();
    // transforms and prints the response
    await for (var contents in response.transform(Utf8Decoder())) {
      tableObjsJson = jsonDecode(contents)['news'] as List;
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
          return Center(child: Text('Идет загрузка...'));
        } else {
          if (snapshot.hasError)
            return Center(child: Text('Error: ${snapshot.error}'));
          else {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                title: Text(widget.title),
              ),
              body: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: tableObjsJson.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: ListTile(
                        //leading: CircleAvatar(child: Text('C')),
                        title: Text(
                          tableObjsJson[index]["topic_news"] as String,
                          style: const TextStyle(
                              fontSize: 8, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          tableObjsJson[index]["short_news"] as String,
                          style: const TextStyle(fontSize: 8),
                        ),
                        //trailing: Icon(Icons.favorite_rounded),
                        //isThreeLine: true,
                        onTap: () {
                          AlertDialog alert = AlertDialog(
                            title: Column(
                              children: [
                                SingleChildScrollView(
                                  controller: ScrollController(),
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      Card(
                                        child: Image(
                                          image: const NetworkImage(
                                            'http://r.mtdata.ru/c100x100/u26/photo0C7F/20417090821-0/original.jpg',
                                          ),
                                        ),
                                      ),
                                      Card(
                                        child: Image(
                                          image: const NetworkImage(
                                            'http://r.mtdata.ru/c100x100/u26/photo0C7F/20417090821-0/original.jpg',
                                          ),
                                        ),
                                      ),
                                      Card(
                                        child: Image(
                                          image: const NetworkImage(
                                            'http://r.mtdata.ru/c100x100/u26/photo0C7F/20417090821-0/original.jpg',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  tableObjsJson[index]["full_news"],
                                  style: const TextStyle(fontSize: 14),
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
                    );
                  }),
              bottomNavigationBar: NavigationExample(),
            ); // snapshot.data  :- get your object which is pass from your downloadData() function
          }
        }
      },
    );
  }
}
