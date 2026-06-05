import 'package:flutter/material.dart';
import 'persona_colors.dart'; // Imports the colors so your styles can use them!

// TEXT STYLES
abstract final class PersonaTextStyles {
  // --- Screen Headings ---
  static const screenTitle = TextStyle(
    fontSize: 34,
    fontWeight: FontWeight.bold,
    color: PersonaColors.textPrimary,
  );
  
  static const screenSubtitle = TextStyle(
    fontSize: 16,
    color: PersonaColors.textSecondary,
  );

  // --- Section Headings ---
  static const sectionTitleLarge = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: PersonaColors.textPrimary,
  );
  
  static const sectionTitleMedium = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: PersonaColors.textPrimary,
  );
  
  static const sectionTitleSmall = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: PersonaColors.textPrimary,
  );

  // --- Main Recommendation Cards ---
  static const cardCategory = TextStyle(
    color: PersonaColors.textSecondary,
    fontSize: 13,
    fontWeight: FontWeight.w500,
  );
  
  static const cardTitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: PersonaColors.textPrimary,
    height: 1.2,
  );
  
  static const cardBody = TextStyle(
    fontSize: 14,
    color: PersonaColors.textBody,
    height: 1.5,
  );
  
  static const cardButtonLabel = TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
  );

  // --- Mini Task Cards ---
  static const miniCardTitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: PersonaColors.textPrimary,
  );
  
  static const miniCardSubtitle = TextStyle(
    fontSize: 13,
    color: PersonaColors.textSecondary,
  );
  
  static const miniCardButton = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 13,
  );

  // --- Bottom Navigation ---
  static const navLabel = TextStyle(
    fontSize: 12,
    color: PersonaColors.textSecondary,
    fontWeight: FontWeight.w500,
  );
  
  static const navLabelSelected = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: PersonaColors.primaryPurple,
  );
}

// SPACING & RADIUS
abstract final class PersonaSpacing {
  static const screenHorizontal  = 24.0;
  static const cardPadding       = 20.0;
  
  static const cardRadius        = 28.0;
  static const miniCardRadius    = 20.0;
  static const iconRadius        = 14.0;
  static const miniIconRadius    = 12.0;
  static const buttonRadius      = 26.0;
}

// SHARED DECORATIONS (Shadows & Borders)
abstract final class PersonaDecorations {
  static final mainCard = BoxDecoration(
    color: PersonaColors.cardWhite,
    borderRadius: BorderRadius.circular(PersonaSpacing.cardRadius),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.03),
        blurRadius: 20,
        offset: const Offset(0, 6),
      ),
    ],
  );

  static final miniCard = BoxDecoration(
    color: PersonaColors.cardWhite,
    borderRadius: BorderRadius.circular(PersonaSpacing.miniCardRadius),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.02),
        blurRadius: 15,
        offset: const Offset(0, 4),
      ),
    ],
  );
}