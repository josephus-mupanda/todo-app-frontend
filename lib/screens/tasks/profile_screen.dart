import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_frontend/core/widgets/alert_widget.dart';
import 'package:todo_frontend/data/providers/auth_provider.dart';
import 'package:todo_frontend/data/providers/theme_provider.dart';
import '../../../core/constants/constants.dart';
import '../../../core/utils/toast.dart';
import '../../../core/widgets/button_widget.dart';
import '../../../routes/app_routes.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isEditing = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (authProvider.user != null) {
      _usernameController.text = authProvider.user!.username;
      _emailController.text = authProvider.user!.email;
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final authProvider = Provider.of<AuthProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      body: Container(
        constraints: const BoxConstraints(maxWidth: Constants.kMaxWidth),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(Constants.kDefaultPadding),
                  children: [
                    // Header Section
                    _buildHeaderSection(theme, authProvider),

                    const SizedBox(height: 32),

                    // Profile Information Card
                    _buildProfileInfoCard(theme, authProvider),

                    const SizedBox(height: 24),

                    // App Settings Card
                    _buildSettingsCard(theme, themeProvider),

                    const SizedBox(height: 24),

                    // Actions Card
                    _buildActionsCard(theme, authProvider),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection(ThemeData theme, AuthProvider authProvider) {
    return Row(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: theme.primaryColor.withValues(alpha: 0.6),
          child: Icon(Icons.person, size: 40, color: theme.primaryColor),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                authProvider.user?.username ?? 'User',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                authProvider.user?.email ?? 'user@example.com',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProfileInfoCard(ThemeData theme, AuthProvider authProvider) {
    return Card(
      color: theme.cardColor,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Profile Information',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _isEditing = !_isEditing;
                    });
                  },
                  icon: Icon(
                    _isEditing ? Icons.close : Icons.edit,
                    color: theme.primaryColor,
                  ),
                  tooltip: _isEditing ? 'Cancel Editing' : 'Edit Profile',
                ),
              ],
            ),
            const SizedBox(height: 20),

            if (!_isEditing)
              _buildReadOnlyInfo(theme, authProvider)
            else
              _buildEditableForm(theme),
          ],
        ),
      ),
    );
  }

  Widget _buildReadOnlyInfo(ThemeData theme, AuthProvider authProvider) {
    return Column(
      children: [
        _buildInfoRow(
          theme,
          Icons.person,
          'Username',
          authProvider.user?.username ?? 'N/A',
        ),
        const SizedBox(height: 16),
        _buildInfoRow(
          theme,
          Icons.email,
          'Email',
          authProvider.user?.email ?? 'N/A',
        ),
      ],
    );
  }

  Widget _buildEditableForm(ThemeData theme) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _usernameController,
            decoration: InputDecoration(
              labelText: 'Username',
              prefixIcon: Icon(Icons.person, color: theme.primaryColor),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Username is required';
              }
              if (value.length < 3) {
                return 'Username must be at least 3 characters';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(Icons.email, color: theme.primaryColor),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Email is required';
              }
              if (!RegExp(
                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
              ).hasMatch(value)) {
                return 'Enter a valid email';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          if (_isLoading)
            const Center(child: CircularProgressIndicator())
          else
            AppButton(onPressed: _updateProfile, text: 'Save Changes'),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    ThemeData theme,
    IconData icon,
    String label,
    String value,
  ) {
    return Row(
      children: [
        Icon(icon, color: theme.primaryColor, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsCard(ThemeData theme, ThemeProvider themeProvider) {
    return Card(
      color: theme.cardColor,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'App Settings',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      themeProvider.isDarkTheme
                          ? Icons.dark_mode
                          : Icons.light_mode,
                      color: theme.primaryColor,
                    ),
                    const SizedBox(width: 12),
                    Text('Dark Mode', style: theme.textTheme.bodyMedium),
                  ],
                ),
                Switch(
                  value: themeProvider.isDarkTheme,
                  onChanged: (value) {
                    themeProvider.toggleTheme();
                  },
                  activeColor: theme.primaryColor,
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildSettingItem(
              theme,
              Icons.notifications,
              'Push Notifications',
              'Receive task reminders',
              true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingItem(
    ThemeData theme,
    IconData icon,
    String title,
    String subtitle,
    bool value,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, color: theme.primaryColor, size: 20),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: theme.textTheme.bodyMedium),
                Text(
                  subtitle,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ],
        ),
        Switch(
          value: value,
          onChanged: (newValue) {
            // Handle setting change
          },
          activeColor: theme.primaryColor,
        ),
      ],
    );
  }

  Widget _buildActionsCard(ThemeData theme, AuthProvider authProvider) {
    return Card(
      color: theme.cardColor,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Actions',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 20),
            _buildActionButton(
              theme,
              Icons.help_center,
              'Help & Support',
              'Get help with the app',
              () {
                showInfoToast(context, "Help & Support coming soon!");
              },
            ),

            const SizedBox(height: 16),
            _buildActionButton(
              theme,
              Icons.logout,
              'Logout',
              'Sign out of your account',
              _logout,
              isDestructive: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(
    ThemeData theme,
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap, {
    bool isDestructive = false,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isDestructive ? Colors.red : theme.primaryColor,
      ),
      title: Text(
        title,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: isDestructive ? Colors.red : null,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
      ),
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }

  Future<void> _updateProfile() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);

      try {
        // Simulate API call - replace with your actual update profile logic
        await Future.delayed(const Duration(seconds: 2));

        if (context.mounted) {
          showSuccessToast(context, "Profile updated successfully!");
          setState(() {
            _isEditing = false;
          });
        }
      } catch (e) {
        if (context.mounted) {
          showErrorToast(context, "Failed to update profile: ${e.toString()}");
        }
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    }
  }

  Future<void> _logout() async {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text("Logout"),
          content: const Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(dialogContext).pop(); 
                final authProvider = Provider.of<AuthProvider>(
                  context,
                  listen: false,
                );
                await authProvider.logout(context);
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text("Logout"),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
