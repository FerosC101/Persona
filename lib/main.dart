import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'app.dart';
import 'config/environment.dart';
import 'firebase_options.dart';

export 'app.dart';

/// Initialize environment variables and Firebase before running the app.
///
/// This must be called before the app starts so Firebase is available
/// when the login flow attempts to authenticate users.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment configuration from .env file.
  // Use fallback values if file is not available.
  try {
    await dotenv.load(fileName: '.env');
    print('✓ Successfully loaded .env file');
  } catch (e) {
    print('⚠️  .env file not loaded - using default values');
  }

  // Initialize Firebase before the app starts.
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Initialize App Check for enhanced security
    await FirebaseAppCheck.instance.activate(
      providerWeb: ReCaptchaV3Provider('6Le3BQ4tAAAAAK8_fz9e_tlQ48HJUYRuOS9Z52np'),
    );
  } catch (e) {
    // Provide a clear guidance message for the common web config error
    print('❌ Firebase initialization failed: $e');
    if (e.toString().contains('FirebaseOptions cannot be null') ||
        e.toString().contains('DefaultFirebaseOptions')) {
      print('🔧 Firebase Web requires configuration options. To fix:');
      print('  1) Install the FlutterFire CLI:');
      print('       dart pub global activate flutterfire_cli');
      print('  2) From the project root run:');
      print('       flutterfire configure');
      print('     This generates `lib/firebase_options.dart` with your web options.');
      print('  3) Re-run `flutter run -d chrome`.');
    }
    print('Continuing without Firebase initialized — auth will not work until configured.');
  }

  // Debug: Print environment configuration
  Environment.debugPrintEnvironment();

  runApp(const PersonaApp());
}
