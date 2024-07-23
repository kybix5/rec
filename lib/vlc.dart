import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

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

  final VlcPlayerController _videoPlayerController =
      VlcPlayerController.network(
    //'https://media.w3.org/2010/05/sintel/trailer.mp4',
    'rtsp://46.16.226.6:554/user=user&password=&channel=1&stream=0',
    hwAcc: HwAcc.full,
    autoPlay: true,
    options: VlcPlayerOptions(),
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
