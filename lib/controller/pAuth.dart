import 'package:flutter/material.dart';
//provider for authentication
class Pauth extends ChangeNotifier{

  String UIDauthed ="";

  void uIDSet(String uidstr){

    UIDauthed = uidstr;
  }

  String uIDget(){
    return UIDauthed;
  }
}
