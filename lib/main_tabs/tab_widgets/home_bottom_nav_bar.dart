import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeBottomNavBar extends StatelessWidget {
  const HomeBottomNavBar({
    super.key,
    required this.selectedIndex,
  });

  final int selectedIndex;

  static const _routes = <String>[
    '/home',
    '/mood',
    '/ai',
    '/dock',
    '/scenes',
  ];

  static const _items = <_NavItem>[
    _NavItem(icon: Icons.home_rounded, label: 'Home'),
    _NavItem(icon: Icons.favorite_border_rounded, label: 'Mood'),
    _NavItem(icon: Icons.auto_awesome_rounded, label: 'AI'),
    _NavItem(icon: Icons.speed_rounded, label: 'Dock'),
    _NavItem(icon: Icons.palette_outlined, label: 'Scenes'),
  ];

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF9B7FD4).withValues(alpha: 0.10),
            blurRadius: 24,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: w * 0.021,
            vertical: w * 0.027,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_items.length, (i) {
              final active = i == selectedIndex;
              return _NavTapScale(
                scaleTo: 0.92,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    if (active) return;
                    Navigator.of(context).pushReplacementNamed(_routes[i]);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 220),
                    curve: Curves.easeOutCubic,
                    padding: EdgeInsets.symmetric(
                      horizontal: w * 0.037,
                      vertical: w * 0.021,
                    ),
                    decoration: BoxDecoration(
                      color: active ? const Color(0xFFE8E0FA) : Colors.transparent,
                      borderRadius: BorderRadius.circular(w * 0.043),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _items[i].icon,
                          size: w * 0.064,
                          color: active ? const Color(0xFF7C5CBF) : const Color(0xFFB0A8C8),
                        ),
                        SizedBox(height: w * 0.011),
                        Text(
                          _items[i].label,
                          style: GoogleFonts.dmSans(
                            fontSize: w * 0.029,
                            fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                            color: active ? const Color(0xFF5B3B8C) : const Color(0xFFB0A8C8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  const _NavItem({required this.icon, required this.label});

  final IconData icon;
  final String label;
}

class _NavTapScale extends StatefulWidget {
  const _NavTapScale({required this.child, this.scaleTo = 0.95});

  final Widget child;
  final double scaleTo;

  @override
  State<_NavTapScale> createState() => _NavTapScaleState();
}

class _NavTapScaleState extends State<_NavTapScale>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
      reverseDuration: const Duration(milliseconds: 220),
    );
    _scale = Tween<double>(begin: 1.0, end: widget.scaleTo).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOutCubic),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) => _ctrl.reverse(),
      onTapCancel: () => _ctrl.reverse(),
      child: ScaleTransition(scale: _scale, child: widget.child),
    );
  }
}
