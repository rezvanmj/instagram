import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  bool isExpanded;
  final String caption;
  ExpandableText(this.caption, this.isExpanded);

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  @override
  Widget build(BuildContext context) {
    return widget.isExpanded
        ? GestureDetector(
            child: Text(widget.caption),
            onTap: () {
              setState(() {
                widget.isExpanded = false;
              });
            },
          )
        : GestureDetector(
            child: Text(
              widget.caption,
              maxLines: 2,
            ),
            onTap: () {
              setState(() {
                widget.isExpanded = true;
              });
            },
          );
  }
}
