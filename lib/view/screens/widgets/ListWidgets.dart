import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lazy_loading_list/lazy_loading_list.dart';

import 'package:techgibra/view/utilities/app_padding.dart';
import 'package:techgibra/view/utilities/utils.dart';

class ListWidgets extends StatelessWidget {
  const ListWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('usersdata').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.separated(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: snapshot.data!.docs.length,
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                  itemBuilder: (context, index) {
                    var doc = snapshot.data!.docs[index];
                    return LazyLoadingList(
                      initialSizeOfItems: 2,
                      index: snapshot.data!.docs.length,
                      hasMore: true,
                      loadMore: () => const Text('loading'),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            Row(
                              //  mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(doc['userimage']),
                                ),
                                const AppPadding(dividedBy: 4),
                                Text(doc['username']),
                                const AppPadding(dividedBy: 4),
                                Text(doc['update']),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      doc['title'],
                                      overflow: TextOverflow.visible,
                                      textWidthBasis:
                                          TextWidthBasis.longestLine,
                                      maxLines: 2,
                                      textAlign: TextAlign.left,
                                      style: SafeGoogleFont(
                                        'Poppins',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        height: 1,
                                        color: const Color(0xff212523),
                                      ),
                                    )),
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
                            const AppPadding(),
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
                      ),
                    );
                  });
            }),
      ),
    );
  }
}
