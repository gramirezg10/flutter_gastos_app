import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white70,
      child: Center(
        child: CupertinoActivityIndicator(
          radius: 15,
          animating: true,
        ),
      ),
    );
  }
}
