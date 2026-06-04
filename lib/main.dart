import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'app.dart';
import 'config/environment.dart';

export 'app.dart';

/// Initialize environment variables before running the app.
/// 
/// This must be called before the app starts to ensure that all
/// configuration is loaded from the .env file (or fallback values).
/// 
/// For web platforms, .env must be included in pubspec.yaml assets.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Load environment configuration from .env file
  // Use fallback values if file is not available (common on web during development)
  try {
    await dotenv.load(fileName: ".env");
    print('✓ Successfully loaded .env file');
  } catch (e) {
    // If .env is not available, dotenv will use empty values
    // The Environment class provides sensible fallbacks for development
    print('⚠️  .env file not loaded - using default values');
  }
  
  // Debug: Print environment configuration
  Environment.debugPrintEnvironment();
  
  runApp(const PersonaApp());
}
