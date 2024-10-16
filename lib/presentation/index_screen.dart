import 'package:flutter/material.dart';
import 'package:tunes/presentation/tabs/discover/discover_tab_screen.dart';
import 'package:tunes/presentation/tabs/home/home_tab_screen.dart';
import 'package:tunes/presentation/tabs/library/library_tab_screen.dart';
import 'package:tunes/presentation/tabs/me/me_tab_screen.dart';
import 'package:tunes/presentation/tabs/search/search_tab_screen.dart';

class IndexScreen extends StatefulWidget {
  const IndexScreen({super.key, required this.initTab});

  final int initTab;

  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  late int indexTab;

  @override
  void initState() {
    indexTab = widget.initTab;
    super.initState();
  }

  final tabs = [
    const HomeTabScreen(),
    const DiscoverTabScreen(),
    const SearchTabScreen(),
    const LibraryTabScreen(),
    const MeTabScreen(),
  ];

  void setTab(int newTab) {
    setState(() {
      indexTab = newTab;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[indexTab],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: indexTab,
        onTap: setTab,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Discover',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_music),
            label: 'Library',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Me',
          ),
        ],
      ),
    );
  }
}
