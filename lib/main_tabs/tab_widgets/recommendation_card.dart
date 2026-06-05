import 'package:flutter/material.dart';
 
import '../../design_system.dart';
import '../../models/recommendation_item.dart';
import '../../persona_colors.dart';
 
/// Full-width card for both High Priority (filled button) and
/// Suggested (text + arrow link) recommendations.
///
/// Set [isPriority] = true for the filled ElevatedButton style.
/// Set [isPriority] = false (default) for the text + arrow style.
class RecommendationCard extends StatelessWidget {
  const RecommendationCard({
    super.key,
    required this.item,
    required this.onTapAction,
    this.isPriority = false,
  });
 
  final RecommendationItem item;
  final VoidCallback onTapAction;
  final bool isPriority;
 
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(PersonaSpacing.cardPadding),
      decoration: PersonaDecorations.mainCard,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CardHeader(item: item),
          const SizedBox(height: 16),
          Text(item.description, style: PersonaTextStyles.cardBody),
          SizedBox(height: isPriority ? 20 : 16),
          isPriority
              ? _FilledActionButton(item: item, onTap: onTapAction)
              : _TextActionLink(item: item, onTap: onTapAction),
        ],
      ),
    );
  }
}
 
// ---------------------------------------------------------------------------
// Private sub-widgets
// ---------------------------------------------------------------------------
 
class _CardHeader extends StatelessWidget {
  const _CardHeader({required this.item});
 
  final RecommendationItem item;
 
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _IconContainer(icon: item.icon, color: item.iconColor),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.category, style: PersonaTextStyles.cardCategory),
              const SizedBox(height: 4),
              Text(item.title, style: PersonaTextStyles.cardTitle),
            ],
          ),
        ),
      ],
    );
  }
}
 
class _IconContainer extends StatelessWidget {
  const _IconContainer({required this.icon, required this.color});
 
  final IconData icon;
  final Color color;
 
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(PersonaSpacing.iconRadius),
      ),
      child: Icon(icon, color: Colors.white, size: 28),
    );
  }
}
 
class _FilledActionButton extends StatelessWidget {
  const _FilledActionButton({required this.item, required this.onTap});
 
  final RecommendationItem item;
  final VoidCallback onTap;
 
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: item.actionColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(PersonaSpacing.buttonRadius),
          ),
        ),
        onPressed: onTap,
        child: Text(item.actionText, style: PersonaTextStyles.cardButtonLabel),
      ),
    );
  }
}
 
class _TextActionLink extends StatelessWidget {
  const _TextActionLink({required this.item, required this.onTap});
 
  final RecommendationItem item;
  final VoidCallback onTap;
 
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Text(
            item.actionText,
            style: TextStyle(
              color: item.actionColor,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 4),
          Icon(Icons.arrow_forward, color: item.actionColor, size: 18),
        ],
      ),
    );
  }
}