import 'dart:developer';

import 'AccountPage.dart';
// import '/home/home.dart';
import 'services/auth.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:get_android/services/messaging.dart';

// import 'package:firebase_core/firebase_core.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// ignore: must_be_immutable
class Login extends StatelessWidget {
  Login({super.key});
  final formKey = GlobalKey<FormState>();
  Color myBlack = Color(0xff272727);
  Color lightWhite = Color(0xffF4F4F4);
  Color primary = Color(0xff8E6CEF);
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final csController = TextEditingController();
  final isController = TextEditingController();
  final itController = TextEditingController();
  final tsController = TextEditingController();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: 15,
          right: 15,
          top: MediaQuery.of(context).viewPadding.top,
        ),
        child: Column(
          spacing: 20,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            Text("Sign in", style: TextStyle(color: myBlack, fontSize: 32)),
            Form(
              key: formKey,
              child: Column(
                spacing: 10,
                children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    decoration: InputDecoration(
                      fillColor: lightWhite,
                      filled: true,
                      labelText: "Email Address",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: primary),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                    ),
                    style: TextStyle(color: primary, fontSize: 16),
                  ),

                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    controller: passwordController,
                    decoration: InputDecoration(
                      fillColor: lightWhite,
                      filled: true,
                      labelText: "Enter your password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: primary),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                    ),
                    style: TextStyle(color: primary, fontSize: 16),
                  ),
                  
                ],
              ),
            ),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary,
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () async {
                  final user = await _authService.signinEmailPass(
                    emailController.text,
                    passwordController.text,
                    context,
                  );
                  if (user == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("something went wrong"),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  } else {
                    log(
                      "my normal user : $user , with id: ${user.uid}, email:${user.email}",
                    );
                  }
                },
                child: Text(
                  "Continue",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            // Text(loginWatch.massage, style: TextStyle(color: myBlack)),
            Text("Dont have an Account ? ", style: TextStyle(color: myBlack)),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateAccountPage()),
                );
              },
              child: Text("Create One", style: TextStyle(color: primary)),
            ),
          ],
        ),
      ),
    );
  }
}
