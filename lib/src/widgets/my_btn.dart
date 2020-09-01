import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spends_app/src/util/responsive.dart';

class MyBtn extends StatefulWidget {
  final String icon;
  final Color colorBackground, colorIcon;

  const MyBtn({Key key, this.icon, this.colorBackground, this.colorIcon})
      : super(key: key);
  @override
  _MyBtnState createState() => _MyBtnState();
}

class _MyBtnState extends State<MyBtn> {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return CupertinoButton(
      padding: EdgeInsets.zero,
      minSize: responsive.dp(10),
      child: Container(
        padding: EdgeInsets.all(responsive.dp(2)),
        child: SvgPicture.asset(widget.icon,
            color: widget.colorIcon ?? Colors.white, 
            width: responsive.dp(4)),
        decoration: BoxDecoration(
            color: widget.colorBackground ?? Colors.blue,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.white,
                blurRadius: 5)]),
      ),
      onPressed: () {},
    );
  }
}
