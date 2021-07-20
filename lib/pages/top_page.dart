import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_memo_app/pages/memo_page.dart';

import 'add_memo_page.dart';

class TopPage extends StatefulWidget {
  TopPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _TopPageState createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  late CollectionReference memos;

  @override
  void initState() {
    super.initState();
    memos = FirebaseFirestore.instance.collection('memo');
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase × Flutter'), //Title Setting
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: memos.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data!.docs[index].get('title')),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return SafeArea(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListTile(
                                    leading: Icon(
                                      Icons.edit,
                                      color: Colors.blueAccent,
                                    ),
                                    title: Text('編集'),
                                    onTap: () {},
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.delete,
                                        color: Colors.redAccent),
                                    title: Text('削除'),
                                    onTap: () {},
                                  )
                                ],
                              ),
                            );
                          });
                    },
                  ),
                  onTap: () {
                    // 確認画面へ遷移
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                MemoPage(snapshot.data!.docs[index])));
                  },
                );
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddMemoPage()));
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
