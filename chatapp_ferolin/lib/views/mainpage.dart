import 'package:chatapp_ferolin/views/contacts.dart';
import 'package:chatapp_ferolin/views/profiles.dart';
import 'package:flutter/material.dart';
import '../partials/sizeconfig.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  // static dynamic _argument = 'Default';

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Widget body(){
  //   switch (_selectedIndex) {
  //     case 0:
  //       //Goes to the Chat Page
  //       return ContactPage();
  //       break;
  //     case 1:
  //       //Goes to the Profiles Page
  //       return ProfilePage();
  //       break;
  //   }
  //   // return bodyContent;
  // }

  final tabs = <StatefulWidget>[
    ContactPage(),
    ProfilePage()
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xfff1976d2), 
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline_outlined),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
             icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Color(0xfffA0A0A0),
        showUnselectedLabels: true,
        // unselectedLabelStyle: TextStyle(color: Colors.cyan[300]),
        onTap: _onItemTapped,
      ),
      body: tabs[_selectedIndex],
    );
  }
}