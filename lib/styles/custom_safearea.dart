import 'package:flutter/material.dart';

class CustomSafeArea extends StatelessWidget {
  final Widget child;

  const CustomSafeArea({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    // Ekranın üst ve alt padding'lerini alıp biraz küçültüyoruz
    final topPadding = MediaQuery.of(context).padding.top > 20 ? 10.0 : 0.0;
    final bottomPadding = MediaQuery.of(context).padding.bottom > 20 ? 10.0 : 0.0;

    return Padding(
      padding: EdgeInsets.only(
        top: topPadding, // Üst boşluk
        bottom: bottomPadding, // Alt boşluk
        left: 0.0, // Sol boşluk
        right: 0.0, // Sağ boşluk
      ),
      child: child,
    );
  }
}
