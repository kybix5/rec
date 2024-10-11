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
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

int _selectedIndex = 0;
Widget getWidgetForIndex(int index) {
  switch (index) {
    case 0:
      return HomeScreenWidget();
    case 1:
      return CameraScreenWidget();
    case 2:
      return TreeScreenWidget();
    case 3:
      return NewsScreenWidget();
    case 4:
      return WeatherScreenWidget();
    case 5:
      return MessageScreenWidget();
    default:
      return HomeScreenWidget();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  var size, height, width;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Обновляем индекс выбранной вкладки
    });
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
      body: getWidgetForIndex(_selectedIndex), // Получаем виджет по индексу
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
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
