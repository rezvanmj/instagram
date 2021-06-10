import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram/controllers/user-controller.dart';
import 'package:instagram/views/login-page.dart';
import 'package:instagram/views/search-for-users.dart';

class OptionalAppbar extends StatefulWidget {
  final String title;
  OptionalAppbar(this.title);
  @override
  _OptionalAppbarState createState() => _OptionalAppbarState();

  Size get preferredSize => const Size.fromHeight(100);
}

class _OptionalAppbarState extends State<OptionalAppbar> {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => UserController());
    return _myAppbar();
  }

  Widget _myAppbar() {
    return AppBar(
      backgroundColor: Colors.blueGrey,
      leading:
          IconButton(onPressed: () => _myDialog(), icon: Icon(Icons.logout)),
      title: Center(child: Text(widget.title)),
      actions: [
        IconButton(
            onPressed: () => Get.to(() => SearchForUsers()),
            icon: Icon(Icons.search))
      ],
    );
  }

  Future<void> _myDialog() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'you wanna logout ?',
              style: TextStyle(color: Colors.blueGrey),
            ),
            actions: [_dialogYesButton(), _dialogNoButton()],
          );
        });
  }

  Widget _dialogNoButton() {
    return TextButton(
        onPressed: () => Get.back(),
        child: Text(
          'no',
          style: TextStyle(color: Colors.black),
        ));
  }

  Widget _dialogYesButton() {
    return TextButton(
        onPressed: () {
          Get.offAll(() => LoginPage());
        },
        child: Text(
          'yea',
          style: TextStyle(color: Colors.black),
        ));
  }

  UserController get _userController {
    return Get.find<UserController>();
  }
}
