import 'package:flutter/material.dart';
import 'package:g1/controller/pagenavigationpro.dart';

import 'package:g1/pages/mainpage/mainpage.dart';
import 'package:g1/pages/students/students_screen.dart';
import 'package:provider/provider.dart';

    
class Base extends StatelessWidget {

  const Base({ Key? key }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final pro =Provider.of<PagenavigatorNotifier>(context);
    const List<Widget> _widgetOptions = <Widget>[
      Mainpage(),
      StudentsScreen(),
    ];
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pro.iconindex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        iconSize: 25,
        onTap: (value) => pro.changeindex(value),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined,),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school_outlined,),
            label: 'Students',
          ),
        ],
      ),
      body: _widgetOptions[pro.pageindex],
    );
  }
}