import 'package:flutter/material.dart';
import 'package:todo_frontend/screens/authentication/change_password_screen.dart';
import 'package:todo_frontend/screens/authentication/confirm_email_screen.dart';
import 'package:todo_frontend/screens/authentication/login_screen.dart';
import 'package:todo_frontend/screens/authentication/not_found_screen.dart';
import 'package:todo_frontend/screens/authentication/register_screen.dart';
import 'package:todo_frontend/screens/authentication/reset_password_screen.dart';
import 'package:todo_frontend/screens/onboarding/onboarding_screen.dart';
import 'package:todo_frontend/screens/splash/splash_screen.dart';
import 'package:todo_frontend/screens/tasks/home_screen.dart';
import 'package:todo_frontend/screens/tasks/profile_screen.dart';
import 'package:todo_frontend/screens/tasks/task_list_screen.dart';
import '../routes/app_routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    
    final arguments = settings.arguments;

    switch (settings.name) {
      case AppRoutes.splash:
        return _buildPageRoute(const SplashScreen(), settings);

      case AppRoutes.onboarding:
        return _buildPageRoute(const OnBoardingScreen(), settings);

      case AppRoutes.login:
        return _buildPageRoute(const LoginScreen(), settings);

      case AppRoutes.register:
        return _buildPageRoute(const RegisterScreen(), settings);

      case AppRoutes.confirmEmail:
        // Handle both direct navigation and deep links
        String? verificationCode;
        if (arguments is String) {
          verificationCode = arguments;
        } else if (arguments is Map<String, dynamic>) {
          verificationCode = arguments['code'] as String?;
        }
        return _buildPageRoute(
          ConfirmEmailScreen(verificationCode: verificationCode),
          settings,
        );

      case AppRoutes.resetPassword:
        return _buildPageRoute(const ResetPasswordScreen(), settings);

      case AppRoutes.changePassword:
        // Handle both direct navigation and deep links
         String? resetCode;
        if (arguments is String) {
          resetCode = arguments;
        } else if (arguments is Map<String, dynamic>) {
          resetCode = arguments['code'] as String?;
        }
        return _buildPageRoute(
          ChangePasswordScreen(resetCode: resetCode),
          settings,
        );

      case AppRoutes.home:
        return _buildPageRoute(const HomeScreen(), settings);

      case AppRoutes.tasks:
        return _buildPageRoute(const TaskListScreen(), settings);

      case AppRoutes.profile:
        return _buildPageRoute(const ProfileScreen(), settings);

      default:
        return _errorRoute();
    }
  }

  // Use PageRouteBuilder for smooth transitions on both platforms
  static PageRouteBuilder<T> _buildPageRoute<T>(
    Widget page,
    RouteSettings settings,
  ) {
    return PageRouteBuilder<T>(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => NotFoundScreen(),
      settings: const RouteSettings(name: '/not-found'),
    );
  }
}
