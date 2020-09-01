import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BottomMenuItem {
  final String iconPath, label, nav;

  BottomMenuItem(
      {@required this.iconPath, @required this.label, @required this.nav});
}

class BottomMenu extends StatelessWidget {
  final List<BottomMenuItem> items;

  const BottomMenu({@required this.items})
      : assert(items != null && items.length > 0);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(15),
        color: Colors.grey[100],
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(this.items.length, (index) {
              final BottomMenuItem item = items[index];
              return Expanded(
                child: Container(
                  child: CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      // final route = MaterialPageRoute(builder: (context) => item.nav);
                      // Navigator.push(context, route);
                      Navigator.pushNamed(context, item.nav);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(item.iconPath, width: 25),
                        Text(
                          item.label,
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        )
                      ],
                    ),
                  ),
                ),
              );
            })));
  }

}
