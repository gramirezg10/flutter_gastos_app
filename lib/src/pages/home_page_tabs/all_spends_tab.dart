import 'package:flutter/material.dart';

class AllSpendsTab extends StatefulWidget {
  @override
  _AllSpendsTabState createState() => _AllSpendsTabState();
}

class _AllSpendsTabState extends State<AllSpendsTab> {
  List <String> _listSpends =['Spend # 1',
    'Spend # 2',
    'Spend # 3',
    'Spend # 4',
    'Spend # 5',
    'Spend # 6',
    'Spend # 7',
    'Spend # 8',
    'Spend # 9',
    'Spend # 10',
    'Spend # 11',
    'Spend # 12'
  ];

  @override
  Widget build(BuildContext context) {
    print('--- all spends tab');
    // return Center(
    //   child: Text('AllSpends tab content!!'),
    // );

    return Container(
      // color: Colors.black12,
      width: double.infinity,
      height: double.infinity,
      child: LayoutBuilder(builder: (context, constraints) {
        return Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  // color: Colors.black26,
                  width: double.infinity,
                  height: constraints.maxHeight * 0.05,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text('AllSpends tab content!!______')],
                  ),
                ),
                SizedBox(),
                Container(
                    // color: Color(0xB7B4B4),
                    width: double.infinity,
                    height: constraints.maxHeight * .95,
                    child: ListView.builder(
                        itemBuilder: (_, index) {
                          return Container(
                            alignment: Alignment.center,
                            width: 120,
                            height: 120,
                            margin: EdgeInsets.all(constraints.maxHeight * 0.015),
                            color: Color(0xFFF1F1F1),
                            child: Text('${_listSpends[index]}'),
                          );
                        },
                        itemCount: _listSpends.length))
              ],
            ),
          ),
        );
      }),
    );
  }
}
