import 'package:flutter/material.dart';
import '../../../core/layout/responsive_widget.dart';
import '../../../core/utils/images.dart';
import '../../../core/widgets/button_widget.dart';
import '../../../routes/app_routes.dart';

import 'package:provider/provider.dart';
import 'package:todo_frontend/data/providers/auth_provider.dart';
import 'package:todo_frontend/screens/onboarding/page_right_screen.dart';
import '../../../core/constants/constants.dart';
import '../../../core/utils/toast.dart';

class ConfirmEmailScreen extends StatefulWidget {
  final String? verificationCode;

  const ConfirmEmailScreen({super.key, this.verificationCode});

  @override
  State<ConfirmEmailScreen> createState() => _ConfirmEmailScreenState();
}

class _ConfirmEmailScreenState extends State<ConfirmEmailScreen> {

  final List<TextEditingController> _otpControllers = List.generate(6, (index) => TextEditingController());
  final List<FocusNode> _otpFocusNodes = List.generate(6, (index) => FocusNode());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  bool _isLoading = false;
  bool _isResending = false;

  @override
  void initState() {
    super.initState();
    
    // Pre-fill OTP if code comes from deep link
    if (widget.verificationCode != null && widget.verificationCode!.length == 6) {
      for (int i = 0; i < 6; i++) {
        _otpControllers[i].text = widget.verificationCode![i];
      }
      // Auto-submit if code is pre-filled
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _confirmEmail();
      });
    }

    // Setup focus node listeners for auto-moving between fields
    for (int i = 0; i < 6; i++) {
      _otpFocusNodes[i].addListener(() {
        if (!_otpFocusNodes[i].hasFocus && i < 5) {
          _otpFocusNodes[i + 1].requestFocus();
        }
      });
    }
  }

  String get _enteredCode {
    return _otpControllers.map((controller) => controller.text).join();
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
                                          padding: Responsive.isMobile(context)
                                              ? const EdgeInsets.all(0)
                                              : const EdgeInsets.all(Constants.kDefaultPadding),
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
                                                      child: Image.asset(
                                                        ImagePath.companyLogo,
                                                        height: 100,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 20),
                                                    Text(
                                                      'Verify Your Email',
                                                      style: theme.textTheme.headlineLarge?.copyWith(
                                                        fontWeight: FontWeight.w700,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 10),
                                                    Text(
                                                      'We sent a 6-digit verification code to your email address.',
                                                      style: theme.textTheme.bodyMedium?.copyWith(
                                                        color: theme.colorScheme.onSurface.withValues(alpha: 0.6

)

,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 30),
                                                    
                                                    // OTP Input Fields
                                                    _buildOtpInputFields(theme),
                                                    
                                                    const SizedBox(height: 30),
                                                    
                                                    if (_isLoading)
                                                      const Center(child: CircularProgressIndicator())
                                                    else
                                                      AppButton(
                                                        onPressed: _confirmEmail,
                                                        text: 'Verify Email',
                                                      ),
                                                    
                                                    const SizedBox(height: 20),
                                                    
                                                    // Resend Code Section
                                                    _buildResendSection(theme),
                                                    
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
                                                    
                                                    const SizedBox(height: 20),
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
                                      title: "Almost there!\nVerify your email to get started 🚀",
                                      icon: ImagePath.loginSvg, // You'll need to add this SVG
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

  Widget _buildOtpInputFields(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Enter Verification Code',
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(6, (index) {
            return SizedBox(
              width: 50,
              height: 60,
              child: TextFormField(
                controller: _otpControllers[index],
                focusNode: _otpFocusNodes[index],
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                maxLength: 1,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  counterText: '',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: theme.primaryColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: theme.primaryColor, width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: theme.colorScheme.outline),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 15),
                ),
                onChanged: (value) {
                  if (value.length == 1 && index < 5) {
                    FocusScope.of(context).requestFocus(_otpFocusNodes[index + 1]);
                  }
                  if (value.isEmpty && index > 0) {
                    FocusScope.of(context).requestFocus(_otpFocusNodes[index - 1]);
                  }
                  
                  // Auto-submit when all fields are filled
                  if (_enteredCode.length == 6) {
                    _confirmEmail();
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '';
                  }
                  return null;
                },
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildResendSection(ThemeData theme) {
    return Column(
      children: [
        Text(
          "Didn't receive the code?",
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.6

)

,
          ),
        ),
        const SizedBox(height: 5),
        _isResending
            ? const CircularProgressIndicator.adaptive()
            : GestureDetector(
                onTap: _resendConfirmation,
                child: Text(
                  "Resend Code",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.primaryColor,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
      ],
    );
  }

  Future<void> _confirmEmail() async {
    final code = _enteredCode;
    
    if (code.length != 6) {
      showErrorToast(context, "Please enter the complete 6-digit code");
      return;
    }

    setState(() => _isLoading = true);
    
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final success = await authProvider.confirmEmail(context, code);
      
      if (success && context.mounted) {
        showSuccessToast(context, "Email verified successfully!");
        Navigator.pushReplacementNamed(context, AppRoutes.login);
      }
    } catch (e) {
      // Error is already handled in the service
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _resendConfirmation() async {
    setState(() => _isResending = true);
    
    try {
      // TODO: Implement resend confirmation email logic
      // You might need to store the user's email from registration
      // or ask them to enter it again
      await Future.delayed(const Duration(seconds: 1)); // Simulate API call
      
      if (context.mounted) {
        showSuccessToast(context, "Verification code sent to your email!");
      }
    } catch (e) {
      if (context.mounted) {
        showErrorToast(context, "Failed to resend code. Please try again.");
      }
    } finally {
      if (mounted) {
        setState(() => _isResending = false);
      }
    }
  }

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var focusNode in _otpFocusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }
}