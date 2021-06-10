import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram/controllers/user-controller.dart';
import 'package:instagram/views/home.dart';
import 'package:instagram/views/profile.dart';
import 'package:instagram/views/widgets/my-action-button.dart';
import 'package:instagram/views/widgets/my-button-appbar.dart';

import 'widgets/user/optional-user-appbar.dart';

class InstagramBody extends StatelessWidget {
  Widget _myAppbar(String title) {
    return AppBar(
      backgroundColor: Colors.blueGrey,
      title: Center(child: Text(title)),
    );
  }

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => UserController());

    return Obx(
      () => Scaffold(
        appBar: PreferredSize(
          child: _userController.mainPageFlag()
              ? _myAppbar('instagram')
              : OptionalAppbar('profile'),
          preferredSize: const Size.fromHeight(60),
        ),
        body: _userController.mainPageFlag() ? Home() : Profile(),
        bottomNavigationBar: MyButtonAppbar(),
        floatingActionButton: MyActionButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  UserController get _userController {
    return Get.find<UserController>();
  }
}
