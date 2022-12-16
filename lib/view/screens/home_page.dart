import 'package:flutter/material.dart';

import 'package:techgibra/view/screens/widgets/ListWidgets.dart';
import 'package:techgibra/view/utilities/asset_images.dart';

import '../utilities/utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 6, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leadingWidth: 150,
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Home',
              style: SafeGoogleFont(
                'Poppins',
                fontSize: 25,
                fontWeight: FontWeight.w700,
                color: const Color(0xff212523),
              )),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              AssetImages.notificationIcon,
              width: 35,
            ),
          )
        ],
      ),
      // appBar: AppBar(
      //   toolbarHeight: 90,
      //   leadingWidth: 130,
      //   elevation: 1,
      //   leading: SizedBox(
      //     height: 90,
      //     width: 100,
      //     child: Image.asset(
      //       AssetImages.logoImage,
      //       fit: BoxFit.cover,
      //     ),
      //   ),
      //   title: TextField(
      //     scrollPadding: EdgeInsets.zero,
      //     decoration: InputDecoration(
      //         contentPadding: EdgeInsets.zero,
      //         hintText: 'Search Medium',
      //         icon: SizedBox(
      //             height: 20, child: Image.asset(AssetImages.searchIcon)),
      //         border: InputBorder.none),
      //   ),
      //   backgroundColor: Colors.white,
      // ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            child: TabBar(
                unselectedLabelColor: Colors.grey,
                indicatorColor: Colors.grey,
                labelColor: Colors.black,
                isScrollable: true,
                controller: _tabController,
                tabs: const [
                  Tab(
                    height: 50,
                    child: Center(child: Icon(Icons.add)),
                  ),
                  Tab(
                    height: 50,
                    child: Center(child: Text('For you')),
                  ),
                  Tab(
                    height: 50,
                    child: Center(
                        child: Text(
                      'Following',
                    )),
                  ),
                  Tab(
                    height: 50,
                    child: Center(child: Text('Software Engineering')),
                  ),
                  Tab(
                    height: 50,
                    child: Center(child: Text('Freelancing')),
                  ),
                  Tab(
                    height: 50,
                    child: Center(child: Text('Android Developement')),
                  ),
                ]),
          ),
          const Expanded(child: ListWidgets())
        ],
      ),
    );
  }
}
