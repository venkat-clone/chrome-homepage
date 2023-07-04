import 'package:chrome_home_page/Components/partcle.dart';
import 'package:chrome_home_page/Components/search_field.dart';
import 'package:chrome_home_page/Components/search_icon.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final ValueNotifier<String> _query = ValueNotifier<String>('');

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
          minWidth: 350, maxHeight: MediaQuery.of(context).size.height * 0.5),
      child: Stack(
        alignment: Alignment.center,
        children: [
          ParticlesScreen(),
          SearchField(
            onchanged: (value) {
              _query.value = value;
              // _counter.notifyListeners();
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ValueListenableBuilder<String>(
              valueListenable: _query,
              builder: (context, value, _) {
                return ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 400),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      SocailIcon(
                        icon: 'youtube.png',
                        highlight: Colors.red,
                        url: 'https://www.youtube.com',
                        query: '/results?search_query=${_query.value}',
                      ),
                      SocailIcon(
                        icon: 'github.png',
                        highlight: Colors.white,
                        url: 'https://github.com',
                        query: '/search?q=${_query.value}',
                      ),
                      SocailIcon(
                        icon: 'dribble.png',
                        highlight: Colors.pink,
                        url: 'https://dribbble.com/search',
                        query: '/${_query.value}',
                      ),
                      SocailIcon(
                        icon: 'linkedin.png',
                        highlight: Colors.blue,
                        url: 'https://www.linkedin.com/search',
                        query: '/results/all/?keywords=${_query.value}',
                      ),
                      SocailIcon(
                        icon: 'upwork.png',
                        highlight: Colors.green,
                        url: 'https://www.upwork.com/nx/jobs',
                        query: '/search/?q=${_query.value}',
                      ),
                      SocailIcon(
                        icon: 'flutter.png',
                        highlight: Colors.blue,
                        url: 'https://pub.dev/packages',
                        query: '?q=${_query.value}',
                      ),
                      SocailIcon(
                        icon: 'react.png',
                        highlight: Colors.lightBlue,
                        url: 'https://www.npmjs.com/search',
                        query: '?q=${_query.value}',
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
