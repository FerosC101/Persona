import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
 
import '../../design_system.dart';
import '../../models/recommendation_item.dart';
import '../../persona_colors.dart';
 
/// Compact horizontal card for the "When You Have Time" section.
class MiniRecommendationCard extends StatelessWidget {
  const MiniRecommendationCard({
    super.key,
    required this.item,
    required this.onTap,
  });
 
  final MiniRecommendationItem item;
  final VoidCallback onTap;
 
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 76,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: PersonaDecorations.miniCard,
      child: Row(
        children: [
          _MiniIconContainer(icon: item.icon, color: item.iconColor),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item.title,
                  style: GoogleFonts.dmSans(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: PersonaColors.textPrimary,
                    height: 1.15,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(item.subtitle, style: PersonaTextStyles.miniCardSubtitle),
              ],
            ),
          ),
          _TryItButton(item: item, onTap: onTap),
        ],
      ),
    );
  }
}
  
class _MiniIconContainer extends StatelessWidget {
  const _MiniIconContainer({required this.icon, required this.color});
 
  final IconData icon;
  final Color color;
 
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(PersonaSpacing.miniIconRadius),
      ),
      child: Icon(icon, color: Colors.white, size: 24),
    );
  }
}
 
class _TryItButton extends StatelessWidget {
  const _TryItButton({required this.item, required this.onTap});
 
  final MiniRecommendationItem item;
  final VoidCallback onTap;
 
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: item.buttonBgColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: item.buttonColor.withOpacity(0.3)),
        ),
        child: Text(
          'Try It',
          style: PersonaTextStyles.miniCardButton.copyWith(
            color: item.buttonColor,
          ),
        ),
      ),
    );
  }
}