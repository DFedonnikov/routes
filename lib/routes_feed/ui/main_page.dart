import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:routes/routes_feed/ui/feed_widgets.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: _getNavigationItems(),
        onTap: (index) => _switchTab(index),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Color.fromARGB(194, 12, 48, 222),
        unselectedItemColor: Color.fromARGB(255, 0, 0, 0),
      ),
    );
  }

  List<BottomNavigationBarItem> _getNavigationItems() {
    return [
      BottomNavigationBarItem(icon: Icon(Icons.swap_calls), title: Text('')),
      BottomNavigationBarItem(icon: Icon(Icons.favorite), title: Text('')),
      BottomNavigationBarItem(icon: Icon(Icons.person), title: Text(''))
    ];
  }

  _switchTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget _getScreen() {
    switch (_currentIndex) {
      case 0:
        return MainFeedWidget();
      default:
        return MainFeedWidget();
    }
  }
}
