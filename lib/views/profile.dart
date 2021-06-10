import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram/controllers/post-controller.dart';
import 'package:instagram/controllers/user-controller.dart';
import 'package:instagram/controllers/user-post-controller.dart';
import 'package:instagram/views/edit-post.dart';
import 'package:instagram/views/edit-profile.dart';
import 'package:instagram/views/widgets/loading-widget.dart';

import 'widgets/user/profile-avatar.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
    Get.lazyPut(() => UserPostController());
    Get.lazyPut(() => UserController());
    Get.lazyPut(() => PostController());
  }

  @override
  Widget build(BuildContext context) {
    return _profileBody();
  }

  Widget _profileBody() {
    return Obx(
      () => _userController.loading.isTrue
          ? Loading()
          : Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                _profilePicture(),
                _profileUsername(),
                _editProfile(),
                _myDivider(),
                _userPosts(),
              ],
            ),
    );
  }

  Widget _profilePicture() {
    return Center(
        child: ProfileAvatar(100, _userController.loggedInUser().imageUrl));
  }

  Widget _profileUsername() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        _userController.loggedInUser().username,
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _editProfile() {
    return OutlineButton(
      onPressed: () {
        Get.to(() => EditProfile(_userController.loggedInUser()));
      },
      child: Text("edit profile"),
      color: Colors.blueGrey,
      splashColor: Colors.blueGrey,
      focusColor: Colors.blueGrey,
      textColor: Colors.black,
      borderSide: BorderSide(color: Colors.blueGrey),
    );
  }

  Widget _userPosts() {
    return Obx(
      () => _userPostController().loading.isTrue
          ? Loading()
          : Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: _userPostController().loggedInUserPosts().length,
                  itemBuilder: (context, index) {
                    return _postItem(index);
                  }),
            ),
    );
  }

  Widget _postItem(int postIndex) {
    return Stack(
      children: [
        _postImage(postIndex),
        _postButtons(postIndex),
      ],
    );
  }

  Widget _postButtons(int postIndex) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 70),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [_deletePostIcon(postIndex), _editPostIcon(postIndex)],
      ),
    );
  }

  Widget _editPostIcon(int postIndex) {
    return IconButton(
        onPressed: () => _editUserPost(postIndex),
        icon: Icon(
          Icons.edit,
          color: Colors.white60,
          size: 30,
        ));
  }

  Widget _deletePostIcon(int postIndex) {
    return IconButton(
        onPressed: () => _deleteUserPost(postIndex),
        icon: Icon(
          Icons.delete,
          color: Colors.white60,
          size: 30,
        ));
  }

  Widget _postImage(int postIndex) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(_userPostController()
                    .loggedInUserPosts[postIndex]
                    .imageUrl))),
      ),
    );
  }

  void _deleteUserPost(int postIndex) {
    print('delete ${postIndex}');
    print('delete ${_userPostController().loggedInUserPosts()[postIndex].id}');
    _postController()
        .deletePost(_userPostController().loggedInUserPosts()[postIndex]);
    _userPostController().loggedInUserPosts.removeAt(postIndex);
  }

  void _editUserPost(int postIndex) {
    Get.to(EditPost(_userPostController().loggedInUserPosts[postIndex]));
  }

  Widget _myDivider() {
    return Container(
        width: 400,
        child: Divider(
          color: Colors.grey,
        ));
  }

  UserController get _userController {
    return Get.find<UserController>();
  }

  UserPostController _userPostController() {
    return Get.find<UserPostController>();
  }

  PostController _postController() {
    return Get.find<PostController>();
  }
}
