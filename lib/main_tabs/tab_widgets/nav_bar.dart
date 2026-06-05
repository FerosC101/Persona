import 'package:flutter/material.dart';
 
import '../../design_system.dart';
import '../../persona_colors.dart';
 
/// Shared bottom navigation bar used by all main tabs.
class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});
 
  static const _items = <_NavItemData>[
    _NavItemData(icon: Icons.home_outlined,    label: 'Home'),
    _NavItemData(icon: Icons.favorite_border,  label: 'Mood'),
    _NavItemData(icon: Icons.auto_awesome,     label: 'AI',     isSelected: true),
    _NavItemData(icon: Icons.speed_outlined,   label: 'Dock'),
    _NavItemData(icon: Icons.palette_outlined, label: 'Scenes'),
  ];
 
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      decoration: const BoxDecoration(
        color: PersonaColors.cardWhite,
        border: Border(
          top: BorderSide(color: PersonaColors.navBorder, width: 1.0),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _items
                .map((d) => _BottomNavItem(
                      icon: d.icon,
                      label: d.label,
                      isSelected: d.isSelected,
                    ))
                .toList(growable: false),
          ),
        ),
      ),
    );
  }
}
 
class _NavItemData {
  const _NavItemData({
    required this.icon,
    required this.label,
    this.isSelected = false,
  });
 
  final IconData icon;
  final String label;
  final bool isSelected;
}
 
class _BottomNavItem extends StatelessWidget {
  const _BottomNavItem({
    required this.icon,
    required this.label,
    this.isSelected = false,
  });
 
  final IconData icon;
  final String label;
  final bool isSelected;
 
  @override
  Widget build(BuildContext context) {
    if (isSelected) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              color: PersonaColors.selectedNavBg,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(icon, color: PersonaColors.primaryPurple, size: 28),
          ),
          const SizedBox(height: 4),
          Text(label, style: PersonaTextStyles.navLabelSelected),
        ],
      );
    }
 
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: PersonaColors.textSecondary, size: 28),
          const SizedBox(height: 4),
          Text(label, style: PersonaTextStyles.navLabel),
        ],
      ),
    );
  }
}