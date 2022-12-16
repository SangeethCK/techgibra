import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:techgibra/view/utilities/app_padding.dart';
import 'package:techgibra/view/utilities/utils.dart';
import 'package:flutter/foundation.dart';

// class UsersScreen extends StatefulWidget {
//   const UsersScreen({super.key});

//   @override
//   State<UsersScreen> createState() => _UsersScreenState();
// }

// class _UsersScreenState extends State<UsersScreen> {
//   bool _isFirstLoadRunning = false;
//   bool isLoadMoreRunning = false;

//   // void _loadMore() async {
//   //   if (_isFirstLoadRunning == false && isLoadMoreRunning == false) {

//   //     setState(() {
//   //       isLoadMoreRunning = true;
//   //     });

//   //     try {
//   //       await provider.userDetailsapicall();

//   //     } catch (err) {
//   //       if (kDebugMode) {
//   //         print('Something went wrong!');
//   //       }
//   //     }

//   //     setState(() {
//   //       isLoadMoreRunning = false;
//   //     });
//   //   }
//   // }

//   // The controller for the ListView

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   // _firstLoad();
//   //   _controller = ScrollController();
//   //   _controller.addListener((() {
//   //     if (_controller.position.pixels >=
//   //         _controller.position.maxScrollExtent) {

//   //         _loadMore();

//   //     }
//   //   }));
//   // }

//   // @override
//   // void dispose() {
//   //   _controller.dispose();
//   //   super.dispose();
//   // }
//   // late ScrollController _controller;
//   // @override
//   // Widget build(BuildContext context) {
//   //   return Consumer(
//   //         builder: (context,UserDetailsController controller,_) {
//   //           return  controller.users.isEmpty?Center(child: CircularProgressIndicator(),): Column(
//   //             children: [
//   //                 Padding(
//   //         padding: const EdgeInsets.all(10),
//   //         child:

//   //               Expanded(
//   //                 child:     ListView.separated(
//   //                 physics: const AlwaysScrollableScrollPhysics(),
//   //                 itemCount: snapshot.data!.docs.length,
//   //                 separatorBuilder: (context, index) {
//   //                   return const Divider(
//   //                     thickness: 1,
//   //                   );
//   //                 },
//   //                 itemBuilder: (context, index) {
//   //                   var doc = snapshot.data!.docs[index];
//   //                   return Padding(
//   //                     padding: const EdgeInsets.symmetric(horizontal: 5),
//   //                     child: Column(
//   //                       children: [
//   //                         const SizedBox(height: 10),
//   //                         Row(
//   //                           children: [
//   //                             CircleAvatar(
//   //                               backgroundImage:
//   //                                   NetworkImage(doc['userimage']),
//   //                             ),
//   //                             const AppPadding(dividedBy: 4),
//   //                             Text(doc['username']),
//   //                             const AppPadding(dividedBy: 4),
//   //                             Text(doc['update']),
//   //                           ],
//   //                         ),
//   //                         const SizedBox(height: 10),
//   //                         Row(
//   //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   //                           children: [
//   //                             Flexible(
//   //                               child: Text(
//   //                                 doc['title'],
//   //                                 maxLines: 3,
//   //                                 textAlign: TextAlign.justify,
//   //                                 style: SafeGoogleFont(
//   //                                   'Poppins',
//   //                                   fontSize: 14,
//   //                                   fontWeight: FontWeight.w700,
//   //                                   height: 1,
//   //                                   color: const Color(0xff212523),
//   //                                 ),
//   //                               ),
//   //                             ),
//   //                             SizedBox(
//   //                               height: 80,
//   //                               width: 100,
//   //                               child: Image.network(
//   //                                 doc['image'],
//   //                                 fit: BoxFit.cover,
//   //                               ),
//   //                             )
//   //                           ],
//   //                         ),
//   //                         const AppPadding(
//   //                           dividedBy: 4,
//   //                         ),
//   //                         Text(
//   //                           doc['content'],
//   //                           maxLines: 4,
//   //                           textAlign: TextAlign.left,
//   //                         ),
//   //                         Row(
//   //                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//   //                           children: [
//   //                             SizedBox(
//   //                               width: 70,
//   //                               child: TextButton(
//   //                                   style: ButtonStyle(
//   //                                       backgroundColor:
//   //                                           MaterialStateProperty.all(
//   //                                               Colors.grey.shade200)),
//   //                                   onPressed: () {},
//   //                                   child: const Text('Flutter')),
//   //                             ),
//   //                             Text(doc['time']),
//   //                             Text(doc['subtext']),
//   //                             const AppPadding(
//   //                               dividedBy: 4,
//   //                             ),
//   //                             SizedBox(
//   //                                 height: 30,
//   //                                 width: 30,
//   //                                 child: Image.network(doc['more'])),
//   //                             SizedBox(
//   //                                 height: 30,
//   //                                 width: 30,
//   //                                 child: Image.network(doc['book'])),
//   //                             SizedBox(
//   //                                 height: 30,
//   //                                 width: 30,
//   //                                 child: Image.network(doc['mini'])),
//   //                           ],
//   //                         ),
//   //                       ],
//   //                     ),
//   //                   );
//   //                 });

//   //               ),
//   //                isLoadMoreRunning?const  CircularProgressIndicator():Container(),
//   //               SizedBox(height:   isLoadMoreRunning?20:0,)
//               ],
//             );
//     });
//   }
// }
// ///
class ListWidgets extends StatefulWidget {
  ListWidgets({super.key});

  @override
  State<ListWidgets> createState() => _ListWidgetsState();
}

class _ListWidgetsState extends State<ListWidgets> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ScrollController scrollController = ScrollController();
  bool moreData = true;
  bool isLoading = false;
  DocumentSnapshot? lastDocument;
  int document = 4;
  late QuerySnapshot<Map<String, dynamic>> querySnapshot;
  @override
  void initState() {
    uploadScrollable();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        uploadScrollable();
      }
    });
    super.initState();
  }

  List<Map<String, dynamic>> list = [];
  void uploadScrollable() async {
    setState(() {
      isLoading = true;
    });
    if (moreData) {
      final coleectionReference = _firestore.collection('usersdata');
      if (lastDocument == null) {
        querySnapshot = await coleectionReference.limit(document).get();
      } else {
        querySnapshot = await coleectionReference
            .limit(document)
            .startAfterDocument(lastDocument!)
            .get();
      }
      lastDocument = querySnapshot.docs.last;
      list.addAll(querySnapshot.docs.map((e) => e.data()));
      isLoading = false;
      setState(() {});
      if (querySnapshot.docs.length < 4) {
        moreData = false;
      } else {
        print('No More Data');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                    controller: scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: list.length,
                    separatorBuilder: (context, index) {
                      return const Divider(
                        thickness: 1,
                      );
                    },
                    itemBuilder: (context, index) {
                      // var doc = snapshot.data!.docs[index];
                      var doc = list[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(doc['userimage']),
                                ),
                                const AppPadding(dividedBy: 4),
                                Text(list[index]['username']),
                                const AppPadding(dividedBy: 4),
                                Text(doc['update']),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    doc['title'],
                                    maxLines: 3,
                                    textAlign: TextAlign.justify,
                                    style: SafeGoogleFont(
                                      'Poppins',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      height: 1,
                                      color: const Color(0xff212523),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 80,
                                  width: 100,
                                  child: Image.network(
                                    doc['image'],
                                    fit: BoxFit.cover,
                                  ),
                                )
                              ],
                            ),
                            const AppPadding(
                              dividedBy: 4,
                            ),
                            Text(
                              doc['content'],
                              maxLines: 4,
                              textAlign: TextAlign.left,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  width: 70,
                                  child: TextButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.grey.shade200)),
                                      onPressed: () {},
                                      child: const Text('Flutter')),
                                ),
                                Text(doc['time']),
                                Text(doc['subtext']),
                                const AppPadding(
                                  dividedBy: 4,
                                ),
                                SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: Image.network(doc['more'])),
                                SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: Image.network(doc['book'])),
                                SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: Image.network(doc['mini'])),
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            isLoading?  Center(
                child: CircularProgressIndicator(),
              ):SizedBox()
            ],
          )),
    );
  }
}
