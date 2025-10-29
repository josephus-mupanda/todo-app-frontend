import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_frontend/data/models/auth_dto.dart';
import 'package:todo_frontend/data/providers/auth_provider.dart';
import 'package:todo_frontend/screens/onboarding/page_right_screen.dart';
import '../../../core/constants/constants.dart';
import '../../../core/layout/responsive_widget.dart';
import '../../../core/utils/images.dart';
import '../../../core/utils/loading.dart';
import '../../../core/utils/toast.dart';
import '../../../core/widgets/button_widget.dart';
import '../../../core/widgets/input_widget.dart';
import '../../../routes/app_routes.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  String? username, password;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool showPassword = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      body: Container(
        constraints: const BoxConstraints(maxWidth: Constants.kMaxWidth),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Stack(
                      //fit: StackFit.loose,
                      children: [
                        SingleChildScrollView(
                          child: Container(
                            height: size.height,
                            width: size.width,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.background,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Padding(
                                      padding: Responsive.isMobile(context)?
                                          const EdgeInsets.all(0):
                                          const EdgeInsets.all(Constants.kDefaultPadding),
                                      child: Card(
                                        color: Theme.of(context).cardColor,
                                        child: Padding(
                                          padding: const EdgeInsets.all(Constants.kDefaultPadding),
                                          child: Form(
                                            key: _formKey,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Center(
                                                  child: Image.asset(ImagePath.companyLogo,
                                                  height: 100,),
                                                ),
                                                Text(
                                                  'Sign In',
                                                  style: theme.textTheme.headlineLarge?.copyWith(
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                const SizedBox(height: 30),
                                                InputWidget(
                                                  obscureText: false,
                                                  hintText: 'Enter Username',
                                                  keyboardType: TextInputType.name,
                                                  prefixIcon: Icons.person,
                                                  onChanged: (String? value) => username = value!,
                                                  validator: (String? value) => value!.isEmpty ? "Field is required" : null,
                                                ),
                                                InputWidget(
                                                  obscureText: !showPassword,
                                                  hintText: 'Enter Password',
                                                  prefixIcon: Icons.lock,
                                                  maxLines: 1,
                                                  suffixIcon: IconButton(
                                                    icon: Icon(
                                                      showPassword ? Icons.visibility : Icons.visibility_off,
                                                      color: theme.colorScheme.onSurface.withOpacity(0.5),
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        showPassword = !showPassword;
                                                      });
                                                    },
                                                  ),
                                                  onChanged: (String? value) => password = value!,
                                                  validator: (String? value) {
                                                    return value!.isEmpty
                                                        ? "Field is required"
                                                        : value.length < 6
                                                        ? "Password must be at least 6 characters"
                                                        : null;
                                                  },
                                                ),
                                                const SizedBox(height: 10),
                                                AppButton(
                                                  onPressed: () async {
                                                    if (_formKey.currentState?.validate() ?? false) {
                                                      await _login(context);
                                                    }
                                                  },
                                                  text:  'Sign In',
                                                ),
                                                const SizedBox(height: 10),
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.pushNamed(
                                                      context,
                                                      AppRoutes.resetPassword,
                                                    );
                                                  },
                                                  child: Center(
                                                    child: Text.rich(
                                                      TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text: 'Forgot Password? ',
                                                            style: theme.textTheme.bodyMedium?.copyWith(
                                                              color: theme.colorScheme.onBackground,
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text: 'Reset Here',
                                                            style: theme.textTheme.bodyMedium?.copyWith(
                                                              color: theme.primaryColor,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 20),
                                                Row(
                                                  children: [
                                                    const Expanded(child: Divider()),
                                                    Padding(
                                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                                      child: Text('OR', style: theme.textTheme.bodyMedium),
                                                    ),
                                                    const Expanded(child: Divider()),
                                                  ],
                                                ),
                                                const SizedBox(height: 20),
                                                Container(
                                                  width: size.width,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(color: theme.primaryColor),
                                                    borderRadius: BorderRadius.circular(5),
                                                  ),
                                                  padding: const EdgeInsets.symmetric(
                                                      horizontal: 10, vertical: 10),
                                                  child: Row(
                                                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                    children: [
                                                      const Spacer(),
                                                      SizedBox(
                                                        height: 25,
                                                        child: Image.asset(ImagePath.google),
                                                      ),
                                                      const SizedBox(width: Constants.kDefaultPadding),
                                                      Text(
                                                        'Sign In with Google',
                                                        style: theme.textTheme.bodyMedium?.copyWith(
                                                          color: theme.colorScheme.onBackground,
                                                        ),
                                                      ),
                                                      const Spacer(),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(height: 20),
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.pushNamed(
                                                      context,
                                                      AppRoutes.register,
                                                    );
                                                  },
                                                  child: Center(
                                                    child: Text.rich(
                                                      TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text: 'New to this app? ',
                                                            style: theme.textTheme.bodyMedium?.copyWith(
                                                              color: theme.colorScheme.onBackground,
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text: 'Register',
                                                            style: theme.textTheme.bodyMedium?.copyWith(
                                                              color: theme.primaryColor,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                // Only show the right-side panel on desktop screens
                                if (Responsive.isDesktop(context)) 
                                  const PageRightSide(
                                    title: "Welcome Back,\nLogin to continue your adventure! 👋",
                                    icon: ImagePath.loginSvg,
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> _login(BuildContext context) async {
 
    // Show loading dialog
    showLoadingDialog(context);

    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);

        // Build the DTO object
        final loginDTO = LoginDTO(
          email: username!, 
          password: password!,
        );

        // Call login
        await authProvider.login(context, loginDTO);

        if (!context.mounted) return;
        Navigator.of(context).pop(); // Close the loading dialog

        // If login was successful, AuthProvider will have a user set
        if (authProvider.isAuthenticated) {
          showSuccessToast(context, "Login successful!");
          Navigator.pushReplacementNamed(context, AppRoutes.home);
        } else {
          showErrorToast(context, "Invalid credentials. Please try again.");
        }
      }
      catch (e) {
      if (!context.mounted) return ;
      Navigator.of(context).pop();
      showErrorToast(context, "An unexpected error occurred.");
    }
  }
}
