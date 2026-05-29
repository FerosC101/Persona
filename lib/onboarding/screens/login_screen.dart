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
    return ScreenScaffold(
      showBack: false,
      title: 'Welcome Back',
      subtitle: 'Sign in to continue your wellness journey',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 12),
          const Center(child: PersonaLogo(size: 104)),
          const SizedBox(height: 28),
          LabelledField(
            label: 'Email Address',
            child: TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(hintText: 'you@example.com'),
            ),
          ),
          const SizedBox(height: 18),
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
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(foregroundColor: PersonaColors.purple),
              child: const Text('Forgot password?'),
            ),
          ),
          const SizedBox(height: 4),
          GradientButton(label: 'Sign In', onPressed: onSignIn),
          const SizedBox(height: 18),
          const DividerOr(),
          const SizedBox(height: 18),
          Center(
            child: GestureDetector(
              onTap: onCreateAccount,
              child: const Text.rich(
                TextSpan(
                  text: "Don't have an account? ",
                  style: TextStyle(color: PersonaColors.muted, fontSize: 15),
                  children: [
                    TextSpan(text: 'Create Account', style: TextStyle(color: PersonaColors.cyan, fontWeight: FontWeight.w700)),
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
