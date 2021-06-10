import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram/controllers/comment-controller.dart';
import 'package:instagram/controllers/user-controller.dart';
import 'package:instagram/models/comment-model.dart';
import 'package:instagram/models/post-model.dart';
import 'package:instagram/views/widgets/loading-widget.dart';
import 'package:instagram/views/widgets/simple-appbar.dart';

import 'widgets/user/profile-avatar.dart';

class CommentPage extends StatelessWidget {
  final PostModel currentPost;
  final TextEditingController commentController = TextEditingController();
  CommentPage(this.currentPost);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => UserController());
    Get.lazyPut(() => CommentController(currentPost.commentsId));
    // Get.lazyPut(() => PostController());
    // _commentController.getPostComments(currentPost.commentsId);

    return Scaffold(
      appBar: PreferredSize(
        child: SimpleAppBar('comments', false),
        preferredSize: const Size.fromHeight(60),
      ),
      body: _commentBody(),
    );
  }

  Widget _commentBody() {
    return Obx(() => _commentController.loading()
        ? Loading()
        : Stack(
            children: [_commentList(), _sendComment()],
          ));
  }

  Widget _commentList() {
    return ListView.builder(
        itemCount: _postCommentCounter(),
        itemBuilder: (context, index) {
          return _commentItem(index);
        });
  }

  Widget _profilePicture(int index) {
    return Padding(
        padding: const EdgeInsets.all(5.0),
        child: ProfileAvatar(
            60,
            _commentController.users()[index].imageUrl ??
                'https://via.placeholder.com/150'));
  }

  Widget _showComment(int index) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(_commentController.comments[index].comment),
    );
  }

  Widget _showUsername(index) {
    return Text(
      '${_commentController.users()[index].username}: ',
      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
    );
  }

  Widget _commentItem(int index) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Row(
              children: [_profilePicture(index), _showUsername(index)],
            ),
            _showComment(index),
            Container(
                width: 400,
                child: Divider(
                  color: Colors.grey,
                )),
          ],
        ),
      ),
    );
  }

  Widget _sendComment() {
    return Positioned(
      bottom: 10.0,
      left: 0.0,
      right: 0.0,
      child: Container(
          decoration: BoxDecoration(
              color: Colors.blueGrey, borderRadius: BorderRadius.circular(10)),
          child: _commentField()),
    );
  }

  Widget _commentField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        validator: (value) => value.isEmpty ? 'fill the field' : null,
        controller: commentController,
        decoration: InputDecoration(
            labelText: 'write a comment',
            labelStyle: TextStyle(color: Colors.white),
            fillColor: Colors.white,
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            suffixIcon: IconButton(
              icon: Icon(
                Icons.send,
                color: Colors.white,
              ),
              onPressed: () {
                _addComment();
              },
            )),
      ),
    );
  }

  void _addComment() {
    CommentModel newComment = CommentModel(
      comment: commentController.text,
      ownerId: _userController.loggedInUser().id,
    );
    _commentController.addComment(newComment, currentPost);

    commentController.text = '';
  }

  String _profileUsername(int commentIndex) {
    String username;
    int commentOwnerId = _commentController.comments[commentIndex].ownerId;
    // _userController.users.forEach((user) {
    //   if (user.id == commentOwnerId) {
    //     username = user.username;
    //   }
    // });
    _commentController.findCommentOwner(commentOwnerId);
    username = _commentController.commentOwner().username;
    return username;
  }

  String _profileImageUrl(int commentIndex) {
    String url;
    int commentOwnerId = _commentController.comments[commentIndex].ownerId;
    // _userController.users.forEach((user) {
    //   if (user.id == commentOwnerId) {
    //     url = user.imageUrl;
    //   }
    // });
    // return url;
    _commentController.findCommentOwner(commentOwnerId);
    url = _commentController.commentOwner().imageUrl ??
        'https://via.placeholder.com/150';
    return url;
  }

  int _postCommentCounter() {
    return _commentController.comments.length;
  }

  CommentController get _commentController {
    return Get.find<CommentController>();
  }

  UserController get _userController {
    return Get.find<UserController>();
  }

  // PostController get _postController {
  //   return Get.find<PostController>();
  // }

}
