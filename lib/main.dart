import 'package:flutter/material.dart';
import 'package:healthai/pages/ai/ai_chat.dart';
import 'package:healthai/pages/ai/welcome_chat.dart';
import 'package:healthai/pages/auth/change_pass.dart';
import 'package:healthai/pages/auth/code_verification_page.dart';
import 'package:healthai/pages/auth/login_page.dart';
import 'package:healthai/pages/auth/reset_password.dart';
import 'package:healthai/pages/auth/signup_page.dart';
import 'package:healthai/pages/tasks/my_task.dart';
import 'package:healthai/pages/settings/about.dart';
import 'package:healthai/pages/settings/faq.dart';
import 'package:healthai/pages/settings/privacy.dart';
import 'package:healthai/pages/settings/profile.dart';
import 'package:healthai/pages/settings/settings.dart';
import 'package:healthai/pages/settings/terms.dart';
import 'package:healthai/providers/ai_chat.dart';
import 'package:healthai/providers/profile_provider.dart';
import 'package:healthai/providers/user_provider.dart';
import 'package:healthai/providers/widgets_providers.dart';
import 'package:healthai/screens/home_screen.dart';
import 'package:healthai/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

void main() {
  return runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AiChatProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => ImagePickerProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: ToastificationWrapper(child: App()),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/home': (context) => HomeScreen(),
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignUpPage(),
        '/reset-password': (context) => ResetPasswordPage(),
        '/new-password': (context) => ChangePasswordPage(),
        '/verification': (context) => VerificationPage(),
        '/chat-ai': (context) => ChatAiPage(),
        '/welcome-chat': (context) => WelcomeChat(),
        '/profile': (context) => ProfilePage(),
        '/settings': (context) => SettingsPage(),
        '/faq': (context) => FAQPage(),
        '/about': (context) => AboutUsPage(),
        '/privacy': (context) => PrivacyPolicyPage(),
        '/terms': (context) => TermsConditionsPage(),
        '/my-tasks': (context) => MyTasksPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
