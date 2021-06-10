import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram/controllers/post-controller.dart';
import 'package:instagram/controllers/user-controller.dart';
import 'package:instagram/models/post-model.dart';

import '../../instagram-body.dart';

class AddEditPost extends StatefulWidget {
  final bool isEditing;
  final PostModel editingPost;

  AddEditPost({this.isEditing, this.editingPost});

  @override
  _AddEditPostState createState() => _AddEditPostState();
}

class _AddEditPostState extends State<AddEditPost> {
  final TextEditingController captionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  final String imagePath =
      'https://www.sciencemag.org/sites/default/files/styles/article_main_large/public/cat_1280p_0.jpg?itok=MFUV0a-t';

  initController() {
    if (widget.isEditing) captionController.text = widget.editingPost.caption;
  }

  @override
  void initState() {
    super.initState();
    Get.lazyPut(() => PostController());
    Get.lazyPut(() => UserController());

    initController();
  }

  @override
  Widget build(BuildContext context) {
    return _addEditPostBody();
  }

  Widget _addEditPostBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _postImage(),
        _postCaption(),
        SizedBox(
          height: 20,
        ),
        _postButton(),
      ],
    );
  }

  // _getFromGallery() async {
  //   PickedFile pickedFile = await ImagePicker().getImage(
  //     source: ImageSource.gallery,
  //   );
  //   if (pickedFile != null) {
  //     imagePath = pickedFile.path;
  //   }
  // }

  void _navigate() {
    Get.offAll(() => InstagramBody());
    if (widget.isEditing) {
      Get.snackbar('post edited', '');
    } else {
      Get.snackbar('post added', '');
    }
  }

  void _addPost() async {
    if (_formKey.currentState.validate()) {
      PostModel newPost = PostModel(
          imageUrl: imagePath,
          caption: captionController.text,
          ownerId: _userController.loggedInUser().id,
          commentsId: [],
          likersId: []);
      await _postController.addPost(newPost);
      _navigate();
    } else {
      Get.snackbar('something went wrong', 'try again');
    }
  }

  void _editPost() {
    if (_formKey.currentState.validate()) {
      PostModel newPost = PostModel(
        id: widget.editingPost.id,
        caption: captionController.text,
        ownerId: widget.editingPost.ownerId,
        likersId: widget.editingPost.likersId,
        commentsId: widget.editingPost.commentsId,
        imageUrl: widget.editingPost.imageUrl,
      );

      _postController.editPost(newPost);
      _navigate();
    } else {
      Get.snackbar('something went wrong', 'try again');
    }
  }

  Widget _postImage() {
    return Stack(children: [_showCurrentPicture(), _addPictureButton()]);
  }

  Widget _showCurrentPicture() {
    return Center(
        child: widget.isEditing
            ? Container(
                height: 200,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: NetworkImage(widget.editingPost.imageUrl),
                )))
            : Icon(Icons.image, size: 200, color: Colors.grey));
  }

  Widget _addPictureButton() {
    return Container(
      height: 200,
      child: Center(
        child: Align(
          alignment: Alignment.center,
          child: TextButton(
            onPressed: () async {
              // await _getFromGallery();
            },
            child: Text(
              'add a picture',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }

  Widget _postCaption() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          controller: captionController,
          validator: (value) => value.isEmpty ? 'caption cant be empty' : null,
          decoration: InputDecoration(labelText: 'caption...'),
        ),
      ),
    );
  }

  Widget _postButton() {
    return OutlineButton(
      onPressed: () async {
        if (widget.isEditing) {
          _editPost();
        } else {
          _addPost();
        }
      },
      child: Text(widget.isEditing ? "edit" : "Post"),
      color: Colors.blueGrey,
      splashColor: Colors.blueGrey,
      focusColor: Colors.blueGrey,
      textColor: Colors.black,
      borderSide: BorderSide(color: Colors.blueGrey),
    );
  }

  PostController get _postController {
    return Get.find<PostController>();
  }

  UserController get _userController {
    return Get.find<UserController>();
  }
}
