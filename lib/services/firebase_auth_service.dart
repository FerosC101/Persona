import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

/// A lightweight Firebase email/password authentication service.
///
/// This service is used by the onboarding flow to sign in and register users
/// using Firebase Authentication. It provides friendly error messages and
/// ensures the app can transition from the login flow into the authenticated
/// home state.
class FirebaseAuthService {
  FirebaseAuthService({FirebaseAuth? auth}) : _auth = auth;

  FirebaseAuth? _auth;
  String? errorMessage;

  bool get _isFirebaseAvailable => Firebase.apps.isNotEmpty;

  FirebaseAuth? get _safeAuth {
    if (!_isFirebaseAvailable) return null;
    _auth ??= FirebaseAuth.instance;
    return _auth;
  }

  /// Sign in a user with email and password.
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    errorMessage = null;

    if (!_isFirebaseAvailable) {
      errorMessage = 'Firebase is not configured. Please follow the README to add web/android config files.';
      return false;
    }

    if (email.isEmpty || password.isEmpty) {
      errorMessage = 'Please enter your email and password.';
      return false;
    }

    try {
      final auth = _safeAuth!;
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      errorMessage = _messageForCode(e);
      return false;
    } catch (e) {
      errorMessage = 'Login failed. Please try again.';
      return false;
    }
  }

  /// Create a new Firebase Authentication account.
  Future<bool> createAccount({
    required String name,
    required String email,
    required String password,
  }) async {
    errorMessage = null;

    if (!_isFirebaseAvailable) {
      errorMessage = 'Firebase is not configured. Please follow the README to add web/android config files.';
      return false;
    }

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      errorMessage = 'Please complete all registration fields.';
      return false;
    }

    if (password.length < 8) {
      errorMessage = 'Password must be at least 8 characters.';
      return false;
    }

    try {
      final auth = _safeAuth!;
      final credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await credential.user?.updateDisplayName(name);
      return true;
    } on FirebaseAuthException catch (e) {
      errorMessage = _messageForCode(e);
      return false;
    } catch (e) {
      errorMessage = 'Registration failed. Please try again.';
      return false;
    }
  }

  Future<void> signOut() async {
    final auth = _safeAuth;
    if (auth == null) return;
    await auth.signOut();
  }

  String _messageForCode(FirebaseAuthException exception) {
    return switch (exception.code) {
      'invalid-email' => 'Please enter a valid email address.',
      'user-disabled' => 'This account has been disabled.',
      'user-not-found' => 'No account found with that email.',
      'wrong-password' => 'Incorrect password. Please try again.',
      'email-already-in-use' => 'That email is already registered.',
      'weak-password' => 'Your password is too weak.',
      _ => exception.message ?? 'Authentication error. Please try again.',
    };
  }
}
