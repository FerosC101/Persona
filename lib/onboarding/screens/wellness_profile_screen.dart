import 'package:flutter/material.dart';

import '../widgets/shared_widgets.dart';

class WellnessProfileScreen extends StatelessWidget {
  const WellnessProfileScreen({
    super.key,
    required this.activityLevels,
    required this.sleepSchedules,
    required this.selectedActivity,
    required this.selectedSleep,
    required this.onActivitySelected,
    required this.onSleepSelected,
    required this.onContinue,
    required this.onBack,
  });

  final List<(String, String)> activityLevels;
  final List<(String, String)> sleepSchedules;
  final String selectedActivity;
  final String selectedSleep;
  final ValueChanged<String> onActivitySelected;
  final ValueChanged<String> onSleepSelected;
  final VoidCallback onContinue;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      title: 'Build Your Wellness Profile',
      subtitle: 'Help us personalize your recommendations',
      onBack: onBack,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SectionLabel('Activity Level'),
          const SizedBox(height: 10),
          ...activityLevels.map(
            (activity) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: SelectionCard(
                title: activity.$1,
                subtitle: activity.$2,
                selected: selectedActivity == activity.$1,
                onTap: () => onActivitySelected(activity.$1),
              ),
            ),
          ),
          const SizedBox(height: 10),
          const SectionLabel('Sleep Schedule'),
          const SizedBox(height: 10),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            childAspectRatio: 1.7,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            physics: const NeverScrollableScrollPhysics(),
            children: sleepSchedules
                .map(
                  (sleep) => SelectionCard(
                    title: sleep.$1,
                    subtitle: sleep.$2,
                    selected: selectedSleep == sleep.$1,
                    onTap: () => onSleepSelected(sleep.$1),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 26),
          GradientButton(label: 'Continue', onPressed: onContinue),
        ],
      ),
    );
  }
}
