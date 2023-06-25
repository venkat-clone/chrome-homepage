import 'dart:html';

import 'package:chrome_home_page/Components/search_icon.dart';
import 'package:chrome_home_page/colors.dart';
import 'package:flutter/material.dart';

class Bookmark extends StatefulWidget {
  String icon;
  String webDomain;
  String link;
  Bookmark(
      {super.key,
      required this.icon,
      required this.link,
      required this.webDomain});

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
            BoxConstraints(minWidth: 250, minHeight: 120, maxWidth: 350),
        child: GestureDetector(
          onTap: () => launchURL(widget.link),
          onLongPress: () => copyToClipboard(widget.link),
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
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Image.asset(
                            'assets/images/${widget.icon}',
                            width: 40,
                            height: 40,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          widget.webDomain,
                          style: const TextStyle(
                              color: shade,
                              fontWeight: FontWeight.w900,
                              fontSize: 20),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 14, top: 10, right: 10),
                      child: Text(
                        widget.link,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: shade,
                            fontWeight: FontWeight.w900,
                            fontSize: 16),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void copyToClipboard(String text) {
    final textarea = TextAreaElement();
    document.body!.append(textarea);
    textarea.style.border = '0';
    textarea.style.position = 'fixed';
    textarea.style.left = '-9999px';
    textarea.value = text;

    textarea.select();

    document.execCommand('copy');

    textarea.remove();

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.transparent,
        content: Container(
            decoration: BoxDecoration(
                color: shade.withOpacity(0.5),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: primary),
                boxShadow: [
                  BoxShadow(
                    color: primary.withOpacity(0.2),
                    blurRadius: 3,
                    spreadRadius: 3,
                  )
                ]),
            padding: EdgeInsets.all(16),
            child: Text('Link Copied to clipboard'))));
  }
}
