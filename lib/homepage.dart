import 'package:chrome_home_page/colors.dart';
import 'package:flutter/material.dart';
import 'Components/bookmark.dart';
import 'Components/search.dart';
import 'Components/search_icon.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Container(
        color: background,
        padding: EdgeInsets.symmetric(horizontal: 50),
        child: ListView(
          children: [
            SizedBox(
              height: 15,
            ),
            header(),
            const Search(),
            bookmarks()
          ],
        ),
      ),
    );
  }

  Widget bookmarks() {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          Bookmark(),
          Bookmark(),
          Bookmark(),
          Bookmark(),
          Bookmark(),
          Bookmark(),
        ],
      ),
    );
  }

  Widget header() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => launchURL('https://venkat-clone.github.io'),
            child: const Text(
              'Venkatesh Lingampally',
              style: TextStyle(
                  color: primary,
                  fontSize: 40,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 3,
                  shadows: [
                    BoxShadow(color: primary, blurRadius: 3, spreadRadius: 3)
                  ]),
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: 50,
            ),
            child: Wrap(
              children: [
                SocailIcon(
                  icon: 'chatgpt.jpg',
                  highlight: Colors.teal,
                  url: 'https://chat.openai.com/',
                ),
                SocailIcon(
                  icon: 'youtube.png',
                  highlight: Colors.red,
                  url: 'https://www.youtube.com/',
                ),
                SocailIcon(
                  icon: 'provenworks.png',
                  highlight: Colors.yellow.shade900,
                  url: 'https://www.provenworks.com/',
                ),
                SocailIcon(
                  icon: 'gmail.png',
                  highlight: Colors.white,
                  url: 'https://www.mail.google.com/',
                ),
                SocailIcon(
                  icon: 'linkedin.png',
                  highlight: Colors.blue.shade900,
                  url: 'https://www.linkedin.com/',
                ),
                SocailIcon(
                  icon: 'upwork.png',
                  highlight: Colors.black,
                  url: 'https://www.upwork.com/nx/find-work/',
                ),
                SocailIcon(
                  icon: 'instagram.png',
                  highlight: Colors.white,
                  url: 'https://www.instagram.com/',
                ),
              ],
            ),
          )
        ],
      );
}
