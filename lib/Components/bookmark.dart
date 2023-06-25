import 'package:chrome_home_page/colors.dart';
import 'package:flutter/material.dart';

class Bookmark extends StatefulWidget {
  const Bookmark({super.key});

  @override
  State<Bookmark> createState() => BookmarkState();
}

class BookmarkState extends State<Bookmark> {
  bool _isHovered = false;

  void hover(bool value) => setState(() {
        _isHovered = value;
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: ConstrainedBox(
        constraints:
            BoxConstraints(minWidth: 350, minHeight: 120, maxWidth: 400),
        child: MouseRegion(
          onEnter: (event) => hover(true),
          onExit: (event) => hover(false),
          child: Container(
            decoration: BoxDecoration(
              color: canvas,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: primary),
              boxShadow: [
                _isHovered
                    ? BoxShadow(
                        color: primary.withOpacity(0.2),
                        spreadRadius: 6,
                        blurRadius: 6)
                    : BoxShadow(
                        color: primary.withOpacity(0.1),
                        spreadRadius: 3,
                        blurRadius: 3)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
