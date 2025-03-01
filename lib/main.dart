import 'package:flutter/material.dart';
import 'package:healthai/pages/ai_chat.dart';
import 'package:healthai/pages/auth/change_pass.dart';
import 'package:healthai/pages/auth/code_verification_page.dart';
import 'package:healthai/pages/auth/login_page.dart';
import 'package:healthai/pages/auth/reset_password.dart';
import 'package:healthai/pages/auth/signup_page.dart';
import 'package:healthai/pages/home_page.dart';
import 'package:healthai/providers/ai_chat.dart';
import 'package:healthai/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';


void main() {
  return runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => AiChatProvider()),
    ], 
    child: ToastificationWrapper(child: App())),
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
        '/signup': (context) => SignUpPage(),
        '/reset-password': (context) => ResetPasswordPage(),
        '/new-password': (context) => ChangePasswordPage(),
        '/verification': (context) => VerificationPage(),
        '/chat-ai': (context) => ChatAiPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
