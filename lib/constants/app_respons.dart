import 'package:flutter/material.dart';

class Responsive {
  final BuildContext context;

  Responsive(this.context);

  double heightFactor(double value) {
    return MediaQuery.of(context).size.height * value;
  }

  double widthFactor(double value) {
    return MediaQuery.of(context).size.width * value;
  }

  double fontSize(double value) {
    double scaleFactor = MediaQuery.of(context).size.width / 375;
    return value * scaleFactor;
  }
}
