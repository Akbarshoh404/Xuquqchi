import 'package:flutter/material.dart';
import 'app_routes.dart';
import '../../features/onboarding/pages/splash_page.dart';
import '../../features/onboarding/pages/welcome_page.dart';
import '../../features/onboarding/pages/walkthrough_page.dart';
import '../../features/auth/pages/lets_you_in_page.dart';
import '../../features/auth/pages/sign_up_page.dart';
import '../../features/auth/pages/sign_in_page.dart';
import '../../features/auth/pages/fill_profile_page.dart';
import '../../features/auth/pages/create_pin_page.dart';
import '../../features/auth/pages/set_fingerprint_page.dart';
import '../../features/home/home_page.dart';
import '../../features/chat/pages/chat_history_page.dart';
import '../../features/chat/pages/chat_detail_page.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case AppRoutes.splash:
        return _route(const SplashPage());
      case AppRoutes.welcome:
        return _route(const WelcomePage());
      case AppRoutes.walkthrough:
        return _route(const WalkthroughPage());
      case AppRoutes.letsYouIn:
        return _route(const LetsYouInPage());
      case AppRoutes.signUp:
        return _route(const SignUpPage());
      case AppRoutes.signIn:
        return _route(const SignInPage());
      case AppRoutes.fillProfile:
        return _route(const FillProfilePage());
      case AppRoutes.createPin:
        return _route(const CreatePinPage());
      case AppRoutes.setFingerprint:
        return _route(const SetFingerprintPage());
      case AppRoutes.home:
        return _route(const HomePage());
      case AppRoutes.chatHistory:
        return _route(const ChatHistoryPage());
      case AppRoutes.chatDetail:
        final doctor = args as Map<String, dynamic>?;
        return _route(ChatDetailPage(
          doctorName: doctor?['name'] ?? 'Dr. Unknown',
          doctorImage: doctor?['image'] ?? '',
        ));
      default:
        return _route(const SplashPage());
    }
  }

  static MaterialPageRoute _route(Widget page) {
    return MaterialPageRoute(builder: (_) => page);
  }
}
