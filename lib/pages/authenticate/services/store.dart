import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '/models/student.dart';

class StoreService extends ChangeNotifier {
  CollectionReference users = FirebaseFirestore.instance.collection(
    "Students",
  );
  // CollectionReference myUsers = FirebaseFirestore.instance.collection("Students");
  List<Student> userList = [];

  Future<void> addStudent(Student myUser) async {
    // remove @gmail.com from email
    String docName = myUser.email.split("@")[0];
    users
        .doc(docName)
        .set({
          "email": myUser.email,
          "name": myUser.name,
          "cs": myUser.csGrade,
          "it": myUser.itGrade,
          "is": myUser.isGrade,
          "ts": myUser.tsGrade,
        })
        .then((value) {
          log("User Saved: $docName");
        })
        .catchError((error) {
          log("Failed to save user data to firestore: $error");
        });
  }

  void getStudentsData() async {
    final QuerySnapshot snapshot = await users.get();
    userList.clear();
    for (var doc in snapshot.docs) {
      userList.add(
        Student(doc["name"], doc["email"], doc["cs"], doc["is"], doc["it"], doc["ts"]),
      );
    }
    notifyListeners();
  }

  Future<void> remove_user(String docID) async {
    await users.doc(docID).delete();
  }
}
