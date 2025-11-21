import 'package:flutter/material.dart';
import 'package:g1/controller/pagenavigationpro.dart';

import 'package:g1/pages/mainpage/mainpage.dart';
import 'package:g1/pages/students/students_screen.dart';
import 'package:g1/pages/subjects/csui.dart';
import 'package:g1/pages/subjects/isui.dart';
import 'package:g1/pages/subjects/itui.dart';
import 'package:g1/pages/subjects/tsui.dart';
import 'package:provider/provider.dart';

    
class Base extends StatelessWidget {

  const Base({ Key? key }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final pro =Provider.of<PagenavigatorNotifier>(context);
    final List<Widget> _widgetOptions = <Widget>[
      StudentsScreen(),
      const Csui(),
      const Isui(),
      const Itui(),
      const Tsui()
    ];
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pro.iconindex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        iconSize: 25,
        onTap: (value) => pro.changeindex(value),
        items: const <BottomNavigationBarItem>[
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.home_outlined,),
          //   label: 'Home',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school_outlined,),
            label: 'Students',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_objects_outlined,),
            label: 'Cs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.web,),
            label: 'Is',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.network_wifi_sharp,),
            label: 'It',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tv,),
            label: 'Ts',
          ),
        ],
      ),
      body: _widgetOptions[pro.pageindex],
    );
  }
}