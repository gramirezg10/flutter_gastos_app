import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BottomMenuItem {
  final String iconPath, label;
  final Widget content;

  BottomMenuItem(
    {@required this.iconPath,
    @required this.label,
    @required this.content});
}

class BottomMenu extends StatelessWidget {
  final List<BottomMenuItem> items;
  final int currentPage;
  final void Function(int) onChanged;

  const BottomMenu(
      {@required this.items, @required this.currentPage, this.onChanged})
      : assert(items != null && items.length > 0),
        assert(currentPage != null && currentPage >= 0);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(15),
        color: Colors.grey[100],
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(this.items.length, (index) {
              final bool isActive = index == currentPage;
              final BottomMenuItem item = items[index];
              return Expanded(
                child: Container(
                  child: CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      // para usar ese nav, se debe pedir como parámetro, y debe llegar el nombre de la página, la variable estática
                      // final route = MaterialPageRoute(builder: (context) => item.nav);
                      // Navigator.push(context, route);

                      // Navigator.pushNamed(context, item.nav);

                      onChanged(index);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          item.iconPath,
                          width: 25,
                          color: isActive ? Colors.blue : Colors.black,
                        ),
                        Text(
                          item.label,
                          style: TextStyle(
                              color: isActive ? Colors.blue : Colors.black,
                              fontSize: 15),
                        )
                      ],
                    ),
                  ),
                ),
              );
            })));
  }
}
