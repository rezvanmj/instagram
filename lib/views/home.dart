import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram/controllers/post-controller.dart';
import 'package:instagram/controllers/user-controller.dart';
import 'package:instagram/models/post-model.dart';
import 'package:instagram/views/comment-page.dart';
import 'package:instagram/views/likers-page.dart';
import 'package:instagram/views/widgets/loading-widget.dart';

import 'widgets/post/expandable-text.dart';
import 'widgets/user/profile-avatar.dart';

class Home extends StatelessWidget {
  String ownerProfilePicture = '';
  String ownerName = '';

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => PostController());
    Get.lazyPut(() => UserController());
    // Get.lazyPut(() => CommentController());

    return Obx(() => _postController.loading.isTrue ? Loading() : _homeBody());
  }

  Widget _homeBody() {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: _postController.posts.length,
        itemBuilder: (context, index) => _postWidget(context, index));
  }

  Widget _postWidget(context, int index) {
    PostModel currentPost = _postController.posts()[index];

    return Column(
      children: [
        _postProfile(currentPost),
        _postImage(currentPost),
        _postCaption(currentPost),
        _postIcons(currentPost),
        _postLikers(index),
        _postDivider(context)
      ],
    );
  }

  void _userInformation(PostModel currentPost) {
    _userController.users().forEach((user) {
      if (user.id == currentPost.ownerId) {
        ownerProfilePicture = user.imageUrl;
        ownerName = user.username;
      }
    });
  }

  Widget _postDivider(context) {
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      child: Divider(color: Colors.grey),
    );
  }

  Widget _postLikers(int index) {
    return GestureDetector(
      onTap: () {
        Get.to(() => LikersPage(index));
      },
      child: Obx(
        () => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                'Likers:',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              Expanded(
                  child: Text(
                      _postController.posts[index].likersId.length.toString()))
            ],
          ),
        ),
      ),
    );
  }

  bool _checkLikers(PostModel currentPost) {
    bool favorite = false;
    currentPost.likersId.forEach((likerId) {
      // _postController().favorite(_userController().loggedInUser().id == likerId) ;
      favorite = _userController.loggedInUser().id == likerId;
    });
    return favorite;
  }

  Widget _heartIcon(PostModel currentPost) {
    return _checkLikers(currentPost)
        ? Icon(Icons.favorite, color: Colors.red, size: 33)
        : Icon(Icons.favorite_border, color: Colors.red, size: 33);
  }

  void _likeToggle(PostModel currentPost) {
    if (_checkLikers(currentPost)) {
      print('unlike');
      currentPost.likersId.removeWhere(
          (likerId) => likerId == _userController.loggedInUser().id);
    } else {
      print('like');
      currentPost.likersId.add(_userController.loggedInUser().id);
    }
    _postController.editPost(currentPost);
  }

  Widget _postIcons(PostModel currentPost) {
    return Row(
      children: [
        IconButton(
          icon: _heartIcon(currentPost),
          onPressed: () {
            _likeToggle(currentPost);
          },
        ),
        IconButton(
          icon: Icon(
            Icons.comment,
            size: 33,
          ),
          onPressed: () {
            //TODO kjhkjhlhljk

            Get.to(() => CommentPage(currentPost));
          },
        )
      ],
    );
  }

  Widget _postImage(PostModel currentPost) {
    String postImageUrl = currentPost.imageUrl;
    return Row(
      children: [
        Expanded(child: Image.network(postImageUrl, fit: BoxFit.cover)),
      ],
    );
  }

  Widget _postProfile(PostModel currentPost) {
    _userInformation(currentPost);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          _profilePicture(),
          SizedBox(
            width: 10,
          ),
          Text(
            ownerName,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
          )
        ],
      ),
    );
  }

  Widget _profilePicture() {
    return ProfileAvatar(70, ownerProfilePicture);
  }

  Widget _postCaption(PostModel currentPost) {
    String caption = currentPost.caption;
    return Row(
      children: [
        Expanded(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ExpandableText(caption, false)),
        ),
      ],
    );
  }

  PostController get _postController {
    return Get.find<PostController>();
  }

  UserController get _userController {
    return Get.find<UserController>();
  }

  // CommentController get _commentController {
  //   return Get.find<CommentController>();
  // }
}
