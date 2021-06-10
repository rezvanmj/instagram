import 'package:flutter/material.dart';

class SimpleAppBar extends StatelessWidget {
  final String title;
  final bool centerFlag;
  SimpleAppBar(this.title, this.centerFlag);

  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blueGrey,
      title: centerFlag ? Center(child: Text(title)) : Text(title),
    );
  }
}
