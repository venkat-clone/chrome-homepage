import 'package:chrome_home_page/colors.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;

// ignore: must_be_immutable
class SocailIcon extends StatefulWidget {
  String icon = '';
  Color highlight = white;
  String url = '';
  String query = '';
  SocailIcon(
      {super.key,
      required this.icon,
      required this.highlight,
      required this.url,
      this.query = ''});

  @override
  State<SocailIcon> createState() => _SocailIconState();
}

class _SocailIconState extends State<SocailIcon> {
  bool _isHovered = false;

  openLink() {
    if (widget.query.endsWith('=')) {
      launchURL(widget.url);
    } else {
      launchURL(widget.url + widget.query);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: InkWell(
        onHover: _handleHover,
        onTap: openLink,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              color: _isHovered ? widget.highlight : canvas,
              shape: BoxShape.circle,
              boxShadow: [
                _isHovered
                    ? BoxShadow(
                        color: primary.withOpacity(0.5),
                        blurRadius: 6,
                        spreadRadius: 6)
                    : BoxShadow(
                        color: primary.withOpacity(0.25),
                        blurRadius: 3,
                        spreadRadius: 3)
              ]),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(
                  "assets/images/${widget.icon}",
                  fit: BoxFit.scaleDown,
                )),
          ),
        ),
      ),
    );
  }

  void _handleHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });
  }
}

void launchURL(String url) {
  html.window.location.href = url;
}
