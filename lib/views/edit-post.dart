import 'package:flutter/material.dart';
import 'package:instagram/models/post-model.dart';
import 'package:instagram/views/widgets/simple-appbar.dart';

import 'widgets/post/add-edit-post.dsrt.dart';

class EditPost extends StatelessWidget {
  final PostModel editingPost;
  EditPost(this.editingPost);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: SimpleAppBar('edit post', false),
        preferredSize: const Size.fromHeight(60),
      ),
      body: AddEditPost(
        isEditing: true,
        editingPost: editingPost,
      ),
    );
  }
}
