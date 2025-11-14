// import 'package:khotwa/providers/login_model.dart';
import 'dart:developer';

import 'package:g1/models/student.dart';
import 'package:g1/pages/authenticate/services/store.dart';
import 'package:provider/provider.dart';

import 'LoginPage.dart';
import 'package:flutter/material.dart';
import 'services/auth.dart';

// ignore: must_be_immutable
class CreateAccountPage extends StatelessWidget {
  CreateAccountPage({super.key});
  final formKey = GlobalKey<FormState>();
  Color myBlack = Color(0xff272727);
  Color lightWhite = Color(0xffF4F4F4);
  Color primary = Color(0xff8E6CEF);
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final csController = TextEditingController();
  final isController = TextEditingController();
  final itController = TextEditingController();
  final tsController = TextEditingController();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final storeProvider = Provider.of<StoreService>(context);
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
            Text(
              "Create Account",
              style: TextStyle(color: myBlack, fontSize: 32),
            ),
            Form(
              key: formKey,
              child: Column(
                spacing: 10,
                children: [
                  TextFormField(
                    keyboardType: TextInputType.name,
                    controller: nameController,
                    decoration: InputDecoration(
                      fillColor: lightWhite,
                      filled: true,
                      labelText: "Name",
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
                  TextFormField(
                    controller: csController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'cs'),
                  ),
                  TextFormField(
                    controller: itController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'it'),
                  ),
                  TextFormField(
                    controller: isController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'is'),
                  ),
                  TextFormField(
                    controller: tsController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'ts'),
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
                  try {
                    
                    final result = await _authService.registerEmailPass(
                    emailController.text,
                    passwordController.text,
                    context,
                  );
                  if (result == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("something went wrong")),
                    );
                  }else{
                    Student student = Student(result.uid,nameController.text, emailController.text, int.parse(csController.text), int.parse(itController.text), int.parse(isController.text), int.parse(tsController.text));
                    storeProvider.addStudent(student);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("تم الحفظ بنجاح"),),
                    );
                  }
                  } catch (e) {
                    log("couldn't do int parse for grades");
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("please enter all fields")),
                    );
                  }
                },
                child: Text(
                  "Continue",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            Text("", style: TextStyle(color: myBlack)),
            Row(
              children: [
                Text("Have account ? ", style: TextStyle(color: myBlack)),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    );
                  },
                  child: Text("login", style: TextStyle(color: primary)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
