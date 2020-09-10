import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyAppBar extends StatelessWidget {
  final String leftIcon, rightIcon, label;
  final VoidCallback onLeftClick, onRightClick;

  MyAppBar({this.leftIcon, this.onLeftClick, this.rightIcon, this.onRightClick, this.label})
      : assert(leftIcon != null && onLeftClick != null ||
            rightIcon != null && onRightClick != null || label != null);

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.white60, child: _buildAppBar());
  }

  Widget _buildAppBar() {
    // if (this.leftIcon != null) 'widget'
    final double _paddingEdgeInsetsAll = 15;
    if (this.leftIcon != null && this.rightIcon != null) {
      return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        CupertinoButton(
            padding: EdgeInsets.all(_paddingEdgeInsetsAll),
            child:
                SvgPicture.asset(this.leftIcon, width: 20, color: Colors.white),
            onPressed: this.onLeftClick),
        CupertinoButton(
            padding: EdgeInsets.all(_paddingEdgeInsetsAll),
            child: SvgPicture.asset(this.rightIcon,
                width: 20, color: Colors.white),
            onPressed: this.onRightClick)
      ]);
    } else if (this.leftIcon != null) {
      return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        CupertinoButton(
            padding: EdgeInsets.all(_paddingEdgeInsetsAll),
            child:
                SvgPicture.asset(this.leftIcon, width: 20, color: Colors.white),
            onPressed: this.onLeftClick)
      ]);
    } else if (this.rightIcon != null) {
      return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        CupertinoButton(
            padding: EdgeInsets.all(_paddingEdgeInsetsAll),
            child: SvgPicture.asset(this.rightIcon,
                width: 20, color: Colors.white),
            onPressed: this.onRightClick)
      ]);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(_paddingEdgeInsetsAll),
          alignment: Alignment.center,
          child: Text('Gastos App',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0,
                  color: Colors.black87)),
        ),
      ],
    );
  }
}
