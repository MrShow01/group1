import 'package:activity/features/home/widgets/custom_field.dart';
import 'package:activity/shared/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

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

  @override
  Widget build(BuildContext context) {
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
              CustomButton(text: "update", onTap: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
