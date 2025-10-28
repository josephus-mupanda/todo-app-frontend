import 'package:flutter/material.dart';
import 'app_routes.dart';

class RouteGenerator {

    static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case AppRoutes.register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());

      case AppRoutes.confirmEmail:
        return MaterialPageRoute(builder: (_) => const ConfirmEmailScreen());

      case AppRoutes.resetPassword:
        return MaterialPageRoute(builder: (_) => const ResetPasswordScreen());

      case AppRoutes.changePassword:
        return MaterialPageRoute(builder: (_) => const ChangePasswordScreen());

      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case AppRoutes.tasks:
        return MaterialPageRoute(builder: (_) => const TaskListScreen());

      case AppRoutes.addTask:
        return MaterialPageRoute(builder: (_) => const AddTaskScreen());

      case AppRoutes.editTask:
        final taskId = settings.arguments as String?;
        return MaterialPageRoute(
          builder: (_) => EditTaskScreen(taskId: taskId),
        );

      case AppRoutes.taskDetails:
        final taskId = settings.arguments as String?;
        return MaterialPageRoute(
          builder: (_) => TaskDetailsScreen(taskId: taskId),
        );

      case AppRoutes.profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return const NotFoundScreen();
    });
  }
}


