import 'package:flutter/material.dart';
import 'package:healthai/pages/auth/login_page.dart';
import 'package:healthai/pages/home_page.dart';
import 'package:healthai/screens/splash_screen.dart';
import 'package:healthai/styles/custom_safearea.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

class P extends ChangeNotifier {}

void main() {
  return runApp(
    MultiProvider(providers: [
      Provider(create: (_) => P())
    ], child: ToastificationWrapper(child: App())),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(), // Ana sayfa burada tanımlandı
        '/home': (context) => HomePage(),
        '/login': (context) => LoginPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
