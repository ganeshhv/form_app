import 'dart:async';

import 'package:flutter/material.dart';
import 'package:form_app/ui/home_screen.dart';
import 'package:form_app/ui/login_screen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen()
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLogin = false;

  startTime() async {
    getSession();
    var duration = new Duration(seconds: 3);
    return new Timer(duration, route);
  }
  route()
  {
    isLogin ?
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()))
        :
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));

  }
  getSession() async{
    var pref = await SharedPreferences.getInstance();
    isLogin = (await pref.getBool('isLogin'))!;
    print('isLogin: $isLogin');
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTime();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Partner with Us'),
            Padding(
              padding: const EdgeInsets.all(30),
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
                strokeWidth: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
