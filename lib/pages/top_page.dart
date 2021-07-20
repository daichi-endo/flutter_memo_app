import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_memo_app/model/memo.dart';
import 'package:flutter_memo_app/pages/memo_page.dart';

class TopPage extends StatefulWidget {
  TopPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _TopPageState createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  List<Memo> memoList = [];

  Future<void> getMemo() async {
    var snapshot = await FirebaseFirestore.instance.collection('memo').get();
    var docs = snapshot.docs;
    docs.forEach((doc) {
      memoList
          .add(Memo(title: doc.data()['title'], detail: doc.data()['detail']));
    });

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getMemo();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase × Flutter'), //Title Setting
      ),
      body: ListView.builder(
        itemCount: memoList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(memoList[index].title),
            onTap: () {
              // 確認画面へ遷移
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MemoPage(memoList[index])));
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
