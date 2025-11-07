import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:g1/base.dart';
import 'package:g1/pages/authenticate/LoginPage.dart';
import 'package:g1/pages/authenticate/services/auth.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    log("wrapper listening user: $user");

    if(user == null ) return Login();
    else return Base();
  }
  // @override
  // Widget build(BuildContext context) {
  //   return StreamBuilder<User?>(
  //     stream: _authService.user, // ← بنسمع حالة المستخدم هنا
  //     builder: (context, snapshot) {
  //       // لسه بيتحقق من الحالة
  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         return const Center(child: CircularProgressIndicator());
  //       }
  //       // المستخدم موجود → الصفحة الرئيسية
  //       if (snapshot.hasData) {
  //         log("returned in wrapper: "+snapshot.toString());
  //         return Base();
  //       }
  //       log("Didn't return user in wrapper");
  //       // مافيش مستخدم → صفحة التسجيل
  //       return Login();
  //     },
  //   );
  // }
}
