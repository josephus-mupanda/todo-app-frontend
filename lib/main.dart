import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_frontend/core/utils/preferences.dart';
import 'package:todo_frontend/data/providers/auth_provider.dart';
import 'package:todo_frontend/data/providers/task_provider.dart';
import 'package:todo_frontend/data/providers/theme_provider.dart';
import 'package:todo_frontend/routes/app_routes.dart';
import 'package:todo_frontend/routes/route_generator.dart';
import 'package:todo_frontend/themes/app_theme.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:uni_links/uni_links.dart';


final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    _initDeepLinks();
    _handleInitialUri();
  }

  // Handle deep links for mobile
  void _initDeepLinks() {
    if (!kIsWeb) {
      // Handle links when app is already running
      uriLinkStream.listen((Uri? uri) {
        if (!mounted) return;
        _handleDeepLink(uri);
      }, onError: (err) {
        if (!mounted) return;
        print('Deep link error: $err');
      });
    }
  }

  // Handle initial URI when app is launched via deep link
  void _handleInitialUri() async {
    if (!kIsWeb) {
      try {
        final Uri? initialUri = await getInitialUri();
        _handleDeepLink(initialUri);
      } catch (e) {
        print('Initial URI error: $e');
      }
    } else {
      // For web, check URL parameters
      _handleWebDeepLinks();
    }
  }

  void _handleDeepLink(Uri? uri) {
    if (uri == null) return;
    
    print('Handling deep link: $uri');
    
    // Handle todoapp://confirm-email?code=123456
    if (uri.scheme == 'todoapp') {
      if (uri.host == 'confirm-email') {
        final code = uri.queryParameters['code'];
        if (code != null) {
          _navigateToConfirmEmail(code);
        }
      } else if (uri.host == 'reset-password') {
        final code = uri.queryParameters['code'];
        if (code != null) {
          _navigateToResetPassword(code);
        }
      }
    }
    // Handle https:// links
    else if (uri.scheme == 'https') {
      if (uri.path.contains('confirm-email')) {
        final code = uri.queryParameters['code'];
        if (code != null) {
          _navigateToConfirmEmail(code);
        }
      } else if (uri.path.contains('reset-password')) {
        final code = uri.queryParameters['code'];
        if (code != null) {
          _navigateToResetPassword(code);
        }
      }
    }
  }

  void _navigateToConfirmEmail(String code) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      navigatorKey.currentState?.pushNamed(
        AppRoutes.confirmEmail,
        arguments: code,
      );
    });
  }

  void _navigateToResetPassword(String code) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      navigatorKey.currentState?.pushNamed(
        AppRoutes.resetPassword,
        arguments: code,
      );
    });
  }

  void _handleWebDeepLinks() {
    // For web, we can check the current URL
    final uri = Uri.base;
    _handleDeepLink(uri);
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    
    return MaterialApp(
      title: 'Todo App',
      theme: themeProvider.isDarkTheme ? AppTheme.darkTheme : AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splash,
      onGenerateRoute: RouteGenerator.generateRoute,
      navigatorKey: navigatorKey,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.noScaling,
          ),
          child: child!,
        );
      },
    );
  }
}