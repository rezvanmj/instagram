import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram/views/login-page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  timer() {
    var _duration = Duration(seconds: 4);
    return Timer(_duration, navigation);
  }

  navigation() {
    Get.off(LoginPage());
  }

  @override
  void initState() {
    super.initState();
    timer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _splashBody());
  }

  Widget _splashBody() {
    return Container(
      color: Colors.blueGrey,
      child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image.network('https://img.icons8.com/clouds/2x/instagram-new.png'),
        Text('from TAAVSYS',
            style: TextStyle(color: Colors.white, fontSize: 20))
      ])),
    );
  }
}
