import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'login-page.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'instagram',
      home: LoginPage(),
    );
  }
}
