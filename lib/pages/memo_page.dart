import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_memo_app/model/memo.dart';

class MemoPage extends StatelessWidget {
  final Memo memo;
  MemoPage(this.memo);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(memo.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('メモ内容',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(
              memo.detail,
              style: TextStyle(fontSize: 18),
            )
          ],
        ),
      ),
    );
  }
}
