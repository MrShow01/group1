import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:g1/pages/authenticate/LoginPage.dart';
import 'package:g1/base.dart';
import 'package:g1/pages/mainpage/controller/liststd.dart';
import '/controller/pagenavigationpro.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp( MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => PagenavigatorNotifier()),
    ChangeNotifierProvider(create: (context) => Liststdnotifier()),
  ], child: const MyApp()));

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Login(),
    );
  }
}
