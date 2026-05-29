import 'package:flutter/material.dart';

import '../../persona_colors.dart';
import '../widgets/shared_widgets.dart';

class PersonalizeScreen extends StatelessWidget {
  const PersonalizeScreen({
    super.key,
    required this.wantsDock,
    required this.wellnessNotifications,
    required this.anonymousDataSharing,
    required this.onWantsDockChanged,
    required this.onWellnessNotificationsChanged,
    required this.onAnonymousDataSharingChanged,
    required this.onBack,
  });

  final bool wantsDock;
  final bool wellnessNotifications;
  final bool anonymousDataSharing;
  final ValueChanged<bool> onWantsDockChanged;
  final ValueChanged<bool> onWellnessNotificationsChanged;
  final ValueChanged<bool> onAnonymousDataSharingChanged;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      title: 'Personalize Your Experience',
      subtitle: 'Final touches for your wellness journey',
      onBack: onBack,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InfoPanel(
            icon: Icons.favorite_border,
            title: 'Persona Dock',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Do you have or plan to get a Persona Dock for adaptive lighting and scent diffusion?',
                  style: TextStyle(color: PersonaColors.muted, height: 1.4),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(child: PillChoice(label: 'Yes', selected: wantsDock, onTap: () => onWantsDockChanged(true))),
                    const SizedBox(width: 12),
                    Expanded(child: PillChoice(label: 'Not yet', selected: !wantsDock, onTap: () => onWantsDockChanged(false))),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ToggleCard(title: 'Wellness Notifications', subtitle: 'Reminders and recommendations', value: wellnessNotifications, onChanged: onWellnessNotificationsChanged),
          const SizedBox(height: 12),
          ToggleCard(title: 'Anonymous Data Sharing', subtitle: 'Help improve wellness insights', value: anonymousDataSharing, onChanged: onAnonymousDataSharingChanged),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xFF1C1833).withValues(alpha: 0.9),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: const Color(0xFF6353C7).withValues(alpha: 0.35)),
              boxShadow: [BoxShadow(color: const Color(0xFF8B5CF6).withValues(alpha: 0.12), blurRadius: 30, spreadRadius: 1)],
            ),
            child: const Text(
              'By creating an account, you agree to Persona’s Terms of Service and Privacy Policy. Your health data is encrypted and never shared without consent.',
              style: TextStyle(color: PersonaColors.muted, height: 1.45),
            ),
          ),
          const SizedBox(height: 24),
          GradientButton(label: 'Complete Registration', onPressed: () {}),
        ],
      ),
    );
  }
}
