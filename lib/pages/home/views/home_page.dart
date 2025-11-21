import 'package:flutter/material.dart';
import 'package:g1/models/student.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../controller/pAuth.dart';
import '../../authenticate/services/store.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final csController = TextEditingController();
  final isController = TextEditingController();
  final itController = TextEditingController();
  final tsController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final pauth = Provider.of<Pauth>(context, listen: false).UIDauthed;
    final UpdateFunc = Provider.of<StoreService>(context);

    return Scaffold(
      backgroundColor: Color(0xffF9F8F6),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 80.0, horizontal: 15),
          child: Column(
            children: [
              Center(
                child: Text(
                  "Update page",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              Gap(50),
              Text(
                "Student name",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              Gap(30),
              Row(
                children: [
                  Expanded(
                    child: CustomField(label: "Cs", controller: csController),
                  ),
                  Gap(10),
                  Expanded(
                    child: CustomField(label: "Is", controller: isController),
                  ),
                ],
              ),
              Gap(20),
              Row(
                children: [
                  Expanded(
                    child: CustomField(label: "It", controller: itController),
                  ),
                  Gap(10),
                  Expanded(
                    child: CustomField(label: "Ts", controller: tsController),
                  ),
                ],
              ),
              Gap(20),
              CustomButton(
                text: "update",
                onTap: () async {
                  try {
                    // Get current user's data automatically
                    final currentUser = FirebaseAuth.instance.currentUser;
                    if (currentUser == null ||
                        currentUser.email == null ||
                        currentUser.email!.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("No authenticated user found"),
                        ),
                      );
                      return;
                    }

                    // Validate that all fields are filled
                    if (csController.text.isEmpty ||
                        itController.text.isEmpty ||
                        isController.text.isEmpty ||
                        tsController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please enter all grade fields"),
                        ),
                      );
                      return;
                    }

                    // Get student name from Firestore
                    String docName = currentUser.email!.split("@")[0];
                    final docSnapshot = await FirebaseFirestore.instance
                        .collection("Students")
                        .doc(docName)
                        .get();

                    String studentName =
                        docSnapshot.data()?["name"] ??
                        currentUser.displayName ??
                        "Student";

                    Student student = Student(
                      currentUser.uid,
                      studentName,
                      currentUser.email!,
                      int.parse(csController.text),
                      int.parse(itController.text),
                      int.parse(isController.text),
                      int.parse(tsController.text),
                    );
                    UpdateFunc.updateStudent(student);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Student updated successfully"),
                      ),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Please enter valid numbers for all grades",
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
