import 'package:flutter/material.dart';

class PagenavigatorNotifier extends ChangeNotifier {
int pageindex = 0;
int iconindex = 0;
  void changeindex(int index) {
    this.iconindex = index;
    notifyListeners();
  }
}