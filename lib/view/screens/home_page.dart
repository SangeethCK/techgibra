import 'package:flutter/material.dart';

import 'package:techgibra/view/screens/widgets/ListWidgets.dart';
import 'package:techgibra/view/utilities/asset_images.dart';

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
        toolbarHeight: 90,
        leadingWidth: 120,
        elevation: 1,
        leading: SizedBox(
          height: 80,
          width: 100,
          child: Image.asset(
            AssetImages.logoImage,
            fit: BoxFit.cover,
          ),
        ),
        title: TextField(
          scrollPadding: EdgeInsets.zero,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              hintText: 'Search Medium',
              icon: SizedBox(
                  height: 20, child: Image.asset(AssetImages.searchIcon)),
              border: InputBorder.none),
        ),
        backgroundColor: Colors.white,
      ),
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
