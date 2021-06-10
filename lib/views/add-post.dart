import 'package:flutter/material.dart';
import 'package:instagram/views/widgets/simple-appbar.dart';

import 'widgets/post/add-edit-post.dsrt.dart';

class AddPost extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            child: SimpleAppBar('Add a post', false),
            preferredSize: const Size.fromHeight(60)),
        body: AddEditPost(
          isEditing: false,
        ));
  }
}
