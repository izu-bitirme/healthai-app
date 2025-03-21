import 'package:flutter/material.dart';

class CustomSafeArea extends StatelessWidget {
  final Widget child;

  const CustomSafeArea({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top > 20 ? 10.0 : 0.0;
    final bottomPadding = MediaQuery.of(context).padding.bottom > 20 ? 10.0 : 0.0;

    return Padding(
      padding: EdgeInsets.only(
        top: topPadding, 
        bottom: bottomPadding, 
        left: 0.0,
        right: 0.0, 
      ),
      child: child,
    );
  }
}
