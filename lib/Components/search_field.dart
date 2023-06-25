import 'package:chrome_home_page/Components/search_icon.dart';
import 'package:flutter/material.dart';

import '../colors.dart';

class SearchField extends StatefulWidget {
  final void Function(String) onchanged;
  const SearchField({super.key, required this.onchanged});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  bool _isHovered = false;
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    Future.delayed(Duration(seconds: 1)).then((value) {
      _focusNode.requestFocus();
    });
    super.initState();
  }

  void _handleHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18.0),
      child: Container(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(30), boxShadow: [
          _isHovered
              ? BoxShadow(
                  color: primary.withOpacity(0.4),
                  blurRadius: 5,
                  spreadRadius: 5)
              : BoxShadow(
                  color: primary.withOpacity(0.2),
                  blurRadius: 3,
                  spreadRadius: 3)
        ]),
        child: MouseRegion(
          onEnter: (event) => _handleHover(true),
          onExit: (event) => _handleHover(false),
          child: TextField(
            focusNode: _focusNode,
            onChanged: widget.onchanged,
            textAlign: TextAlign.center,
            autofocus: true,
            onSubmitted: (value) {
              launchURL('https://www.google.com/search?q=$value');
            },
            style: const TextStyle(
                color: primary,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 3,
                shadows: [
                  BoxShadow(color: primary, blurRadius: 3, spreadRadius: 3)
                ]),
            autofillHints: ['hello', 'bye'],
            decoration: InputDecoration(
              constraints: BoxConstraints(maxWidth: 400),
              hintText: 'Search Anything',
              hintStyle: const TextStyle(
                  color: shade,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                  shadows: []),
              hoverColor: primary.withOpacity(0.2),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
              fillColor: canvas,
              filled: true,
              focusColor: primary,
              border: OutlineInputBorder(
                borderSide: BorderSide(color: primary),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
