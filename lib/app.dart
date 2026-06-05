import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'persona_colors.dart';
import 'main_tabs/tab_screens/dock_screen.dart';

class PersonaApp extends StatelessWidget {
  const PersonaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Persona',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
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
      home: const DockScreen(),
    );
  }
}
