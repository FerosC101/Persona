import 'package:flutter/foundation.dart';

import '../config/environment.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final String gender;
  final String activity;
  final String sleep;
  final bool wantsDock;
  final bool wellnessNotifications;
  final bool anonymousDataSharing;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.gender,
    required this.activity,
    required this.sleep,
    required this.wantsDock,
    required this.wellnessNotifications,
    required this.anonymousDataSharing,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'gender': gender,
      'activity': activity,
      'sleep': sleep,
      'wantsDock': wantsDock,
      'wellnessNotifications': wellnessNotifications,
      'anonymousDataSharing': anonymousDataSharing,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      gender: map['gender'] as String,
      activity: map['activity'] as String,
      sleep: map['sleep'] as String,
      wantsDock: map['wantsDock'] as bool,
      wellnessNotifications: map['wellnessNotifications'] as bool,
      anonymousDataSharing: map['anonymousDataSharing'] as bool,
    );
  }
}

class AuthService extends ChangeNotifier {
  static final AuthService _instance = AuthService._internal();

  factory AuthService() {
    return _instance;
  }

  AuthService._internal();

  /// Get seed account with current environment configuration.
  /// 
  /// IMPORTANT: Configuration is read from .env file at runtime.
  /// Update .env file and restart the app to change credentials.
  /// This getter creates a fresh User instance each time with current env values.
  User get _seedUser {
    return User(
      id: Environment.getSeedAccountId(),
      name: Environment.getSeedAccountName(),
      email: Environment.getSeedAccountEmail(),
      password: Environment.getSeedAccountPassword(),
      gender: 'Female',
      activity: 'Moderately Active',
      sleep: 'Regular',
      wantsDock: true,
      wellnessNotifications: true,
      anonymousDataSharing: false,
    );
  }

  User? _currentUser;
  bool _isLoading = false;

  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _currentUser != null;

  /// Auto-login with seed account (called on app startup)
  Future<void> autoLogin() async {
    _isLoading = true;
    notifyListeners();

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    _currentUser = _seedUser;
    _isLoading = false;
    notifyListeners();
  }

  /// Attempt to login with email and password
  Future<bool> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    // Check against seed account
    if (email == _seedUser.email && password == _seedUser.password) {
      _currentUser = _seedUser;
      _isLoading = false;
      notifyListeners();
      return true;
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  /// Create a new account (registers and logs in)
  Future<bool> createAccount({
    required String name,
    required String email,
    required String password,
    required String gender,
    required String activity,
    required String sleep,
    required bool wantsDock,
    required bool wellnessNotifications,
    required bool anonymousDataSharing,
  }) async {
    _isLoading = true;
    notifyListeners();

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 1000));

    _currentUser = User(
      id: 'user_${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      email: email,
      password: password,
      gender: gender,
      activity: activity,
      sleep: sleep,
      wantsDock: wantsDock,
      wellnessNotifications: wellnessNotifications,
      anonymousDataSharing: anonymousDataSharing,
    );

    _isLoading = false;
    notifyListeners();
    return true;
  }

  /// Logout
  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 300));

    _currentUser = null;
    _isLoading = false;
    notifyListeners();
  }

  /// Check if credentials match seed account (for login screen validation)
  bool validateCredentials(String email, String password) {
    return email == _seedUser.email && password == _seedUser.password;
  }

  /// Get seed account info for testing/demo purposes
  User getSeedUser() => _seedUser;
}
