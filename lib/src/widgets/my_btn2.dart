import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyBtn2 extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool fullWidth;
  final EdgeInsets padding;

  final Color backgroundColor, textColor;

  MyBtn2(
      {Key key,
      @required this.label,
      this.onPressed,
      this.fullWidth = false,
      this.padding,
      this.backgroundColor,
      this.textColor})
      : assert(label != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      minSize: 30,
      padding: EdgeInsets.zero,
      child: Container(
        width: fullWidth ? double.infinity : null,
        padding: padding ?? EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: Text(
          this.label,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: this.textColor ?? Colors.black,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5),
        ),
        decoration: BoxDecoration(
          color: this.backgroundColor ?? Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(color: Colors.black38, blurRadius: 10, offset: Offset(0, 5))
          ]
        ),
      ),
      onPressed: (){
        FocusScope.of(context).unfocus();
        this.onPressed();
        },
    );
  }
}
