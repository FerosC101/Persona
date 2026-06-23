import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
 
import '../../workflows/deep_work/deep_work_setup.dart';
import '../../workflows/breathing/breathing_setup.dart';
import '../../workflows/sleep/sleep_setup.dart';
import '../../workflows/wind_down/wind_down_setup.dart';
import '../../workflows/pomodoro/pomodoro_setup.dart';
import '../../workflows/hydration/hydration_coach.dart';
import '../../workflows/energy_reset/energy_reset_setup.dart';
import '../../design_system.dart';
import '../../models/recommendation_item.dart';
import '../../persona_colors.dart';
import '../tab_widgets/home_bottom_nav_bar.dart';
import '../tab_widgets/mini_recommendation_card.dart';
import '../tab_widgets/recommendation_card.dart';
 
const _highPriorityItems = <RecommendationItem>[
  RecommendationItem(
    icon: Icons.nightlight_round,
    iconColor: PersonaColors.sleepPurple,
    category: 'Sleep Improvement',
    title: 'Optimize Your Sleep Schedule',
    description:
        'Based on your sleep patterns, we recommend going to bed 30 minutes earlier. '
        'Your best sleep quality occurs when you sleep between 10 PM and 6 AM.',
    actionText: 'Set Bedtime',
    actionColor: PersonaColors.sleepPurple,
  ),
  RecommendationItem(
    icon: Icons.air,
    iconColor: PersonaColors.stressPink,
    category: 'Stress Relief',
    title: 'Breathing Exercise',
    description:
        'Your stress levels are slightly elevated. A quick breathing exercise can help '
        'calm your nervous system and improve focus.',
    actionText: 'Start Exercise',
    actionColor: PersonaColors.stressPink,
  ),
];
 
const _suggestedItems = <RecommendationItem>[
  RecommendationItem(
    icon: Icons.bolt,
    iconColor: PersonaColors.focusTeal,
    category: 'Focus Enhancement',
    title: 'Deep Work Session',
    description:
        'You are entering your peak focus hours. Activate Focus Mode for distraction-free '
        'productivity with ambient lighting and scent.',
    actionText: 'Activate Focus',
    actionColor: PersonaColors.focusTealAction,
  ),
  RecommendationItem(
    icon: Icons.favorite_border,
    iconColor: PersonaColors.selfCareOrange,
    category: 'Self-Care',
    title: 'Evening Wind-Down Routine',
    description:
        'Your wind-down routine improves sleep quality by 23%. Start your relaxation ritual '
        'with lavender scent and warm lighting.',
    actionText: 'Begin Routine',
    actionColor: PersonaColors.selfCareOrange,
  ),
  RecommendationItem(
    icon: Icons.coffee_outlined,
    iconColor: PersonaColors.productivityGreen,
    category: 'Productivity',
    title: 'Pomodoro Focus Session',
    description:
        'Your productivity peaks with 25-minute focused intervals. Try a Pomodoro session '
        'with peppermint scent for enhanced concentration.',
    actionText: 'Start Session',
    actionColor: PersonaColors.productivityGreen,
  ),
];
 
const _miniItems = <MiniRecommendationItem>[
  MiniRecommendationItem(
    icon: Icons.water_drop_outlined,
    iconColor: PersonaColors.hydrationBlue,
    title: 'Stay Hydrated',
    subtitle: 'Hydration',
    buttonColor: PersonaColors.hydrationBlue,
    buttonBgColor: PersonaColors.hydrationBlueBg,
  ),
  MiniRecommendationItem(
    icon: Icons.wb_sunny_outlined,
    iconColor: PersonaColors.energyOrange,
    title: 'Afternoon Energy Reset',
    subtitle: 'Energy Boost',
    buttonColor: PersonaColors.energyOrange,
    buttonBgColor: PersonaColors.energyOrangeBg,
  ),
];
 
class AiScreen extends StatelessWidget {
  const AiScreen({super.key});
 
  @override
  Widget build(BuildContext context) {
    return const _AiRecommendationsScreen();
  }
}
 
class _AiRecommendationsScreen extends StatelessWidget {
  const _AiRecommendationsScreen();
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: PersonaSpacing.screenHorizontal,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              const _AiHeader(),
              const SizedBox(height: 24),
              const _HighPrioritySection(),
              const SizedBox(height: 32),
              const _SuggestedSection(),
              const SizedBox(height: 30),
              const _WhenYouHaveTimeSection(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const HomeBottomNavBar(selectedIndex: 2),
    );
  }
}
 
class _AiHeader extends StatelessWidget {
  const _AiHeader();
 
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'AI Recommendations',
          style: GoogleFonts.dmSans(
            fontSize: 26,
            fontWeight: FontWeight.w800,
            color: PersonaColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Personalized wellness guidance for you',
          style: PersonaTextStyles.screenSubtitle,
        ),
      ],
    );
  }
}
 
class _HighPrioritySection extends StatelessWidget {
  const _HighPrioritySection();
 
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'High Priority',
              style: GoogleFonts.dmSans(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: PersonaColors.textPrimary,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: PersonaColors.highPriorityBadgeBg,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Needs Attention',
                style: TextStyle(
                  color: PersonaColors.highPriorityBadgeText,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ..._highPriorityItems.asMap().entries.map(
          (entry) {
            final idx = entry.key;
            final item = entry.value;
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: RecommendationCard(
                item: item,
                onTapAction: () {
                  if (idx == 0) {
                    // SLEEP OPTIMIZATION (We will build this UI next!)
                    showModalBottomSheet<void>(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (_) => const Padding(
                        padding: EdgeInsets.only(top: 48),
                        child: SleepSetupSheet(), // Keep the old placeholder for now
                      ),
                    );
                  } else if (idx == 1) {
                    // NEW BREATHING EXERCISE SHEET
                    showModalBottomSheet<void>(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (_) => const Padding(
                        padding: EdgeInsets.only(top: 48),
                        child: BreathingSetupSheet(), 
                      ),
                    );
                  }
                },
                isPriority: true,
              ),
            );
          },
        ),
      ],
    );
  }
}
 
class _SuggestedSection extends StatelessWidget {
  const _SuggestedSection();
 
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Suggested For You',
          style: GoogleFonts.dmSans(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: PersonaColors.textPrimary,
          ),
        ),
        const SizedBox(height: 20),
        ..._suggestedItems.asMap().entries.map(
          (entry) {
            final idx = entry.key;
            final item = entry.value;
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: RecommendationCard(
                item: item,
                onTapAction: () {
                  if (idx == 0) {
                    // NEW DEEP WORK SHEET
                    showModalBottomSheet<void>(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (_) => const Padding(
                        padding: EdgeInsets.only(top: 48),
                        child: DeepWorkSetupSheet(), 
                      ),
                    );
                  } else if (idx == 1) {
                    showModalBottomSheet<void>(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (_) => const Padding(
                        padding: EdgeInsets.only(top: 48),
                        child: WindDownSetupSheet(), // Keep old placeholder
                      ),
                    );
                  } else if (idx == 2) {
                    showModalBottomSheet<void>(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (_) => const Padding(
                        padding: EdgeInsets.only(top: 48),
                        child: PomodoroSetupSheet(), // Keep old placeholder
                      ),
                    );
                  }
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
 
class _WhenYouHaveTimeSection extends StatelessWidget {
  const _WhenYouHaveTimeSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'When You Have Time',
          style: GoogleFonts.dmSans(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: PersonaColors.textPrimary,
          ),
        ),
        const SizedBox(height: 20),
        // We use .asMap().entries.map so we can get the 'idx' (index) of the card
        ..._miniItems.asMap().entries.map(
          (entry) {
            final idx = entry.key;
            final item = entry.value;
            
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: MiniRecommendationCard(
                item: item,
                onTap: () {
                  if (idx == 0) {
                    showModalBottomSheet<void>(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (_) => const Padding(
                        padding: EdgeInsets.only(top: 48), 
                        child: HydrationCoachSheet(),
                      ),
                    );
                  } else if (idx == 1) {
                    showModalBottomSheet<void>(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (_) => const Padding(
                        padding: EdgeInsets.only(top: 48), 
                        child: EnergyResetSetupSheet(),
                      ),
                    );
                  } else {
                    // Fallback for any extra items you might add later
                    showModalBottomSheet<void>(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (_) => Padding(
                        padding: const EdgeInsets.only(top: 48),
                        child: TryItMiniModal(title: item.title),
                      ),
                    );
                  }
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
// ---------------------------------------------------------------------------
// Modals for AI actions
// ---------------------------------------------------------------------------

class SetBedtimeModal extends StatefulWidget {
  const SetBedtimeModal({super.key});

  @override
  State<SetBedtimeModal> createState() => _SetBedtimeModalState();
}

class _SetBedtimeModalState extends State<SetBedtimeModal> {
  TimeOfDay _time = TimeOfDay(hour: 22, minute: 0);

  Future<void> _pickTime() async {
    final t = await showTimePicker(context: context, initialTime: _time);
    if (t != null) setState(() => _time = t);
  }

  void _save() {
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Bedtime set to ${_time.format(context)}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.4,
      minChildSize: 0.3,
      maxChildSize: 0.8,
      builder: (context, controller) => Container(
        decoration: BoxDecoration(
          color: PersonaColors.scaffold,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.black.withOpacity(0.06), borderRadius: BorderRadius.circular(4))),
            ),
            const SizedBox(height: 12),
            Text('Set Bedtime', style: GoogleFonts.dmSans(fontSize: 20, fontWeight: FontWeight.w800, color: PersonaColors.textPrimary)),
            const SizedBox(height: 12),
            Text('Choose your preferred bedtime to improve sleep timing.', style: PersonaTextStyles.cardBody),
            const SizedBox(height: 18),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _pickTime,
                    style: OutlinedButton.styleFrom(backgroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                    child: Text(_time.format(context), style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Row(children: [Expanded(child: OutlinedButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel'))), const SizedBox(width: 12), Expanded(child: ElevatedButton(onPressed: _save, child: const Text('Save')))]),
          ],
        ),
      ),
    );
  }
}

class StartExerciseModal extends StatefulWidget {
  const StartExerciseModal({super.key});

  @override
  State<StartExerciseModal> createState() => _StartExerciseModalState();
}

class _StartExerciseModalState extends State<StartExerciseModal> {
  String _type = 'Breathing';
  int _minutes = 5;

  void _start() {
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Started $_minutes-minute $_type exercise')));
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.3,
      maxChildSize: 0.9,
      builder: (context, controller) => Container(
        decoration: BoxDecoration(color: PersonaColors.scaffold, borderRadius: const BorderRadius.vertical(top: Radius.circular(20))),
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          controller: controller,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.black.withOpacity(0.06), borderRadius: BorderRadius.circular(4)))),
            const SizedBox(height: 12),
            Text('Start Exercise', style: GoogleFonts.dmSans(fontSize: 20, fontWeight: FontWeight.w800, color: PersonaColors.textPrimary)),
            const SizedBox(height: 12),
            Text('Select a short mindful exercise to reduce stress.', style: PersonaTextStyles.cardBody),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(value: _type, decoration: const InputDecoration(filled: true, fillColor: Colors.white, border: OutlineInputBorder()), items: <String>['Breathing', 'Box Breathing', 'Body Scan'].map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(), onChanged: (v) => setState(() => _type = v ?? _type)),
            const SizedBox(height: 12),
            Text('Duration ($_minutes minutes)', style: PersonaTextStyles.cardCategory),
            Slider(value: _minutes.toDouble(), min: 1, max: 20, divisions: 19, label: '$_minutes', onChanged: (v) => setState(() => _minutes = v.round())),
            const SizedBox(height: 16),
            Row(children: [Expanded(child: OutlinedButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel'))), const SizedBox(width: 12), Expanded(child: ElevatedButton(onPressed: _start, child: const Text('Start')))]),
          ]),
        ),
      ),
    );
  }
}

class ActivateFocusModal extends StatefulWidget {
  const ActivateFocusModal({super.key});

  @override
  State<ActivateFocusModal> createState() => _ActivateFocusModalState();
}

class _ActivateFocusModalState extends State<ActivateFocusModal> {
  int _minutes = 25;

  void _activate() {
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Focus mode activated for $_minutes minutes')));
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.45,
      minChildSize: 0.3,
      maxChildSize: 0.9,
      builder: (context, controller) => Container(
        decoration: BoxDecoration(color: PersonaColors.scaffold, borderRadius: const BorderRadius.vertical(top: Radius.circular(20))),
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.black.withOpacity(0.06), borderRadius: BorderRadius.circular(4)))),
          const SizedBox(height: 12),
          Text('Activate Focus', style: GoogleFonts.dmSans(fontSize: 20, fontWeight: FontWeight.w800, color: PersonaColors.textPrimary)),
          const SizedBox(height: 12),
          Text('Start a distraction-free focus session with ambient changes.', style: PersonaTextStyles.cardBody),
          const SizedBox(height: 12),
          DropdownButtonFormField<int>(value: _minutes, decoration: const InputDecoration(filled: true, fillColor: Colors.white, border: OutlineInputBorder()), items: <int>[15, 25, 45, 60].map((m) => DropdownMenuItem(value: m, child: Text('$m minutes'))).toList(), onChanged: (v) => setState(() => _minutes = v ?? _minutes)),
          const SizedBox(height: 16),
          Row(children: [Expanded(child: OutlinedButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel'))), const SizedBox(width: 12), Expanded(child: ElevatedButton(onPressed: _activate, child: const Text('Activate')))]),
        ]),
      ),
    );
  }
}

class BeginRoutineModal extends StatefulWidget {
  const BeginRoutineModal({super.key});

  @override
  State<BeginRoutineModal> createState() => _BeginRoutineModalState();
}

class _BeginRoutineModalState extends State<BeginRoutineModal> {
  bool _lighting = true;
  bool _scent = true;

  void _start() {
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Routine started')));
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.45,
      minChildSize: 0.3,
      maxChildSize: 0.9,
      builder: (context, controller) => Container(
        decoration: BoxDecoration(color: PersonaColors.scaffold, borderRadius: const BorderRadius.vertical(top: Radius.circular(20))),
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.black.withOpacity(0.06), borderRadius: BorderRadius.circular(4)))),
          const SizedBox(height: 12),
          Text('Begin Routine', style: GoogleFonts.dmSans(fontSize: 20, fontWeight: FontWeight.w800, color: PersonaColors.textPrimary)),
          const SizedBox(height: 12),
          Text('Start your wind-down routine with these options.', style: PersonaTextStyles.cardBody),
          const SizedBox(height: 12),
          SwitchListTile(title: const Text('Lighting'), value: _lighting, onChanged: (v) => setState(() => _lighting = v)),
          SwitchListTile(title: const Text('Scent'), value: _scent, onChanged: (v) => setState(() => _scent = v)),
          const SizedBox(height: 12),
          Row(children: [Expanded(child: OutlinedButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel'))), const SizedBox(width: 12), Expanded(child: ElevatedButton(onPressed: _start, child: const Text('Start')))]),
        ]),
      ),
    );
  }
}

class StartSessionModal extends StatefulWidget {
  const StartSessionModal({super.key});

  @override
  State<StartSessionModal> createState() => _StartSessionModalState();
}

class _StartSessionModalState extends State<StartSessionModal> {
  int _minutes = 25;

  void _start() {
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Started session: $_minutes minutes')));
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.45,
      minChildSize: 0.3,
      maxChildSize: 0.9,
      builder: (context, controller) => Container(
        decoration: BoxDecoration(color: PersonaColors.scaffold, borderRadius: const BorderRadius.vertical(top: Radius.circular(20))),
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.black.withOpacity(0.06), borderRadius: BorderRadius.circular(4)))),
          const SizedBox(height: 12),
          Text('Start Session', style: GoogleFonts.dmSans(fontSize: 20, fontWeight: FontWeight.w800, color: PersonaColors.textPrimary)),
          const SizedBox(height: 12),
          Text('Configure a focused work session.', style: PersonaTextStyles.cardBody),
          const SizedBox(height: 12),
          DropdownButtonFormField<int>(value: _minutes, decoration: const InputDecoration(filled: true, fillColor: Colors.white, border: OutlineInputBorder()), items: <int>[15, 25, 30, 45].map((m) => DropdownMenuItem(value: m, child: Text('$m minutes'))).toList(), onChanged: (v) => setState(() => _minutes = v ?? _minutes)),
          const SizedBox(height: 12),
          Row(children: [Expanded(child: OutlinedButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel'))), const SizedBox(width: 12), Expanded(child: ElevatedButton(onPressed: _start, child: const Text('Start')))]),
        ]),
      ),
    );
  }
}

class TryItMiniModal extends StatelessWidget {
  const TryItMiniModal({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.38,
      minChildSize: 0.28,
      maxChildSize: 0.9,
      builder: (context, controller) => Container(
        decoration: BoxDecoration(color: PersonaColors.scaffold, borderRadius: const BorderRadius.vertical(top: Radius.circular(20))),
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.black.withOpacity(0.06), borderRadius: BorderRadius.circular(4)))),
          const SizedBox(height: 12),
          Text(title, style: GoogleFonts.dmSans(fontSize: 20, fontWeight: FontWeight.w800, color: PersonaColors.textPrimary)),
          const SizedBox(height: 12),
          Text('Quick action to try this recommendation now.', style: PersonaTextStyles.cardBody),
          const SizedBox(height: 18),
          Row(children: [Expanded(child: OutlinedButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Close'))), const SizedBox(width: 12), Expanded(child: ElevatedButton(onPressed: () { Navigator.of(context).pop(); ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Tried "$title"'))); }, child: const Text('Try It')))]),
        ]),
      ),
    );
  }
}