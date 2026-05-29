import 'package:flutter/material.dart';

import '../widgets/shared_widgets.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.dobController,
    required this.selectedGender,
    required this.onGenderChanged,
    required this.onContinue,
    required this.onBack,
  });

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController dobController;
  final String selectedGender;
  final ValueChanged<String> onGenderChanged;
  final VoidCallback onContinue;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      title: 'Create Your Account',
      subtitle: 'Start your journey to adaptive wellness',
      onBack: onBack,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LabelledField(
            label: 'Full Name',
            child: TextField(controller: nameController, decoration: const InputDecoration(hintText: 'John Doe')),
          ),
          const SizedBox(height: 16),
          LabelledField(
            label: 'Email Address',
            child: TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(hintText: 'you@example.com'),
            ),
          ),
          const SizedBox(height: 16),
          LabelledField(
            label: 'Password',
            helper: 'At least 8 characters',
            child: TextField(controller: passwordController, obscureText: true, decoration: const InputDecoration(hintText: '••••••••')),
          ),
          const SizedBox(height: 16),
          LabelledField(
            label: 'Date of Birth',
            child: TextField(controller: dobController, decoration: const InputDecoration(hintText: 'MM / DD / YYYY')),
          ),
          const SizedBox(height: 16),
          const SectionLabel('Gender (Optional)'),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(child: PillChoice(label: 'Male', selected: selectedGender == 'Male', onTap: () => onGenderChanged('Male'))),
              const SizedBox(width: 10),
              Expanded(child: PillChoice(label: 'Female', selected: selectedGender == 'Female', onTap: () => onGenderChanged('Female'))),
              const SizedBox(width: 10),
              Expanded(child: PillChoice(label: 'Other', selected: selectedGender == 'Other', onTap: () => onGenderChanged('Other'))),
            ],
          ),
          const SizedBox(height: 26),
          GradientButton(label: 'Continue', onPressed: onContinue),
        ],
      ),
    );
  }
}
