import 'package:flutter/material.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // Sayfa içerikleri
  static const List<Widget> _widgetOptions = <Widget>[
    Text('Home Screen', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    Text('Search Screen', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    Text('Profile Screen', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Awesome Bottom Bar with InspiredTop'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomBarInspiredOutside(
              items: const [
                BottomBarItem(icon: Icons.home, label: 'Home'),
                BottomBarItem(icon: Icons.search, label: 'Search'),
                BottomBarItem(icon: Icons.person, label: 'Profile'),  
              ],
              backgroundColor: Colors.deepPurple,
              color: Colors.white,
              colorSelected: Colors.white,
              indexSelected: visit,
              onTap: (int index) => setState(() {
                visit = index;
              }),
              top: -28,
              animated: false,
              itemStyle: ItemStyle.circle,
              chipStyle:const ChipStyle(notchSmoothness: NotchSmoothness.smoothEdge),
            ),
    );
  }
}