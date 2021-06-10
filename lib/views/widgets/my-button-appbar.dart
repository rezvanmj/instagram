import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram/controllers/user-controller.dart';
import 'package:instagram/views/widgets/loading-widget.dart';

class MyButtonAppbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => UserController());

    return BottomAppBar(
      color: Colors.blueGrey,
      shape: CircularNotchedRectangle(),
      notchMargin: 5,
      clipBehavior: Clip.antiAlias,
      child: Obx(
          () => _userController.loading.isTrue ? Loading() : _myBottomAppbar()),
    );
  }

  Widget _myBottomAppbar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [_homeIconButton(), _profileIconButton()],
    );
  }

  Widget _homeIconButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: IconButton(
          onPressed: () => _userController.mainPageFlag(true),
          icon: Icon(
            Icons.home,
            size: 40,
            color: Colors.white,
          )),
    );
  }

  Widget _profileIconButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: IconButton(
          onPressed: () {
            _userController.mainPageFlag(false);
          },
          icon: Icon(
            Icons.person,
            size: 40,
            color: Colors.white,
          )),
    );
  }

  UserController get _userController {
    return Get.find<UserController>();
  }
}
