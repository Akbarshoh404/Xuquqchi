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
import '../../features/booking/lawyer_detail_screen.dart';
import '../../features/booking/booking_screen.dart';
import '../../features/booking/booking_success_screen.dart';
import '../../features/booking/review_screen.dart';
import '../../features/booking/models/lawyer_model.dart';

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
        final tabArgs = args as Map<String, dynamic>?;
        return _route(HomePage(initialTab: tabArgs?['tab'] as int? ?? 0));
      case AppRoutes.chatHistory:
        return _route(const ChatHistoryPage());
      case AppRoutes.chatDetail:
        final doctor = args as Map<String, dynamic>?;
        return _route(ChatDetailPage(
          doctorName: doctor?['name'] ?? 'Unknown',
          doctorImage: doctor?['image'] ?? '',
        ));
      case AppRoutes.lawyerDetail:
        final lawyer = args as Lawyer;
        return _route(LawyerDetailScreen(lawyer: lawyer));
      case AppRoutes.booking:
        final lawyer = args as Lawyer;
        return _route(BookingScreen(lawyer: lawyer));
      case AppRoutes.bookingSuccess:
        final data = args as Map<String, dynamic>;
        return _route(BookingSuccessScreen(
          lawyer: data['lawyer'] as Lawyer,
          date: data['date'] as DateTime,
          time: data['time'] as String,
        ));
      case AppRoutes.reviews:
        final data = args as Map<String, dynamic>;
        return _route(ReviewScreen(
          rating: (data['rating'] as num).toDouble(),
          totalReviews: data['totalReviews'] as int,
          reviews: data['reviews'] as List<Review>,
        ));
      default:
        return _route(const SplashPage());
    }
  }

  static MaterialPageRoute _route(Widget page) {
    return MaterialPageRoute(builder: (_) => page);
  }
}
