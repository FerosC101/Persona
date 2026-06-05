import 'package:flutter/material.dart';
 
import '../../design_system.dart';
import '../../models/recommendation_item.dart';
import '../../persona_colors.dart';
import '../tab_widgets/nav_bar.dart';
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
    icon: Icons.psychology_outlined,
    iconColor: PersonaColors.stressPink,
    category: 'Stress Relief',
    title: '5-Minute Breathing Exercise',
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
    return MaterialApp(
      title: 'Wellness AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: PersonaColors.scaffold,
        primaryColor: PersonaColors.primaryPurple,
        fontFamily: 'Helvetica',
      ),
      home: const _AiRecommendationsScreen(),
    );
  }
}
 
class _AiRecommendationsScreen extends StatelessWidget {
  const _AiRecommendationsScreen();
 
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: PersonaSpacing.screenHorizontal,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              _AiHeader(),
              SizedBox(height: 24),
              _HighPrioritySection(),
              SizedBox(height: 32),
              _SuggestedSection(),
              SizedBox(height: 30),
              _WhenYouHaveTimeSection(),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }
}
 
class _AiHeader extends StatelessWidget {
  const _AiHeader();
 
  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('AI Recommendations', style: PersonaTextStyles.screenTitle),
        SizedBox(height: 8),
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
            const Text('High Priority', style: PersonaTextStyles.sectionTitleSmall),
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
        ..._highPriorityItems.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: RecommendationCard(
              item: item,
              onTapAction: () {},
              isPriority: true,
            ),
          ),
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
        const Text('Suggested For You', style: PersonaTextStyles.sectionTitleLarge),
        const SizedBox(height: 20),
        ..._suggestedItems.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: RecommendationCard(item: item, onTapAction: () {}),
          ),
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
        const Text('When You Have Time', style: PersonaTextStyles.sectionTitleMedium),
        const SizedBox(height: 20),
        ..._miniItems.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: MiniRecommendationCard(item: item, onTap: () {}),
          ),
        ),
      ],
    );
  }
}