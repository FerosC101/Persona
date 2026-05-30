import 'package:flutter/material.dart';

import '../../persona_colors.dart';
import '../widgets/shared_widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({
    super.key,
    required this.obscurePassword,
    required this.emailController,
    required this.passwordController,
    required this.onTogglePassword,
    required this.onSignIn,
    required this.onCreateAccount,
  });

  final bool obscurePassword;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onTogglePassword;
  final VoidCallback onSignIn;
  final VoidCallback onCreateAccount;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(20, 48, 20, 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 12),
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        PersonaColors.purple.withValues(alpha: 0.4),
                        PersonaColors.purple.withValues(alpha: 0.0),
                      ],
                    ),
                  ),
                ),
                const PersonaLogo(size: 72),
              ],
            ),
          ),
          const SizedBox(height: 32),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome back',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Sign in to continue your wellness journey',
                style: TextStyle(
                  color: PersonaColors.muted,
                  fontSize: 16,
                  height: 1.35,
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),
          LabelledField(
            label: 'Email Address',
            child: TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(hintText: 'you@example.com'),
            ),
          ),
          const SizedBox(height: 20),
          LabelledField(
            label: 'Password',
            child: TextField(
              controller: passwordController,
              obscureText: obscurePassword,
              decoration: InputDecoration(
                hintText: '••••••••',
                suffixIcon: IconButton(
                  onPressed: onTogglePassword,
                  icon: Icon(
                    obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                    color: PersonaColors.muted,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                foregroundColor: PersonaColors.muted,
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
              ),
              child: const Text('Forgot password?', style: TextStyle(fontSize: 14)),
            ),
          ),
          const SizedBox(height: 20),
          GradientButton(label: 'Sign in', onPressed: onSignIn),
          const SizedBox(height: 24),
          const DividerOr(),
          const SizedBox(height: 24),
          Center(
            child: GestureDetector(
              onTap: onCreateAccount,
              child: const Text.rich(
                TextSpan(
                  text: "Don't have an account? ",
                  style: TextStyle(color: PersonaColors.muted, fontSize: 15),
                  children: [
                    TextSpan(
                      text: 'Create Account',
                      style: TextStyle(
                        color: PersonaColors.cyan,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
