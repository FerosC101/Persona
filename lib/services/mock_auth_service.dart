import 'package:flutter/foundation.dart';

import '../config/environment.dart';
import '../models/user.dart';

/// Enum representing different authentication states
enum AuthState {
  /// User is not authenticated
  unauthenticated,

  /// User is currently authenticating
  authenticating,

  /// User is authenticated
  authenticated,

  /// An error occurred during authentication
  error,
}

/// Mock authentication service for development and testing.
/// 
/// This service provides offline authentication with test credentials loaded
/// from environment variables. It is designed to be easily replaced with a real
/// backend implementation later.
/// 
/// Configuration is loaded from environment variables:
/// - MOCK_TEST_EMAIL: Test account email
/// - MOCK_TEST_PASSWORD: Test account password
/// 
/// DO NOT hardcode credentials here - use .env file for configuration.
class MockAuthService extends ChangeNotifier {
  // ─── State Variables ──────────────────────────────────────────────────
  AuthState _state = AuthState.unauthenticated;
  User? _currentUser;
  String? _errorMessage;

  // ─── Private Getters for Environment Variables ────────────────────────
  /// Get test email from environment (lazy-loaded on each access)
  String get _testEmail => Environment.getMockTestEmail();
  
  /// Get test password from environment (lazy-loaded on each access)
  String get _testPassword => Environment.getMockTestPassword();

  // ─── Public Getters ──────────────────────────────────────────────────
  /// Current authentication state
  AuthState get state => _state;

  /// Currently authenticated user (null if not authenticated)
  User? get currentUser => _currentUser;

  /// Whether the user is currently authenticated
  bool get isAuthenticated => _state == AuthState.authenticated;

  /// Whether an authentication request is in progress
  bool get isLoading => _state == AuthState.authenticating;

  /// Last error message (null if no error)
  String? get errorMessage => _errorMessage;

  // ─── Public Methods ──────────────────────────────────────────────────

  /// Attempt to log in with email and password.
  ///
  /// Returns true if login was successful, false otherwise.
  /// 
  /// Example:
  /// ```dart
  /// final success = await authService.login(
  ///   email: 'test@persona.dev',
  ///   password: 'password123',
  /// );
  /// if (success) {
  ///   print('Login successful!');
  /// }
  /// ```
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    // Clear previous error
    _errorMessage = null;

    // Set state to authenticating
    _state = AuthState.authenticating;
    notifyListeners();

    try {
      // Get test credentials - wrap in try-catch to handle initialization errors
      String testEmail;
      String testPassword;
      
      try {
        testEmail = _testEmail;
        testPassword = _testPassword;
        print('✓ Successfully retrieved test credentials');
      } catch (e) {
        print('❌ Error retrieving test credentials: $e');
        _state = AuthState.error;
        _errorMessage = 'Configuration error: Could not load credentials';
        notifyListeners();
        return false;
      }

      // Simulate network delay (100-500ms)
      await Future.delayed(
        Duration(milliseconds: 100 + _random.nextInt(400)),
      );

      // Validate email format
      if (!_isValidEmail(email)) {
        _state = AuthState.error;
        _errorMessage = 'Invalid email format';
        notifyListeners();
        return false;
      }

      print('Comparing: "$email" vs "$testEmail"');
      print('Comparing: "$password" vs "$testPassword"');

      // Check credentials against test account
      if (email.toLowerCase() == testEmail && password == testPassword) {
        // Successful login
        _currentUser = User(
          id: 'test-user-001',
          email: email,
          name: 'Test User',
        );
        _state = AuthState.authenticated;
        _errorMessage = null;
        notifyListeners();
        print('✓ Login successful!');
        return true;
      }

      // Invalid credentials
      _state = AuthState.error;
      
      // Provide specific error message
      if (email.toLowerCase() != testEmail) {
        _errorMessage = 'Email not found';
      } else {
        _errorMessage = 'Incorrect password';
      }
      
      notifyListeners();
      return false;
    } catch (e) {
      _state = AuthState.error;
      _errorMessage = 'Login failed: ${e.toString()}';
      notifyListeners();
      return false;
    }
  }

  /// Log out the current user.
  ///
  /// Example:
  /// ```dart
  /// await authService.logout();
  /// ```
  Future<void> logout() async {
    _state = AuthState.authenticating;
    notifyListeners();

    // Simulate logout delay
    await Future.delayed(const Duration(milliseconds: 200));

    _currentUser = null;
    _state = AuthState.unauthenticated;
    _errorMessage = null;
    notifyListeners();
  }

  /// Clear any error messages
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  // ─── Private Methods ──────────────────────────────────────────────────

  /// Simple email validation
  bool _isValidEmail(String email) {
    return email.contains('@') && email.contains('.');
  }

  /// Random instance for simulated delays (for testing)
  static final _random = DateTime.now().millisecond > 500
      ? _RandomStub(500)
      : _RandomStub(100);
}

/// Simple random stub for consistent delays (for testing)
class _RandomStub {
  final int _seed;
  _RandomStub(this._seed);
  
  int nextInt(int max) => (_seed * 13) % max;
}
///
/// ```dart
/// class LoginScreen extends StatefulWidget {
///   const LoginScreen({Key? key}) : super(key: key);
///
///   @override
///   State<LoginScreen> createState() => _LoginScreenState();
/// }
///
/// class _LoginScreenState extends State<LoginScreen> {
///   late final MockAuthService _authService;
///   late final TextEditingController _emailController;
///   late final TextEditingController _passwordController;
///
///   @override
///   void initState() {
///     super.initState();
///     _authService = MockAuthService();
///     _emailController = TextEditingController();
///     _passwordController = TextEditingController();
///   }
///
///   @override
///   void dispose() {
///     _emailController.dispose();
///     _passwordController.dispose();
///     super.dispose();
///   }
///
///   Future<void> _handleLogin() async {
///     final success = await _authService.login(
///       email: _emailController.text,
///       password: _passwordController.text,
///     );
///
///     if (success) {
///       // Navigate to home screen
///       if (mounted) {
///         Navigator.of(context).pushReplacementNamed('/home');
///       }
///     } else {
///       // Show error dialog
///       if (mounted) {
///         ScaffoldMessenger.of(context).showSnackBar(
///           SnackBar(content: Text(_authService.errorMessage ?? 'Login failed')),
///         );
///       }
///     }
///   }
///
///   @override
///   Widget build(BuildContext context) {
///     return Scaffold(
///       appBar: AppBar(title: const Text('Login')),
///       body: Padding(
///         padding: const EdgeInsets.all(16.0),
///         child: Column(
///           children: [
///             TextField(
///               controller: _emailController,
///               decoration: const InputDecoration(
///                 labelText: 'Email',
///                 hintText: 'test@persona.dev',
///               ),
///             ),
///             const SizedBox(height: 16),
///             TextField(
///               controller: _passwordController,
///               obscureText: true,
///               decoration: const InputDecoration(
///                 labelText: 'Password',
///                 hintText: 'password123',
///               ),
///             ),
///             const SizedBox(height: 24),
///             ElevatedButton(
///               onPressed: _authService.isLoading ? null : _handleLogin,
///               child: _authService.isLoading
///                   ? const CircularProgressIndicator()
///                   : const Text('Login'),
///             ),
///             if (_authService.errorMessage != null) ...[
///               const SizedBox(height: 16),
///               Text(
///                 _authService.errorMessage!,
///                 style: const TextStyle(color: Colors.red),
///               ),
///             ],
///           ],
///         ),
///       ),
///     );
///   }
/// }
/// ```
