
import 'package:flutter/material.dart';

import '../../../core/constants/constants.dart';
import '../../../core/layout/responsive_widget.dart';
import '../../../core/utils/images.dart';
import '../../../core/utils/toast.dart';
import '../../../core/widgets/button_widget.dart';
import '../../../core/widgets/input_widget.dart';
import '../../../routes/app_routes.dart';

import 'package:provider/provider.dart';
import 'package:todo_frontend/data/providers/auth_provider.dart';
import 'package:todo_frontend/screens/onboarding/page_right_screen.dart';


class ChangePasswordScreen extends StatefulWidget {
  final String? resetCode;

  const ChangePasswordScreen({super.key, this.resetCode});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {

  String? newPassword, confirmNewPassword;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool showPassword = false;
  bool showConfirmPassword = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    
    // If reset code is provided via deep link, show success message
    if (widget.resetCode != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showSuccessToast(context, "Reset code loaded successfully!");
      });
    }
  }

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
                      fit: StackFit.loose,
                      children: [
                        Center(
                          child: SingleChildScrollView(
                            child: Container(
                              height: size.height,
                              width: size.width,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.surface,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Center(
                                      child: SingleChildScrollView(
                                        child: Padding(
                                          padding: const EdgeInsets.all(Constants.kDefaultPadding),
                                          child: Card(
                                            color: Theme.of(context).cardColor,
                                            child: Padding(
                                              padding: Responsive.isMobile(context)
                                                  ? const EdgeInsets.all(0)
                                                  : const EdgeInsets.all(Constants.kDefaultPadding),
                                              child: Form(
                                                key: _formKey,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Center(
                                                      child: Image.asset(
                                                        ImagePath.companyLogo,
                                                        height: 100,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 20),
                                                    Text(
                                                      'Change Password',
                                                      style: theme.textTheme.headlineLarge?.copyWith(
                                                        fontWeight: FontWeight.w700,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 10),
                                                    if (widget.resetCode != null)
                                                      Container(
                                                        padding: const EdgeInsets.all(12),
                                                        decoration: BoxDecoration(
                                                          color: theme.primaryColor.withValues(alpha: 0.6

)

,
                                                          borderRadius: BorderRadius.circular(8),
                                                          border: Border.all(color: theme.primaryColor),
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            Icon(
                                                              Icons.check_circle,
                                                              color: theme.primaryColor,
                                                              size: 16,
                                                            ),
                                                            const SizedBox(width: 8),
                                                            Expanded(
                                                              child: Text(
                                                                'Reset code loaded: ${widget.resetCode}',
                                                                style: theme.textTheme.bodySmall?.copyWith(
                                                                  color: theme.primaryColor,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    else
                                                      Text(
                                                        'Enter your new password below.',
                                                        style: theme.textTheme.bodyMedium?.copyWith(
                                                          color: theme.colorScheme.onSurface.withValues(alpha: 0.6

)

,
                                                        ),
                                                      ),
                                                    const SizedBox(height: 30),
                                                    InputWidget(
                                                      obscureText: !showPassword,
                                                      hintText: 'Enter New Password',
                                                      prefixIcon: Icons.lock,
                                                      maxLines: 1,
                                                      suffixIcon: IconButton(
                                                        icon: Icon(
                                                          showPassword
                                                              ? Icons.visibility
                                                              : Icons.visibility_off,
                                                          color: theme.colorScheme.onSurface.withValues(alpha: 0.6

)

,
                                                        ),
                                                        onPressed: () {
                                                          setState(() {
                                                            showPassword = !showPassword;
                                                          });
                                                        },
                                                      ),
                                                      onChanged: (String? value) => newPassword = value!,
                                                      validator: (String? value) {
                                                        if (value == null || value.isEmpty) {
                                                          return "Password is required";
                                                        }
                                                        if (value.length < 6) {
                                                          return "Password must be at least 6 characters";
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                    const SizedBox(height: 20),
                                                    InputWidget(
                                                      obscureText: !showConfirmPassword,
                                                      hintText: 'Confirm New Password',
                                                      prefixIcon: Icons.lock,
                                                      maxLines: 1,
                                                      suffixIcon: IconButton(
                                                        icon: Icon(
                                                          showConfirmPassword
                                                              ? Icons.visibility
                                                              : Icons.visibility_off,
                                                          color: theme.colorScheme.onSurface.withValues(alpha: 0.6

)

,
                                                        ),
                                                        onPressed: () {
                                                          setState(() {
                                                            showConfirmPassword = !showConfirmPassword;
                                                          });
                                                        },
                                                      ),
                                                      onChanged: (String? value) => confirmNewPassword = value!,
                                                      validator: (String? value) {
                                                        if (value == null || value.isEmpty) {
                                                          return "Please confirm your password";
                                                        }
                                                        if (value.length < 6) {
                                                          return "Password must be at least 6 characters";
                                                        }
                                                        if (value != newPassword) {
                                                          return "Passwords do not match";
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                    const SizedBox(height: 20),
                                                    if (_isLoading)
                                                      const Center(child: CircularProgressIndicator())
                                                    else
                                                      AppButton(
                                                        onPressed: _changePassword,
                                                        text: 'Change Password',
                                                      ),
                                                    const SizedBox(height: 20),
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.pushReplacementNamed(
                                                          context,
                                                          AppRoutes.login,
                                                        );
                                                      },
                                                      child: Center(
                                                        child: Text.rich(
                                                          TextSpan(
                                                            children: [
                                                              TextSpan(
                                                                text: 'Back to ',
                                                                style: theme.textTheme.bodyMedium?.copyWith(
                                                                  color: theme.colorScheme.onSurface,
                                                                ),
                                                              ),
                                                              TextSpan(
                                                                text: 'Login',
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
                                  ),
                                  // Only show the right-side panel on desktop screens
                                  if (Responsive.isDesktop(context))
                                    const PageRightSide(
                                      title: "Set a New Password,\nKeep your account secure! 🔐",
                                      icon: ImagePath.changePasswordSvg,
                                    ),
                                ],
                              ),
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

  Future<void> _changePassword() async {
    if (_formKey.currentState?.validate() ?? false) {
      // Check if we have a reset code
      if (widget.resetCode == null) {
        showErrorToast(context, "Reset code is missing. Please request a new reset code.");
        return;
      }

      setState(() => _isLoading = true);

      try {
        final authProvider = Provider.of<AuthProvider>(context, listen: false);
        
        // Call the change password service with reset code and new password
        final success = await authProvider.changePassword(
          context, 
          widget.resetCode!, 
          newPassword!
        );
        
        if (success && context.mounted) {
          // Show success message
          showSuccessToast(context, "Password changed successfully!");
          
          // Reset form
          _formKey.currentState?.reset();
          setState(() {
            newPassword = null;
            confirmNewPassword = null;
          });
          
          // Navigate to login after short delay
          await Future.delayed(const Duration(seconds: 1));
          
          if (context.mounted) {
            Navigator.pushReplacementNamed(context, AppRoutes.login);
          }
        }
      } catch (e) {
        // Error is already handled in the service
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    }
  }
}
