import 'package:flutter/material.dart';

import 'package:techgibra/view/screens/home_page.dart';
import 'package:techgibra/view/screens/widgets/library_page.dart';
import 'package:techgibra/view/screens/widgets/search_page.dart';
import 'package:techgibra/view/screens/widgets/user_profile.dart';

import '../utilities/asset_images.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});
  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final _pages = [
    const HomePage(),
    const SearchPage(),
    const LibraryPage(),
    const UserProfile()
  ];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: SizedBox(
          height: 75,
          child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.orange,
              unselectedItemColor: Colors.grey,
              currentIndex: currentIndex,
              onTap: ((value) {
                setState(() {
                  currentIndex = value;
                });
              }),
              items: [
                BottomNavigationBarItem(
                    icon: SizedBox(
                        height: 30, child: Image.asset(AssetImages.home)),
                    label: ''),
                BottomNavigationBarItem(
                    icon: SizedBox(
                        height: 30, child: Image.asset(AssetImages.search)),
                    label: ''),
                BottomNavigationBarItem(
                    icon: SizedBox(
                        height: 30, child: Image.asset(AssetImages.bookmark)),
                    label: ''),
                BottomNavigationBarItem(
                    icon: SizedBox(
                        height: 30, child: Image.asset(AssetImages.user)),
                    label: ''),
              ]),
        ),
        body: _pages[currentIndex]);
  }
}
