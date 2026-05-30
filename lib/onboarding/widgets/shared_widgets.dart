import 'dart:ui';

import 'package:flutter/material.dart';

import '../../persona_colors.dart';

class PersonaSharedWidgets {
  const PersonaSharedWidgets._();
}

class ScreenScaffold extends StatelessWidget {
  const ScreenScaffold({super.key, required this.title, required this.subtitle, required this.child, this.showBack = true, this.onBack});

  final String title;
  final String subtitle;
  final Widget child;
  final bool showBack;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(20, 64, 20, 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showBack)
            GestureDetector(
              onTap: onBack,
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.arrow_back_ios_new_rounded, size: 16, color: PersonaColors.muted),
                  SizedBox(width: 6),
                  Text('Back', style: TextStyle(color: PersonaColors.muted, fontSize: 15)),
                ],
              ),
            )
          else
            const SizedBox(height: 16),
          const SizedBox(height: 24),
          GlassCard(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            background: Colors.transparent,
            borderColor: Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w800, letterSpacing: -0.5)),
                const SizedBox(height: 8),
                Text(subtitle, style: const TextStyle(color: PersonaColors.muted, fontSize: 16, height: 1.35)),
                const SizedBox(height: 22),
                child,
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class GlowOrb extends StatelessWidget {
  const GlowOrb({super.key, this.top, this.left, this.right, this.bottom, required this.size, required this.color});

  final double? top;
  final double? left;
  final double? right;
  final double? bottom;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: IgnorePointer(
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(colors: [color, color.withValues(alpha: 0.0)]),
          ),
        ),
      ),
    );
  }
}

class GlassCard extends StatelessWidget {
  const GlassCard({super.key, required this.child, this.padding, this.background, this.borderColor});

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? background;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(26),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          padding: padding ?? const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: background ?? const Color(0x88131B2B),
            borderRadius: BorderRadius.circular(26),
            border: Border.all(color: borderColor ?? const Color(0x223A4666)),
          ),
          child: child,
        ),
      ),
    );
  }
}

class BrandMark extends StatelessWidget {
  const BrandMark({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.auto_awesome_rounded, color: PersonaColors.purple, size: 18),
        SizedBox(width: 6),
        Text('Persona', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
      ],
    );
  }
}

class PersonaLogo extends StatelessWidget {
  const PersonaLogo({super.key, required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(color: PersonaColors.purple.withValues(alpha: 0.35), blurRadius: 30, spreadRadius: 2),
          BoxShadow(color: PersonaColors.cyan.withValues(alpha: 0.18), blurRadius: 16, spreadRadius: 1),
        ],
      ),
      child: ClipOval(
        child: Image.asset(
          'Persona Logo.png',
          fit: BoxFit.cover,
          filterQuality: FilterQuality.high,
        ),
      ),
    );
  }
}

class IconBubble extends StatelessWidget {
  const IconBubble({super.key, required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(colors: [PersonaColors.purple, PersonaColors.cyan]),
        boxShadow: [BoxShadow(color: PersonaColors.cyan.withValues(alpha: 0.22), blurRadius: 14)],
      ),
      child: Icon(icon, color: Colors.white, size: 20),
    );
  }
}

class StepIndicator extends StatelessWidget {
  const StepIndicator({super.key, required this.step, this.totalSteps = 3});

  final int step;
  final int totalSteps;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(totalSteps, (index) {
        final active = index < step;
        return Expanded(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 320),
            curve: Curves.easeOut,
            height: 4,
            margin: EdgeInsets.only(right: index == totalSteps - 1 ? 0 : 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(999),
              gradient: active ? const LinearGradient(colors: [PersonaColors.purple, PersonaColors.cyan]) : null,
              color: active ? null : const Color(0xFF273047),
              boxShadow: active ? [BoxShadow(color: PersonaColors.cyan.withValues(alpha: 0.25), blurRadius: 12, spreadRadius: 1)] : null,
            ),
          ),
        );
      }),
    );
  }
}

class GradientButton extends StatelessWidget {
  const GradientButton({super.key, required this.label, required this.onPressed});

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [PersonaColors.purple, PersonaColors.cyan]),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [BoxShadow(color: PersonaColors.cyan.withValues(alpha: enabled ? 0.28 : 0.16), blurRadius: 22, spreadRadius: 1)],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(28),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 18),
            child: Center(child: Text(label, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: Colors.white))),
          ),
        ),
      ),
    );
  }
}

class SelectionCard extends StatelessWidget {
  const SelectionCard({super.key, required this.title, required this.subtitle, required this.selected, required this.onTap});

  final String title;
  final String subtitle;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        color: selected ? const Color(0xFF17263C) : PersonaColors.field,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: selected ? PersonaColors.cyan : PersonaColors.outline, width: selected ? 1.3 : 1),
        boxShadow: selected ? [BoxShadow(color: PersonaColors.cyan.withValues(alpha: 0.14), blurRadius: 18, spreadRadius: 1)] : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                const SizedBox(height: 6),
                Text(subtitle, style: const TextStyle(color: PersonaColors.muted, height: 1.25)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PillChoice extends StatelessWidget {
  const PillChoice({super.key, required this.label, required this.selected, required this.onTap});

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: selected ? const LinearGradient(colors: [PersonaColors.purple, PersonaColors.cyan]) : null,
        color: selected ? null : PersonaColors.field,
        border: Border.all(color: selected ? Colors.transparent : PersonaColors.outline),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
            child: Center(child: Text(label, style: TextStyle(fontWeight: FontWeight.w600, color: selected ? Colors.white : PersonaColors.text))),
          ),
        ),
      ),
    );
  }
}

class ToggleCard extends StatelessWidget {
  const ToggleCard({super.key, required this.title, required this.subtitle, required this.value, required this.onChanged});

  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                const SizedBox(height: 6),
                Text(subtitle, style: const TextStyle(color: PersonaColors.muted)),
              ],
            ),
          ),
          Switch.adaptive(
            value: value,
            onChanged: onChanged,
            activeThumbColor: PersonaColors.cyan,
            activeTrackColor: PersonaColors.cyan.withValues(alpha: 0.35),
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: const Color(0xFF3A4358),
          ),
        ],
      ),
    );
  }
}

class InfoPanel extends StatelessWidget {
  const InfoPanel({super.key, required this.icon, required this.title, required this.child});

  final IconData icon;
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [IconBubble(icon: icon), const SizedBox(width: 12), Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800))]),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}

class LabelledField extends StatelessWidget {
  const LabelledField({super.key, required this.label, required this.child, this.helper});

  final String label;
  final Widget child;
  final String? helper;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionLabel(label),
        const SizedBox(height: 10),
        child,
        if (helper != null) ...[
          const SizedBox(height: 8),
          Text(helper!, style: const TextStyle(color: PersonaColors.muted, fontSize: 12.5)),
        ],
      ],
    );
  }
}

class SectionLabel extends StatelessWidget {
  const SectionLabel(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: const TextStyle(color: Color(0xFFB7C0D4), fontSize: 13.5, fontWeight: FontWeight.w500));
  }
}

class DividerOr extends StatelessWidget {
  const DividerOr({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(child: Divider(color: Color(0x223A4666), thickness: 1)),
        Padding(padding: EdgeInsets.symmetric(horizontal: 12), child: Text('or', style: TextStyle(color: PersonaColors.muted))),
        Expanded(child: Divider(color: Color(0x223A4666), thickness: 1)),
      ],
    );
  }
}
