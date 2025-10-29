import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_frontend/core/utils/preferences.dart';
import 'package:todo_frontend/data/providers/auth_provider.dart';
import 'package:todo_frontend/data/providers/task_provider.dart';
import 'package:todo_frontend/data/providers/theme_provider.dart';
import 'package:todo_frontend/routes/app_routes.dart';
import 'package:todo_frontend/routes/route_generator.dart';
import 'package:todo_frontend/themes/app_theme.dart';

void main() async {

  await Preferences.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => TaskProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    
    return MaterialApp(
      title: 'ToDo App',
      theme: !themeProvider.isDarkTheme ? AppTheme.darkTheme : AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splash,
      onGenerateRoute: RouteGenerator.generateRoute,
      navigatorKey: navigatorKey,
    
    );
  }
}

// Define a global navigator key
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
