import 'package:flutter/material.dart';

import '../full_page.dart';
import '../services/firebase_auth_service.dart';
import 'screens/account_screen.dart';
import 'screens/landing_screen.dart';
import 'screens/login_screen.dart';
import 'screens/personalize_screen.dart';
import 'screens/wellness_profile_screen.dart';
import 'widgets/shared_widgets.dart';

class PersonaOnboardingFlow extends StatefulWidget {
  const PersonaOnboardingFlow({super.key});

  @override
  State<PersonaOnboardingFlow> createState() => _PersonaOnboardingFlowState();
}

class _PersonaOnboardingFlowState extends State<PersonaOnboardingFlow> {
  final _pageController = PageController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _dobController = TextEditingController();
  late final FirebaseAuthService _authService;

  bool _obscurePassword = true;
  int _pageIndex = 0;
  String _selectedGender = 'Male';
  String _selectedActivity = 'Lightly Active';
  String _selectedSleep = 'Regular';
  bool _wantsDock = false;
  bool _wellnessNotifications = true;
  bool _anonymousDataSharing = false;

  final List<(String, String)> _activityLevels = const [
    ('Sedentary', 'Little to no exercise'),
    ('Lightly Active', '1–3 days/week'),
    ('Moderately Active', '3–5 days/week'),
    ('Very Active', '6–7 days/week'),
    ('Athlete', 'Intense daily training'),
  ];

  final List<(String, String)> _sleepSchedules = const [
    ('Early Bird', '9 PM - 5 AM'),
    ('Regular', '10 PM - 6 AM'),
    ('Night Owl', '12 AM - 8 AM'),
    ('Flexible', 'Varies daily'),
  ];

  @override
  void initState() {
    super.initState();
    _authService = FirebaseAuthService();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  void _goToPage(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 420),
      curve: Curves.easeOutCubic,
    );
  }

  /// Handle sign-in button press - attempt login with entered credentials
  Future<void> _handleSignIn() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    final success = await _authService.login(
      email: email,
      password: password,
    );

    if (!mounted) return;

    if (success) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _authService.errorMessage ?? 'Invalid credentials. Please try again.',
        ),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Future<void> _handleCompleteRegistration() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    final success = await _authService.createAccount(
      name: name,
      email: email,
      password: password,
    );

    if (!mounted) return;

    if (success) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _authService.errorMessage ?? 'Could not complete registration.',
        ),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF2B0F3C), Color(0xFF1C0A2B), Color(0xFF12061E)],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              const GlowOrb(top: 40, left: -30, size: 200, color: Color(0x55A855F7)),
              const GlowOrb(bottom: 40, right: -20, size: 220, color: Color(0x44D279FF)),
              PageView(
                controller: _pageController,
                onPageChanged: (index) => setState(() => _pageIndex = index),
                children: [
                  LandingScreen(onContinue: () => _goToPage(1)),
                  LoginScreen(
                    obscurePassword: _obscurePassword,
                    emailController: _emailController,
                    passwordController: _passwordController,
                    onTogglePassword: () => setState(() => _obscurePassword = !_obscurePassword),
                    onSignIn: _handleSignIn,
                    onCreateAccount: () => _goToPage(2),
                  ),
                  AccountScreen(
                    nameController: _nameController,
                    emailController: _emailController,
                    passwordController: _passwordController,
                    dobController: _dobController,
                    selectedGender: _selectedGender,
                    onGenderChanged: (value) => setState(() => _selectedGender = value),
                    onContinue: () => _goToPage(3),
                    onBack: () => _goToPage(1),
                  ),
                  WellnessProfileScreen(
                    activityLevels: _activityLevels,
                    sleepSchedules: _sleepSchedules,
                    selectedActivity: _selectedActivity,
                    selectedSleep: _selectedSleep,
                    onActivitySelected: (value) => setState(() => _selectedActivity = value),
                    onSleepSelected: (value) => setState(() => _selectedSleep = value),
                    onContinue: () => _goToPage(4),
                    onBack: () => _goToPage(2),
                  ),
                  PersonalizeScreen(
                    wantsDock: _wantsDock,
                    wellnessNotifications: _wellnessNotifications,
                    anonymousDataSharing: _anonymousDataSharing,
                    onWantsDockChanged: (value) => setState(() => _wantsDock = value),
                    onWellnessNotificationsChanged: (value) => setState(() => _wellnessNotifications = value),
                    onAnonymousDataSharingChanged: (value) => setState(() => _anonymousDataSharing = value),
                    onBack: () => _goToPage(3),
                    onComplete: _handleCompleteRegistration,
                  ),
                ],
              ),
              if (_pageIndex > 0)
                Positioned(
                  top: 14,
                  left: 20,
                  right: 20,
                  child: StepIndicator(step: _pageIndex, totalSteps: 4),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
