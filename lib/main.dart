import 'package:flutter/material.dart';

import 'home.dart'; // Импортируем файл с виджетами
import 'tree.dart';
import 'vlc.dart';
import 'news.dart';
import 'weather.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bottom Navigation Bar Example',
      home: BottomNavExample(),
    );
  }
}

class BottomNavExample extends StatefulWidget {
  @override
  _BottomNavExampleState createState() => _BottomNavExampleState();
}

class _BottomNavExampleState extends State<BottomNavExample> {
  int _currentIndex = 0;

  var size, height, width;

  void _onTabChanged(int index) {
    setState(() {
      _currentIndex = index; // Обновляем индекс выбранной вкладки
    });
  }

  // Список экранов
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      HomeScreenWidget(onTabChanged: _onTabChanged),
      CameraScreenWidget(onTabChanged: _onTabChanged),
      TreeScreenWidget(onTabChanged: _onTabChanged),
      NewsScreenWidget(onTabChanged: _onTabChanged),
      WeatherScreenWidget(onTabChanged: _onTabChanged),
      MessageScreenWidget(onTabChanged: _onTabChanged),
    ];
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
        title: Text('Анчих'),
      ),
      drawer: myDrawer,
      body: _screens[_currentIndex], // Получаем виджет по индексу
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            backgroundColor: Colors.green,
            label: 'Главная',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera),
            backgroundColor: Colors.green,
            label: 'Камера',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            backgroundColor: Colors.green,
            label: 'Древо',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fiber_new_sharp),
            backgroundColor: Colors.green,
            label: 'Новости',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cloud_queue_outlined),
            backgroundColor: Colors.green,
            label: 'Погода',
          ),
          BottomNavigationBarItem(
            icon: Badge(
              label: Text('new'),
              backgroundColor: Colors.green,
              child: Icon(Icons.messenger_sharp),
            ),
            label: 'смс',
          ),
        ],
        currentIndex: _currentIndex,
        selectedItemColor: Colors.blue,
        onTap: _onTabChanged,
      ),
    );
  }
}
