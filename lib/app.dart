import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/global_session_overlay.dart';
import 'core/session_manager.dart';
import 'full_page.dart';
import 'main_tabs/tab_screens/ai_screen.dart';
import 'main_tabs/tab_screens/dock_screen.dart';
import 'main_tabs/tab_screens/mood_screen.dart';
import 'persona_colors.dart';
import 'main_tabs/tab_screens/scenes_screen.dart';

class _NoAnimationPageTransitionsBuilder extends PageTransitionsBuilder {
  const _NoAnimationPageTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return child;
  }
}

class PersonaApp extends StatelessWidget {
  const PersonaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: globalNavigatorKey, 
      debugShowCheckedModeBanner: false,
      title: 'Persona',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: _NoAnimationPageTransitionsBuilder(),
            TargetPlatform.iOS: _NoAnimationPageTransitionsBuilder(),
            TargetPlatform.macOS: _NoAnimationPageTransitionsBuilder(),
            TargetPlatform.windows: _NoAnimationPageTransitionsBuilder(),
            TargetPlatform.linux: _NoAnimationPageTransitionsBuilder(),
            TargetPlatform.fuchsia: _NoAnimationPageTransitionsBuilder(),
          },
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: PersonaColors.cyan,
          brightness: Brightness.light,
          primary: PersonaColors.cyan,
          secondary: PersonaColors.purple,
          surface: Colors.white,
        ),
        textTheme: GoogleFonts.interTextTheme().copyWith(
          headlineLarge: GoogleFonts.inter(
            fontSize: 34,
            fontWeight: FontWeight.w700,
            color: PersonaColors.textPrimary,
          ),
          headlineMedium: GoogleFonts.inter(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: PersonaColors.textPrimary,
          ),
          bodyLarge: GoogleFonts.inter(
            fontSize: 16,
            color: PersonaColors.textSecondary,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: PersonaColors.field,
          hintStyle: const TextStyle(color: PersonaColors.muted),
          labelStyle: const TextStyle(color: PersonaColors.muted),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(color: PersonaColors.outline),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(color: PersonaColors.outline),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(color: PersonaColors.cyan, width: 1.2),
          ),
        ),
      ),

      builder: (context, child) {
        return Stack(
          children: [
            child!, 
            const GlobalSessionOverlay(), 
          ],
        );
      },
      initialRoute: '/scenes',
      routes: {
        '/home': (_) => const HomePage(),
        '/mood': (_) => const MoodScreen(),
        '/ai': (_) => const AiScreen(),
        '/dock': (_) => const DockScreen(),
        '/scenes': (_) => const AmbientScenesPage(),
      },
    );
  }
}
