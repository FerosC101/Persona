import 'package:flutter/material.dart';

import '../services/mock_auth_service.dart';

/// Example login screen implementation using MockAuthService.
/// 
/// This demonstrates how to integrate the mock authentication system
/// with a Flutter UI.
class MockAuthLoginExample extends StatefulWidget {
  const MockAuthLoginExample({Key? key}) : super(key: key);

  @override
  State<MockAuthLoginExample> createState() => _MockAuthLoginExampleState();
}

class _MockAuthLoginExampleState extends State<MockAuthLoginExample> {
  late final MockAuthService _authService;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _authService = MockAuthService();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  /// Handle login button press
  Future<void> _handleLogin() async {
    // Clear previous errors
    _authService.clearError();

    // Attempt login
    final success = await _authService.login(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );

    if (!mounted) return;

    if (success) {
      // Login successful - navigate to home screen or app
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login successful!'),
          backgroundColor: Colors.green,
        ),
      );
      // Navigate to home screen
      // Navigator.of(context).pushReplacementNamed('/home');
    } else {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _authService.errorMessage ?? 'Login failed. Please try again.',
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mock Auth Login Example')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            const SizedBox(height: 40),
            Text(
              'Login',
              style: Theme.of(context).textTheme.headlineLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Enter your credentials to access the app',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 48),

            // Email field
            TextField(
              controller: _emailController,
              enabled: !_authService.isLoading,
              decoration: InputDecoration(
                labelText: 'Email Address',
                hintText: 'test@persona.dev',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                prefixIcon: const Icon(Icons.email_outlined),
                errorText:
                    _authService.state == AuthState.error &&
                            (_authService.errorMessage?.contains('Email') ??
                                false)
                        ? _authService.errorMessage
                        : null,
              ),
              keyboardType: TextInputType.emailAddress,
            ),

            const SizedBox(height: 16),

            // Password field
            TextField(
              controller: _passwordController,
              enabled: !_authService.isLoading,
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'password123',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                prefixIcon: const Icon(Icons.lock_outlined),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                  ),
                  onPressed: () {
                    setState(() => _obscurePassword = !_obscurePassword);
                  },
                ),
                errorText:
                    _authService.state == AuthState.error &&
                            (_authService.errorMessage?.contains('Password') ??
                                false)
                        ? _authService.errorMessage
                        : null,
              ),
            ),

            const SizedBox(height: 24),

            // Login button
            ElevatedButton.icon(
              onPressed: _authService.isLoading ? null : _handleLogin,
              icon: _authService.isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.login),
              label: Text(
                _authService.isLoading ? 'Logging in...' : 'Login',
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),

            const SizedBox(height: 16),

            // Test credentials button
            OutlinedButton.icon(
              onPressed: _authService.isLoading ? null : _prefillTestCredentials,
              icon: const Icon(Icons.edit),
              label: const Text('Pre-fill Test Credentials'),
            ),

            const SizedBox(height: 32),

            // Info box
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                border: Border.all(color: Colors.blue[200]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Test Credentials',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.blue[900],
                        ),
                  ),
                  const SizedBox(height: 8),
                  _buildCredentialRow('Email:', 'test@persona.dev'),
                  const SizedBox(height: 4),
                  _buildCredentialRow('Password:', 'password123'),
                  const SizedBox(height: 12),
                  Text(
                    'This is a mock authentication system for development and testing only.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.blue[700],
                        ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Current user info (if logged in)
            if (_authService.isAuthenticated) ...[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  border: Border.all(color: Colors.green[200]!),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Logged In',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.green[900],
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'User ID: ${_authService.currentUser?.id}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      'Email: ${_authService.currentUser?.email}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      'Name: ${_authService.currentUser?.name}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () async {
                        await _authService.logout();
                        setState(() {});
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Logged out successfully'),
                            ),
                          );
                        }
                      },
                      child: const Text('Logout'),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildCredentialRow(String label, String value) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.blue[900],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontFamily: 'monospace',
              color: Colors.blue[700],
              fontSize: 12,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  void _prefillTestCredentials() {
    _emailController.text = 'test@persona.dev';
    _passwordController.text = 'password123';
    setState(() {});
  }
}
