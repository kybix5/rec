import 'package:flutter/material.dart';
import 'main.dart';
import 'vlc.dart';
import 'news.dart';
import 'weather.dart';
import 'tree.dart';

class HomeScreenWidget extends StatefulWidget {
  @override
  _HomeScreenWidgetState createState() => _HomeScreenWidgetState();
}

class _HomeScreenWidgetState extends State<HomeScreenWidget> {
  void naveel_camera() {
    CameraScreenWidget();
  }

  var size, height, width;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;

    return Center(
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
                          // onTap: naveel_tree,
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
                          //onTap: naveel_news,
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
                          //onTap: naveel_weather,
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
    ]));
  }
}

class MessageScreenWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Сообщения',
          style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    );
  }
}
