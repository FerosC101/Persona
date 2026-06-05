import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../persona_colors.dart';

class DockPage extends StatefulWidget {
  const DockPage({super.key});

  @override
  State<DockPage> createState() => _DockPageState();
}

class _DockPageState extends State<DockPage> {
  double _brightness = 0.7;
  double _intensity = 0.6;
  int _selectedNavIndex = 3;
  final Map<String, bool> _presetStates = <String, bool>{
    'Morning Routine': true,
    'Deep Work': true,
    'Evening Wind-Down': true,
    'Sleep Mode': false,
  };

  static const _background = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                Text(
                  'Persona Dock',
                  style: GoogleFonts.inter(
                    fontSize: 34,
                    fontWeight: FontWeight.w800,
                    height: 1.05,
                    color: PersonaColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Control your adaptive wellness station',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    height: 1.35,
                    color: PersonaColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 20),
                const TopStatusCard(),
                const SizedBox(height: 24),
                AmbientLightingSection(
                  brightness: _brightness,
                  onBrightnessChanged: (value) {
                    setState(() {
                      _brightness = value;
                    });
                  },
                ),
                const SizedBox(height: 24),
                AutomationPresetsSection(
                  presetStates: _presetStates,
                  onPresetChanged: (title, isEnabled) {
                    setState(() {
                      _presetStates[title] = isEnabled;
                    });
                  },
                ),
                const SizedBox(height: 24),
                ScentDiffusionSection(
                  intensity: _intensity,
                  onIntensityChanged: (value) {
                    setState(() {
                      _intensity = value;
                    });
                  },
                ),
                const SizedBox(height: 28),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: DockBottomNavigationBar(
        selectedIndex: _selectedNavIndex,
        onItemSelected: (index) {
          setState(() {
            _selectedNavIndex = index;
          });
        },
      ),
    );
  }
}

class AmbientLightingSection extends StatelessWidget {
  const AmbientLightingSection({
    super.key,
    required this.brightness,
    required this.onBrightnessChanged,
  });

  final double brightness;
  final ValueChanged<double> onBrightnessChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionHeader(
          icon: Icons.lightbulb_outline_rounded,
          title: 'Ambient Lighting',
        ),
        const SizedBox(height: 16),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.7,
          children: const [
            _LightingPresetCard(
              title: 'Calm Evening',
              subtitle: 'Warm dim lighting',
              indicatorBaseColor: Color(0xFF9B87F5),
              isSelected: true,
            ),
            _LightingPresetCard(
              title: 'Focus',
              subtitle: 'Cool white lighting',
              indicatorBaseColor: Color(0xFF4FD1C5),
            ),
            _LightingPresetCard(
              title: 'Sleep',
              subtitle: 'Soft amber lighting',
              indicatorBaseColor: Color(0xFFB794F6),
            ),
            _LightingPresetCard(
              title: 'Energy',
              subtitle: 'Bright yellow lighting',
              indicatorBaseColor: Color(0xFFF6AD55),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _SliderCard(
          label: 'Brightness',
          valueText: '${(brightness * 100).round()}%',
          value: brightness,
          onChanged: onBrightnessChanged,
        ),
      ],
    );
  }
}

class AutomationPresetsSection extends StatelessWidget {
  const AutomationPresetsSection({
    super.key,
    required this.presetStates,
    required this.onPresetChanged,
  });

  final Map<String, bool> presetStates;
  final void Function(String title, bool isEnabled) onPresetChanged;

  @override
  Widget build(BuildContext context) {
    final presets = <_AutomationPresetData>[
      const _AutomationPresetData('Morning Routine', '7:00 AM'),
      const _AutomationPresetData('Deep Work', '9:00 AM'),
      const _AutomationPresetData('Evening Wind-Down', '8:00 PM'),
      const _AutomationPresetData('Sleep Mode', '10:30 PM'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionHeader(
          icon: Icons.schedule_rounded,
          title: 'Automation Presets',
        ),
        const SizedBox(height: 16),
        ...presets.map((preset) {
          final enabled = presetStates[preset.title] ?? false;
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _AutomationPresetRow(
              title: preset.title,
              subtitle: preset.subtitle,
              isEnabled: enabled,
              onChanged: (value) => onPresetChanged(preset.title, value),
            ),
          );
        }),
      ],
    );
  }
}

class ScentDiffusionSection extends StatelessWidget {
  const ScentDiffusionSection({
    super.key,
    required this.intensity,
    required this.onIntensityChanged,
  });

  final double intensity;
  final ValueChanged<double> onIntensityChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionHeader(
          icon: Icons.air_rounded,
          title: 'Scent Diffusion',
        ),
        const SizedBox(height: 16),
        GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.88,
          children: const [
            _ScentCard(
              imagePath: 'assets/scents/lavender.png',
              title: 'Lavender',
              subtitle: 'Stress relief & relaxation',
              isSelected: true,
            ),
            _ScentCard(
              imagePath: 'assets/scents/peppermint.png',
              title: 'Peppermint',
              subtitle: 'Focus & concentration',
            ),
            _ScentCard(
              imagePath: 'assets/scents/citrus.png',
              title: 'Citrus',
              subtitle: 'Energy & mood boost',
            ),
            _ScentCard(
              imagePath: 'assets/scents/chamomile.png',
              title: 'Chamomile',
              subtitle: 'Sleep & calm',
            ),
            _ScentCard(
              imagePath: 'assets/scents/vanilla.png',
              title: 'Vanilla',
              subtitle: 'Comfort & relaxation',
            ),
            _ScentCard(
              imagePath: 'assets/scents/eucalyptus.png',
              title: 'Eucalyptus',
              subtitle: 'Clarity & freshness',
            ),
          ],
        ),
        const SizedBox(height: 12),
        _SliderCard(
          label: 'Intensity',
          valueText: '${(intensity * 100).round()}%',
          value: intensity,
          onChanged: onIntensityChanged,
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.icon, required this.title});

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 22,
          color: const Color(0xFFCA70E0),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: PersonaColors.textPrimary,
          ),
        ),
      ],
    );
  }
}

class _LightingPresetCard extends StatelessWidget {
  const _LightingPresetCard({
    required this.title,
    required this.subtitle,
    required this.indicatorBaseColor,
    this.isSelected = false,
  });

  final String title;
  final String subtitle;
  final Color indicatorBaseColor;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isSelected ? const Color(0xFFCA70E0) : const Color(0xFFE8E8EF),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF101828).withValues(alpha: 0.04),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _LightingIndicator(baseColor: indicatorBaseColor),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: PersonaColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: PersonaColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _LightingIndicator extends StatelessWidget {
  const _LightingIndicator({required this.baseColor});

  final Color baseColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 34,
      height: 34,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            baseColor.withValues(alpha: 0.95),
            baseColor.withValues(alpha: 0.0),
          ],
          radius: 0.9,
        ),
      ),
    );
  }
}

class _ScentCard extends StatelessWidget {
  const _ScentCard({
    required this.imagePath,
    required this.title,
    required this.subtitle,
    this.isSelected = false,
  });

  final String imagePath;
  final String title;
  final String subtitle;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final borderColor = isSelected ? const Color(0xFFCA70E0) : const Color(0xFFE8E8EF);
    final backgroundColor = isSelected ? const Color(0xFFF8EEF9) : Colors.white;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderColor, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF101828).withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 40,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: isSelected ? Colors.white.withValues(alpha: 0.7) : const Color(0xFFF8F8FC),
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.grass_rounded,
                    size: 20,
                    color: Color(0xFFCA70E0),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: PersonaColors.textPrimary,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: PersonaColors.textSecondary,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

class _SliderCard extends StatelessWidget {
  const _SliderCard({
    required this.label,
    required this.valueText,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final String valueText;
  final double value;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF101828).withValues(alpha: 0.05),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: PersonaColors.textPrimary,
                ),
              ),
              const Spacer(),
              Text(
                valueText,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: PersonaColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          GradientSlider(
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

class GradientSlider extends StatelessWidget {
  const GradientSlider({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final double value;
  final ValueChanged<double> onChanged;

  static const _startColor = Color(0xFF9B87F5);
  static const _endColor = Color(0xFFCA70E0);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const thumbSize = 18.0;
        final trackWidth = constraints.maxWidth;
        final thumbPosition = (trackWidth - thumbSize) * value;

        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onHorizontalDragUpdate: (details) {
            final localPosition = details.localPosition.dx.clamp(0.0, trackWidth);
            final normalized = (localPosition / trackWidth).clamp(0.0, 1.0);
            onChanged(normalized);
          },
          onTapDown: (details) {
            final localPosition = details.localPosition.dx.clamp(0.0, trackWidth);
            final normalized = (localPosition / trackWidth).clamp(0.0, 1.0);
            onChanged(normalized);
          },
          child: SizedBox(
            height: 28,
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD7DAE2),
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                Container(
                  height: 8,
                  width: thumbPosition + (thumbSize / 2),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [_startColor, _endColor],
                    ),
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                Positioned(
                  left: thumbPosition,
                  child: Container(
                    width: thumbSize,
                    height: thumbSize,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [_startColor, _endColor],
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFCA70E0).withValues(alpha: 0.24),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _AutomationPresetData {
  const _AutomationPresetData(this.title, this.subtitle);

  final String title;
  final String subtitle;
}

class _AutomationPresetRow extends StatelessWidget {
  const _AutomationPresetRow({
    required this.title,
    required this.subtitle,
    required this.isEnabled,
    required this.onChanged,
  });

  final String title;
  final String subtitle;
  final bool isEnabled;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF101828).withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: PersonaColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: PersonaColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          CupertinoSwitch(
            value: isEnabled,
            activeTrackColor: const Color(0xFFCA70E0),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

class DockBottomNavigationBar extends StatelessWidget {
  const DockBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: const Border(top: BorderSide(color: Color(0xFFECECF2), width: 1)),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF101828).withValues(alpha: 0.06),
              blurRadius: 22,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _DockNavItem(
              label: 'Home',
              icon: Icons.home_rounded,
              isSelected: selectedIndex == 0,
              onTap: () => onItemSelected(0),
            ),
            _DockNavItem(
              label: 'Mood',
              icon: Icons.favorite_rounded,
              isSelected: selectedIndex == 1,
              onTap: () => onItemSelected(1),
            ),
            _DockNavItem(
              label: 'AI',
              icon: Icons.auto_awesome_rounded,
              isSelected: selectedIndex == 2,
              onTap: () => onItemSelected(2),
            ),
            _DockNavItem(
              label: 'Dock',
              imageAsset: 'Dock.png',
              isSelected: selectedIndex == 3,
              onTap: () => onItemSelected(3),
            ),
            _DockNavItem(
              label: 'Scenes',
              icon: Icons.palette_rounded,
              isSelected: selectedIndex == 4,
              onTap: () => onItemSelected(4),
            ),
          ],
        ),
      ),
    );
  }
}

class _DockNavItem extends StatelessWidget {
  const _DockNavItem({
    required this.label,
    this.icon,
    this.imageAsset,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final IconData? icon;
  final String? imageAsset;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final inactiveColor = const Color(0xFF7C8494);
    final activeColor = const Color(0xFFCA70E0);

    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeOut,
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFEFE6FF) : Colors.transparent,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: imageAsset != null
                  ? Image.asset(
                      imageAsset!,
                      width: 24,
                      height: 24,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.dashboard_rounded,
                          size: 24,
                          color: isSelected ? activeColor : inactiveColor,
                        );
                      },
                    )
                  : Icon(
                      icon,
                      size: 24,
                      color: isSelected ? activeColor : inactiveColor,
                    ),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? activeColor : inactiveColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TopStatusCard extends StatelessWidget {
  const TopStatusCard({super.key});

  static const _cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFDBA3E9),
      Color(0x66CA70E0),
    ],
  );

  static const _powerGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF6F2C90),
      Color(0xFFCA70E0),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 18),
      decoration: BoxDecoration(
        gradient: _cardGradient,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFCA70E0).withValues(alpha: 0.16),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                child: _DockStatusCopy(),
              ),
              _PowerButton(
                gradient: _powerGradient,
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 28),
          Row(
            children: const [
              Expanded(
                child: _DockStatItem(
                  icon: Icons.wifi_rounded,
                  label: 'Connection',
                  value: 'Strong',
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _DockStatItem(
                  icon: Icons.battery_full_rounded,
                  label: 'Battery',
                  value: '87%',
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _DockStatItem(
                  icon: Icons.settings_rounded,
                  label: 'Mode',
                  value: 'Calm',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DockStatusCopy extends StatelessWidget {
  const _DockStatusCopy();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          width: 12,
          height: 12,
          decoration: const BoxDecoration(
            color: Color(0xFF4CD07D),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dock Status',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.white.withValues(alpha: 0.88),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Active',
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white.withValues(alpha: 0.98),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _PowerButton extends StatelessWidget {
  const _PowerButton({required this.gradient, required this.onTap});

  final Gradient gradient;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            gradient: gradient,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF6F2C90).withValues(alpha: 0.18),
                blurRadius: 14,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: const Icon(
            Icons.power_settings_new_rounded,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
    );
  }
}

class _DockStatItem extends StatelessWidget {
  const _DockStatItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    const iconLabelColor = Color(0xFF99A1AF);
    const valueColor = Colors.white;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: iconLabelColor),
            const SizedBox(width: 4),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: iconLabelColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: valueColor,
          ),
        ),
      ],
    );
  }
}