import 'package:flutter/material.dart';

import '../../persona_colors.dart';
import '../widgets/shared_widgets.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key, required this.onContinue});

  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(24, 80, 24, 36),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 12),
          const Text(
            'Welcome to Persona',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.4,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Your AI-powered wellness companion',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: PersonaColors.muted,
              fontSize: 16,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 48),
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 220,
                  height: 220,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        PersonaColors.purple.withValues(alpha: 0.6),
                        PersonaColors.purple.withValues(alpha: 0.35),
                        PersonaColors.purple.withValues(alpha: 0.0),
                      ],
                      stops: const [0.0, 0.55, 1.0],
                    ),
                  ),
                ),
                const PersonaLogo(size: 92),
              ],
            ),
          ),
          const SizedBox(height: 52),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              'Persona adapts to your emotional state,\ncreating personalized wellness\nexperience that evolve with you.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: PersonaColors.muted,
                fontSize: 15,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 36),
          GradientButton(label: 'Continue', onPressed: onContinue),
        ],
      ),
    );
  }
}
