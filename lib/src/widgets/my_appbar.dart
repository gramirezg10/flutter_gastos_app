import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyAppBar extends StatelessWidget {
  final String leftIcon, rightIcon;
  final VoidCallback onLeftClick, onRightClick;

  MyAppBar(
      {this.leftIcon, this.onLeftClick, this.rightIcon, this.onRightClick}): 
        assert(leftIcon != null && onLeftClick != null || rightIcon != null && onRightClick != null);

  @override
  Widget build(BuildContext context) {


    return Container(
      color: Colors.blue,
      child: _buildAppBar()
    );
  }

  Widget _buildAppBar(){
    final double _paddingEdgeInsetsAll = 15;
    if (this.leftIcon != null && this.rightIcon != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CupertinoButton(
            padding: EdgeInsets.all(_paddingEdgeInsetsAll),
            child: SvgPicture.asset(this.leftIcon, width: 20, color: Colors.white),
            onPressed: this.onLeftClick),
            CupertinoButton(
            padding: EdgeInsets.all(_paddingEdgeInsetsAll),
            child: SvgPicture.asset(this.rightIcon, width: 20, color: Colors.white),
            onPressed: this.onRightClick)
        ]
      );
    }

    if (this.leftIcon != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: 
          [CupertinoButton(
            padding: EdgeInsets.all(_paddingEdgeInsetsAll),
            child: SvgPicture.asset(this.leftIcon, width: 20, color: Colors.white),
            onPressed: this.onLeftClick)]
      );
    }

    if (this.rightIcon != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: 
          [CupertinoButton(
            padding: EdgeInsets.all(_paddingEdgeInsetsAll),
            child: SvgPicture.asset(this.rightIcon, width: 20, color: Colors.white),
            onPressed: this.onRightClick)]
      );
    }
  }

}



