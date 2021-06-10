import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram/controllers/user-controller.dart';
import 'package:instagram/views/widgets/loading-widget.dart';

import 'widgets/user/profile-avatar.dart';
import 'widgets/user/search-for-users-appbar.dart';

class SearchForUsers extends StatefulWidget {
  @override
  _SearchForUsersState createState() => _SearchForUsersState();
}

class _SearchForUsersState extends State<SearchForUsers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: SearchForUsersAppbar(),
        preferredSize: const Size.fromHeight(60),
      ),
      body:
          Obx(() => _userController.loading.isTrue ? Loading() : _usersBody()),
    );
  }

  Widget _usersBody() {
    return ListView.builder(
        itemCount: _userController.users.length,
        itemBuilder: (context, index) {
          return _listTile(index);
        });
  }

  Widget _listTile(int index) {
    return ListTile(
      leading: ProfileAvatar(100, _userController.users[index].imageUrl),
      title: Text(_userController.users[index].username),
      subtitle: Text(_userController.users[index].email),
    );
  }

  UserController get _userController {
    return Get.find<UserController>();
  }
}
