import 'package:flutter/material.dart';
import 'dart:math' as math;

// :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
// How to use?
// i need to create an intance
// -- final Responsive responsive = Responsive.of(context);
// -- style: TextStyle(fontSize: responsive.wp(2)) where 2 is a 2% and wp is width percent
// -- style: TextStyle(fontSize: responsive.hp(2)) where 2 is a 2% and hp is height percent
// -- style: TextStyle(fontSize: responsive.dp(2)) where 2 is a 2% and dp is diagonal percent
// -- style: TextStyle(fontSize: responsive.dp(responsive.isTablet ? 2 : 1)) where 2 is a 2% and dp is diagonal percent
// -- in a ternaria expression maxWidth: responsive.isTablet ? 400 : 200
// :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

class Responsive {
  double _width, _height, _diagonal;
  bool _isTablet;

  double get width => _width;
  double get heigth => _height;
  double get diagonal => _diagonal;
  bool get isTablet => _isTablet;

  static Responsive of(BuildContext context) => Responsive(context);

  Responsive(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;

    this._width = _size.width;
    this._height = _size.height;
    // c2 = a2 + b2
    this._diagonal =
        math.sqrt(math.pow(this._width, 2) + math.pow(this._height, 2));
    this._isTablet = _size.shortestSide >= 600;
  }

  double wp(double percent) => _width * percent / 100;
  double hp(double percent) => _height * percent / 100;
  double dp(double percent) => _diagonal * percent / 100;

  double screenWidth() => width;
}
