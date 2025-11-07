import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:g1/pages/mainpage/model/liststdmodel.dart';

class Liststdnotifier extends ChangeNotifier {
  var user;
  var userlist=[];
  var avg=[];
  bool i = true;
  // final Stream<QuerySnapshot> stream = FirebaseFirestore.instance.collection('users').snapshots();

  void fetch() async {
    CollectionReference users = FirebaseFirestore.instance.collection('Students');
    user= await users.get();
    for (var element in user.docs) {
      userlist.add(liststd.fromJson(element.data()));
    }
    for (var element in userlist) {
      avg.add((element.cs+element.iss+element.it+element.ts)/4);
    }
    notifyListeners();
  }

}