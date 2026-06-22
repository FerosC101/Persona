import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../persona_colors.dart';
import '../tab_widgets/home_bottom_nav_bar.dart';

class AmbientScenesPage extends StatefulWidget {
  const AmbientScenesPage({super.key});

  @override
  State<AmbientScenesPage> createState() => _AmbientScenesPageState();
}

class _AmbientScenesPageState extends State<AmbientScenesPage> {
  static const double _cardRadius = 22;
  String _activeSceneId = 'relax_mode';

  late final List<_SceneData> _scenes = <_SceneData>[
    const _SceneData(
      id: 'relax_mode',
      title: 'Relax',
      subtitle: 'Unwind and decompress',
      icon: Icons.favorite_border,
      atmosphere: 'Calming, peaceful, stress-free',
      lightingColor: 'Warm Purple',
      lightingBrightness: '40%',
      lightingMode: 'Gentle pulse',
      scentPrimary: 'Lavender',
      scentSecondary: 'Vanilla',
      scentIntensity: '60%',
      headerGradient: <Color>[Color(0xFF8E6DF8), Color(0xFFBF9AFF)],
      buttonGradient: <Color>[Color(0xFF8D65F6), Color(0xFFB78CFB)],
      iconTint: Colors.white,
    ),
    const _SceneData(
      id: 'focus_mode',
      title: 'Focus',
      subtitle: 'Deep work and concentration',
      icon: Icons.bolt,
      atmosphere: 'Alert, concentrated, productive',
      lightingColor: 'Cool Cyan',
      lightingBrightness: '80%',
      lightingMode: 'Steady bright',
      scentPrimary: 'Peppermint',
      scentSecondary: 'Eucalyptus',
      scentIntensity: '70%',
      headerGradient: <Color>[Color(0xFF42D6CA), Color(0xFF1FA7A2)],
      buttonGradient: <Color>[Color(0xFF39CEC2), Color(0xFF1D9D98)],
      iconTint: Colors.white,
    ),
    const _SceneData(
      id: 'sleep_mode',
      title: 'Sleep',
      subtitle: 'Prepare for restful sleep',
      icon: Icons.nights_stay_outlined,
      atmosphere: 'Drowsy, relaxed, peaceful',
      lightingColor: 'Soft Amber',
      lightingBrightness: '20%',
      lightingMode: 'Dimming fade',
      scentPrimary: 'Chamomile',
      scentSecondary: 'Lavender',
      scentIntensity: '50%',
      headerGradient: <Color>[Color(0xFF7266D8), Color(0xFF5C3EA6)],
      buttonGradient: <Color>[Color(0xFF6C62D5), Color(0xFF5A3F9F)],
      iconTint: Colors.white,
    ),
    const _SceneData(
      id: 'recharge_mode',
      title: 'Recharge',
      subtitle: 'Boost energy and motivation',
      icon: Icons.auto_awesome,
      atmosphere: 'Energized, motivated, vibrant',
      lightingColor: 'Warm Orange',
      lightingBrightness: '90%',
      lightingMode: 'Energetic pulse',
      scentPrimary: 'Citrus',
      scentSecondary: 'Ginger',
      scentIntensity: '80%',
      headerGradient: <Color>[Color(0xFFF3A33E), Color(0xFFE47F23)],
      buttonGradient: <Color>[Color(0xFFF3A33E), Color(0xFFE0882C)],
      iconTint: Colors.white,
    ),
    const _SceneData(
      id: 'deep_work_mode',
      title: 'Deep Work',
      subtitle: 'Maximum productivity mode',
      icon: Icons.local_cafe_outlined,
      atmosphere: 'Focused, intense, productive',
      lightingColor: 'Natural White',
      lightingBrightness: '85%',
      lightingMode: 'Steady bright',
      scentPrimary: 'Peppermint',
      scentSecondary: 'Rosemary',
      scentIntensity: '75%',
      headerGradient: <Color>[Color(0xFF59CB84), Color(0xFF2E9F64)],
      buttonGradient: <Color>[Color(0xFF55C47F), Color(0xFF2B975E)],
      iconTint: Colors.white,
    ),
    const _SceneData(
      id: 'calm_evening_mode',
      title: 'Calm Evening',
      subtitle: 'Wind down after a long day',
      icon: Icons.wb_twilight_outlined,
      atmosphere: 'Peaceful, content, unwinding',
      lightingColor: 'Golden Sunset',
      lightingBrightness: '50%',
      lightingMode: 'Gentle fade',
      scentPrimary: 'Vanilla',
      scentSecondary: 'Sandalwood',
      scentIntensity: '65%',
      headerGradient: <Color>[Color(0xFFF2C677), Color(0xFFE9A957)],
      buttonGradient: <Color>[Color(0xFFF0C16F), Color(0xFFE3A14D)],
      iconTint: Colors.white,
    ),
  ];

  void _activateScene(_SceneData scene) {
    setState(() => _activeSceneId = scene.id);

    // Placeholder for future state/config integration.
    // TODO: Wire this action to persisted profile + hardware sync.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${scene.title} scene activated'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _deactivateScene() {
    setState(() => _activeSceneId = '');

    // Placeholder for future state/config integration.
    // TODO: Wire this action to persisted profile + hardware sync.
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Scene deactivated'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _SceneData? active;
    for (final scene in _scenes) {
      if (scene.id == _activeSceneId) {
        active = scene;
        break;
      }
    }

    return Scaffold(
      backgroundColor: PersonaColors.scaffold,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ambient Scenes',
                style: GoogleFonts.dmSans(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: PersonaColors.textPrimary,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Immersive wellness atmospheres',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: PersonaColors.textSecondary,
                ),
              ),
              const SizedBox(height: 20),
              _CurrentlyActiveCard(
                radius: _cardRadius,
                activeSceneTitle: active?.title ?? 'No scene active',
                lighting: active?.lightingColor ?? '—',
                scent: active?.scentPrimary ?? '—',
                onDeactivate: _deactivateScene,
              ),
              const SizedBox(height: 20),
              ..._scenes.map(
                (scene) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: SceneCard(
                    radius: _cardRadius,
                    scene: scene,
                    isActive: scene.id == _activeSceneId,
                    onActivate: () => _activateScene(scene),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              _CreateCustomSceneCard(radius: _cardRadius),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const HomeBottomNavBar(selectedIndex: 4),
    );
  }
}

class _CurrentlyActiveCard extends StatelessWidget {
  const _CurrentlyActiveCard({
    required this.radius,
    required this.activeSceneTitle,
    required this.lighting,
    required this.scent,
    required this.onDeactivate,
  });

  final double radius;
  final String activeSceneTitle;
  final String lighting;
  final String scent;
  final VoidCallback onDeactivate;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            const Color(0xFFCCB0FF).withValues(alpha: 0.55),
            const Color(0xFFE7D8FF).withValues(alpha: 0.42),
          ],
        ),
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: const Color(0xFFBC9EF6).withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Currently Active',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: PersonaColors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      activeSceneTitle,
                      style: GoogleFonts.dmSans(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: PersonaColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.32),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.favorite_border, color: PersonaColors.primaryPurple),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: _ActiveMetricChip(
                  label: 'Lighting',
                  value: lighting,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _ActiveMetricChip(
                  label: 'Scent',
                  value: scent,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _TranslucentActionButton(
            label: 'Deactivate Scene',
            onPressed: onDeactivate,
          ),
        ],
      ),
    );
  }
}

class _ActiveMetricChip extends StatelessWidget {
  const _ActiveMetricChip({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.34),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 11,
              color: PersonaColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: PersonaColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class SceneCard extends StatelessWidget {
  const SceneCard({
    super.key,
    required this.radius,
    required this.scene,
    required this.isActive,
    required this.onActivate,
  });

  final double radius;
  final _SceneData scene;
  final bool isActive;
  final VoidCallback onActivate;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: const Color(0xFFEDEAF4)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          _SceneHeader(scene: scene, radius: radius),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(radius),
                bottomRight: Radius.circular(radius),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Atmosphere',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: PersonaColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  scene.atmosphere,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: PersonaColors.textPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 14),
                MetricRow(
                  lightingColor: scene.lightingColor,
                  lightingBrightness: scene.lightingBrightness,
                  lightingMode: scene.lightingMode,
                  scentPrimary: scene.scentPrimary,
                  scentSecondary: scene.scentSecondary,
                  scentIntensity: scene.scentIntensity,
                ),
                const SizedBox(height: 14),
                _GradientActionButton(
                  label: isActive ? 'Scene Active' : 'Activate Scene',
                  gradient: scene.buttonGradient,
                  onPressed: onActivate,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SceneHeader extends StatelessWidget {
  const _SceneHeader({
    required this.scene,
    required this.radius,
  });

  final _SceneData scene;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: scene.headerGradient,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radius),
          topRight: Radius.circular(radius),
        ),
      ),
      child: Row(
        children: [
          Icon(scene.icon, color: scene.iconTint, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  scene.title,
                  style: GoogleFonts.dmSans(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  scene.subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MetricRow extends StatelessWidget {
  const MetricRow({
    super.key,
    required this.lightingColor,
    required this.lightingBrightness,
    required this.lightingMode,
    required this.scentPrimary,
    required this.scentSecondary,
    required this.scentIntensity,
  });

  final String lightingColor;
  final String lightingBrightness;
  final String lightingMode;
  final String scentPrimary;
  final String scentSecondary;
  final String scentIntensity;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _DetailColumn(
            title: 'Lighting Setup',
            rows: <(String, String)>[
              ('Color', lightingColor),
              ('Brightness', lightingBrightness),
              ('Mode', lightingMode),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _DetailColumn(
            title: 'Scent Profile',
            rows: <(String, String)>[
              ('Primary', scentPrimary),
              ('Secondary', scentSecondary),
              ('Intensity', scentIntensity),
            ],
          ),
        ),
      ],
    );
  }
}

class _DetailColumn extends StatelessWidget {
  const _DetailColumn({
    required this.title,
    required this.rows,
  });

  final String title;
  final List<(String, String)> rows;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: PersonaColors.textSecondary,
          ),
        ),
        const SizedBox(height: 6),
        ...rows.map(
          (row) => Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '${row.$1}: ',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: PersonaColors.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextSpan(
                    text: row.$2,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: PersonaColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _GradientActionButton extends StatelessWidget {
  const _GradientActionButton({
    required this.label,
    required this.gradient,
    required this.onPressed,
  });

  final String label;
  final List<Color> gradient;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: gradient,
        ),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(999),
          onTap: onPressed,
          child: SizedBox(
            width: double.infinity,
            height: 42,
            child: Center(
              child: Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TranslucentActionButton extends StatelessWidget {
  const _TranslucentActionButton({
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Colors.white.withValues(alpha: 0.45),
            Colors.white.withValues(alpha: 0.3),
          ],
        ),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(999),
          onTap: onPressed,
          child: SizedBox(
            width: double.infinity,
            height: 40,
            child: Center(
              child: Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: PersonaColors.textPrimary,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CreateCustomSceneCard extends StatelessWidget {
  const _CreateCustomSceneCard({required this.radius});

  final double radius;

  void _openCreateModal(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (c) => const Padding(
        padding: EdgeInsets.only(top: 48),
        child: CreateCustomSceneModal(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(radius),
      onTap: () => _openCreateModal(context),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFF7F4FC),
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(color: const Color(0xFFE8E1F5)),
        ),
        child: Column(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: const BoxDecoration(
                color: PersonaColors.primaryPurple,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.add, color: Colors.white, size: 30),
            ),
            const SizedBox(height: 12),
            Text(
              'Create Custom Scene',
              textAlign: TextAlign.center,
              style: GoogleFonts.dmSans(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: PersonaColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Design your own ambient experience with custom lighting and scent combinations',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: PersonaColors.textSecondary,
                height: 1.35,
              ),
            ),
            const SizedBox(height: 14),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFB790FF).withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                child: Text(
                  'Get Started',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF6D45BE),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CreateCustomSceneModal extends StatefulWidget {
  const CreateCustomSceneModal({super.key});

  @override
  State<CreateCustomSceneModal> createState() => _CreateCustomSceneModalState();
}

class _CreateCustomSceneModalState extends State<CreateCustomSceneModal> {
  final _nameController = TextEditingController();
  final _subtitleController = TextEditingController();
  String _lighting = 'Warm Purple';
  String _scent = 'Lavender';
  String _intensity = '50%';

  void _save() {
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Custom scene "${_nameController.text}" created')),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _subtitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.78,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      builder: (context, controller) => Container(
        decoration: BoxDecoration(
          color: PersonaColors.scaffold,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
        child: SingleChildScrollView(
          controller: controller,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Text(
                'Create Custom Scene',
                style: GoogleFonts.dmSans(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: PersonaColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Scene name',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _subtitleController,
                decoration: InputDecoration(
                  labelText: 'Short description',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _lighting,
                decoration: const InputDecoration(filled: true, fillColor: Colors.white, border: OutlineInputBorder()),
                items: <String>['Warm Purple', 'Cool Cyan', 'Soft Amber', 'Natural White', 'Warm Orange']
                    .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                    .toList(),
                onChanged: (v) => setState(() => _lighting = v ?? _lighting),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _scent,
                decoration: const InputDecoration(filled: true, fillColor: Colors.white, border: OutlineInputBorder()),
                items: <String>['Lavender', 'Vanilla', 'Peppermint', 'Citrus', 'Chamomile']
                    .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                    .toList(),
                onChanged: (v) => setState(() => _scent = v ?? _scent),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _intensity,
                decoration: const InputDecoration(filled: true, fillColor: Colors.white, border: OutlineInputBorder()),
                items: <String>['30%', '50%', '60%', '70%', '80%']
                    .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                    .toList(),
                onChanged: (v) => setState(() => _intensity = v ?? _intensity),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('Cancel', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: PersonaColors.primaryPurple,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: _save,
                      child: Text('Save', style: GoogleFonts.inter(fontWeight: FontWeight.w700)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}

class _SceneData {
  const _SceneData({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.atmosphere,
    required this.lightingColor,
    required this.lightingBrightness,
    required this.lightingMode,
    required this.scentPrimary,
    required this.scentSecondary,
    required this.scentIntensity,
    required this.headerGradient,
    required this.buttonGradient,
    required this.iconTint,
  });

  final String id;
  final String title;
  final String subtitle;
  final IconData icon;
  final String atmosphere;
  final String lightingColor;
  final String lightingBrightness;
  final String lightingMode;
  final String scentPrimary;
  final String scentSecondary;
  final String scentIntensity;
  final List<Color> headerGradient;
  final List<Color> buttonGradient;
  final Color iconTint;
}
