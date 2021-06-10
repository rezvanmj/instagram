import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram/views/add-post.dart';

class MyActionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.black,
      onPressed: () => Get.to(() => AddPost()),
      child: Icon(Icons.add),
    );
  }
}
