import 'package:flutter/material.dart';
import 'package:spends_app/src/data/spend_data.dart';

class Spend extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        final Object homeDetail = spendsData[index]['homeDetail'];
        print(homeDetail);

        // final List<dynamic> body = json.decode(homeDetail);
        // print(body.toList());


        return Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.black12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Description: ${spendsData[index]['description']}'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Date: ${spendsData[index]['date']}'),
                  Text('Amount: ${spendsData[index]['amount']}'),
                ],
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        );
      },
      itemCount: spendsData.length,
    );
  }
}
