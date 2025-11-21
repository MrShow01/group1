import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:g1/base.dart';
import 'package:g1/pages/authenticate/LoginPage.dart';
import 'package:g1/pages/authenticate/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:g1/controller/pAuth.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  final AuthService _authService = AuthService();
  String? _lastUserUid;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    log("wrapper listening user: $user");

    if (user == null) {
      _lastUserUid = null;
      return Login();
    } else {
      // Set the UID in Pauth provider when user is detected
      // Check if this is a new user or UID hasn't been set yet
      if (_lastUserUid != user.uid) {
        final pauth = Provider.of<Pauth>(context, listen: false);
        // Always update if UID is empty or different from current user
        if (pauth.UIDauthed != user.uid && user.uid.isNotEmpty) {
          pauth.uIDSet(user.uid);
          log("UID set in Wrapper: ${user.uid}");
          _lastUserUid = user.uid;
        }
      }
      return Base();
    }
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
