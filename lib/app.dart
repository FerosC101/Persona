import 'package:flutter/material.dart';

import 'persona_colors.dart';
import 'onboarding/onboarding_flow.dart';
import 'main_tabs/tab_screens/ai_screen.dart';


class PersonaApp extends StatelessWidget {
  const PersonaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Persona',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: PersonaColors.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: PersonaColors.cyan,
          brightness: Brightness.dark,
          primary: PersonaColors.cyan,
          secondary: PersonaColors.purple,
          surface: PersonaColors.surface,
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
      home: const AiScreen(),
    );
  }
}
