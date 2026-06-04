import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Environment configuration for the application.
/// 
/// This class provides centralized access to environment variables,
/// ensuring that sensitive data is never hardcoded in the source code.
/// All configuration should be loaded from .env files during app initialization.
/// 
/// On Flutter Web, defaults are used since .env is not available as an asset.
class Environment {
  // ─── Default Configuration Values ───────────────────────────────────
  static const String _defaultSeedAccountId = 'seed_user_001';
  static const String _defaultSeedAccountName = 'Aila Roshiele';
  static const String _defaultSeedAccountEmail = 'aila@persona.app';
  static const String _defaultSeedAccountPassword = 'persona123';
  
  static const String _defaultMockTestEmail = 'test@persona.dev';
  static const String _defaultMockTestPassword = 'password123';

  // ─── Seed Account Configuration ───────────────────────────────────────
  
  /// Get the seed account ID from environment
  static String getSeedAccountId() {
    return _safeGet('SEED_ACCOUNT_ID', _defaultSeedAccountId);
  }

  /// Get the seed account name from environment
  static String getSeedAccountName() {
    return _safeGet('SEED_ACCOUNT_NAME', _defaultSeedAccountName);
  }

  /// Get the seed account email from environment
  static String getSeedAccountEmail() {
    return _safeGet('SEED_ACCOUNT_EMAIL', _defaultSeedAccountEmail);
  }

  /// Get the seed account password from environment
  static String getSeedAccountPassword() {
    return _safeGet('SEED_ACCOUNT_PASSWORD', _defaultSeedAccountPassword);
  }

  // ─── Mock Auth Configuration ─────────────────────────────────────────
  
  /// Get the mock test email from environment
  static String getMockTestEmail() {
    return _safeGet('MOCK_TEST_EMAIL', _defaultMockTestEmail);
  }

  /// Get the mock test password from environment
  static String getMockTestPassword() {
    return _safeGet('MOCK_TEST_PASSWORD', _defaultMockTestPassword);
  }

  // ─── Safe Access Helper ──────────────────────────────────────────────
  
  /// Safely retrieve environment variable with fallback
  /// Handles null, errors, and platform-specific issues (e.g., web)
  static String _safeGet(String key, String defaultValue) {
    try {
      // Safely access dotenv.env
      final envMap = dotenv.env;
      
      if (envMap.isEmpty) {
        return defaultValue;
      }
      
      final value = envMap[key];
      
      // Return value if it exists and is not empty
      if (value != null && value.isNotEmpty) {
        return value;
      }
      
      return defaultValue;
    } catch (e) {
      // On web or if dotenv is not properly initialized, use defaults
      print('ℹ️  Using default for $key (access error: $e)');
      return defaultValue;
    }
  }

  // ─── Utility Methods ─────────────────────────────────────────────────
  
  /// Check if the app is running in debug mode
  static bool get isDebugMode {
    return const bool.fromEnvironment('dart.vm.product') == false;
  }

  /// Get a configuration value with a fallback
  static String getConfig(String key, {String defaultValue = ''}) {
    return _safeGet(key, defaultValue);
  }
  
  /// Debug: Print all loaded environment variables (except passwords)
  static void debugPrintEnvironment() {
    print('=== Environment Configuration ===');
    print('Mock Test Email: ${getMockTestEmail()}');
    print('Mock Test Password: ${getMockTestPassword().replaceAll(RegExp(r'.'), '*')}');
    print('Seed Account Email: ${getSeedAccountEmail()}');
    print('Seed Account Password: ${getSeedAccountPassword().replaceAll(RegExp(r'.'), '*')}');
    print('==================================');
  }
}
