import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
//import 'package:flutter_vlc_player/src/vlc_player_controller.dart';

import 'main.dart';
import 'tree.dart';
import 'news.dart';
import 'weather.dart';

// vlc окно
class MyThirdPage extends StatefulWidget {
  const MyThirdPage({super.key, required this.title});

  final String title;

  @override
  State<MyThirdPage> createState() => _MyThirdPageState();
}

class _MyThirdPageState extends State<MyThirdPage> {
  // Future<void> initializePlayer() async {}
  bool _isPlaying = true;
  String _icon = "play_arrow";

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

  final VlcPlayerController _videoPlayerController =
      VlcPlayerController.network(
    //'https://media.w3.org/2010/05/sintel/trailer.mp4',
    'rtsp://46.16.226.6:554/user=user&password=&channel=1&stream=0',
    //hwAcc: HwAcc.full,
    autoPlay: true,
    // options: VlcPlayerOptions(),
  );

  late Color _buttonColor_play = Colors.green;
  late Color _buttonColor_pause = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Center(
            child: VlcPlayer(
              controller: _videoPlayerController,
              aspectRatio: 16 / 9,
              placeholder: Center(child: CircularProgressIndicator()),
            ),
          ),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    _buttonColor_play = Colors.green;
                    _buttonColor_pause = Colors.black;
                    _isPlaying = true;
                    _videoPlayerController.play();
                  });
                },
                child:
                    Icon(Icons.play_arrow, size: 28, color: _buttonColor_play),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _buttonColor_pause = Colors.green;
                    _buttonColor_play = Colors.black;
                    _isPlaying = false;
                    _videoPlayerController.pause();
                  });
                },
                child: Icon(Icons.pause, size: 28, color: _buttonColor_pause),
              ),
            ],
          )
        ],
      ),
      bottomNavigationBar: NavigationExample(),
    );
  }
}
