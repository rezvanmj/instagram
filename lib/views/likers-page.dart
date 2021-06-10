import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram/controllers/post-controller.dart';
import 'package:instagram/controllers/user-controller.dart';
import 'package:instagram/views/widgets/simple-appbar.dart';

import 'widgets/user/profile-avatar.dart';

class LikersPage extends StatelessWidget {
  final int postIndex;
  LikersPage(this.postIndex);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => PostController());
    Get.lazyPut(() => UserController());

    return Scaffold(
      appBar: PreferredSize(
        child: SimpleAppBar('likers', false),
        preferredSize: const Size.fromHeight(60),
      ),
      body: _likersBody(),
    );
  }

  String _showUsername(int likerIndex) {
    String username = '';
    _userController().users().forEach((user) {
      if (user.id == _postController().posts()[postIndex].likersId[likerIndex])
        username = user.username;
    });
    return username;
  }

  String _showEmail(int likerIndex) {
    String email = '';
    _userController().users().forEach((user) {
      if (user.id == _postController().posts()[postIndex].likersId[likerIndex])
        email = user.email;
    });
    return email;
  }

  Widget _likersBody() {
    return ListView.builder(
        itemCount: _postController().posts()[postIndex].likersId.length,
        itemBuilder: (context, index) {
          return _myListTile(index);
        });
  }

  Widget _myListTile(int index) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: ListTile(
          subtitle: Text(_showEmail(index)),
          leading: _profilePicture(index),
          title: Text(_showUsername(index)),
        ),
      ),
    );
  }

  Widget _profilePicture(int likerIdIndex) {
    return ProfileAvatar(100, _profileUrl(likerIdIndex));
  }

  String _profileUrl(int likerIdIndex) {
    String url;
    _userController().users().forEach((user) {
      if (user.id ==
          _postController().posts()[postIndex].likersId[likerIdIndex])
        url = user.imageUrl;
    });
    return url;
  }

  PostController _postController() {
    return Get.find<PostController>();
  }

  UserController _userController() {
    return Get.find<UserController>();
  }
}
