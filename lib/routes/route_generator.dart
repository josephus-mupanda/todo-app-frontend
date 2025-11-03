import 'package:flutter/material.dart';
import 'package:todo_frontend/screens/authentication/change_password_screen.dart';
import 'package:todo_frontend/screens/authentication/confirm_email_screen.dart';
import 'package:todo_frontend/screens/authentication/login_screen.dart';
import 'package:todo_frontend/screens/authentication/not_found_screen.dart';
import 'package:todo_frontend/screens/authentication/register_screen.dart';
import 'package:todo_frontend/screens/authentication/reset_password_screen.dart';
import 'package:todo_frontend/screens/splash/splash_screen.dart';
import 'package:todo_frontend/screens/tasks/home_screen.dart';
import '../routes/app_routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    
    final arguments = settings.arguments;

    switch (settings.name) {
      case AppRoutes.splash:
        return _buildPageRoute(const SplashScreen(), settings);

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

      case AppRoutes.addTask:
        return _buildPageRoute(const AddTaskScreen(), settings);

      case AppRoutes.editTask:
        final taskId = _extractTaskId(arguments);
        if (taskId == null) {
          return _errorRoute('Task ID is required for editing');
        }
        return _buildPageRoute(EditTaskScreen(taskId: taskId), settings);

      case AppRoutes.taskDetails:
        final taskId = _extractTaskId(arguments);
        if (taskId == null) {
          return _errorRoute('Task ID is required for details');
        }
        return _buildPageRoute(TaskDetailsScreen(taskId: taskId), settings);

      case AppRoutes.profile:
        return _buildPageRoute(const ProfileScreen(), settings);

      default:
        return _errorRoute();
    }
  }

  // Helper method to extract task ID from various argument types
  static String? _extractTaskId(dynamic arguments) {
    if (arguments is String) return arguments;
    if (arguments is Map<String, dynamic>) return arguments['taskId'] as String?;
    return null;
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

  static Route<dynamic> _errorRoute([String message = 'Page not found']) {
    return MaterialPageRoute(
      builder: (_) => NotFoundScreen(),
      settings: const RouteSettings(name: '/not-found'),
    );
  }
}
