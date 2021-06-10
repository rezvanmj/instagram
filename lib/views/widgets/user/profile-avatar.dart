import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final double size;
  final String imageUrl;

  ProfileAvatar(this.size, this.imageUrl);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      child: CircleAvatar(
        backgroundColor: Colors.grey,
        backgroundImage: imageUrl.isNotEmpty
            ? NetworkImage(imageUrl)
            : NetworkImage(
                'https://www.sciencemag.org/sites/default/files/styles/article_main_large/public/cat_1280p_0.jpg?itok=MFUV0a-t'),
      ),
    );
  }
}
