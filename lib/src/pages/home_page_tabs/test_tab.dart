import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TestTab extends StatefulWidget {
  @override
  _TestTabState createState() => _TestTabState();
}

class _TestTabState extends State<TestTab> {
  var list;
  var random;

  var refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    random = Random();
    refreshList();
  }

  Future<Null> refreshList() async {
    refreshKey.currentState?.show();
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      list = List.generate(random.nextInt(10), (i) => "Item $i");
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: 
    list != null
        ? RefreshIndicator(
        key: refreshKey,
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, i) => ListTile(
            title: Text(list[i]),
          ),
        ),
        onRefresh: refreshList,
      ) : Center(child: CircularProgressIndicator()),);
  }

}
