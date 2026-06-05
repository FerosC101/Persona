import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'main_tabs/tab_screens/dock_screen.dart';

// ─── Color Palette ────────────────────────────────────────────────────────────
class _C {
  static const bg = Color(0xFFF4F2F8);
  static const white = Color(0xFFFFFFFF);
  static const wellnessFill = Color(0xFF5B3B8C);
  static const wellnessTrack = Color(0xFFE8DFF5);
  static const wellnessScoreBig = Color(0xFF2E1B4E);
  static const wellnessTrend = Color(0xFF34C97B);
  static const headerSub = Color(0xFF8C8CA0);
  static const headerMain = Color(0xFF1A0A2E);
  static const cardShadow = Color(0x14A090C0);
  static const moodLabel = Color(0xFF7A5BAA);
  static const moodBtnBg = Color(0x33FFFFFF);
  static const sleepBg = Color(0xFFF0EAFF);
  static const sleepIcon = Color(0xFF8B5CF6);
  static const sleepBar = Color(0xFF8B5CF6);
  static const stressBg = Color(0xFFFFEAF0);
  static const stressIcon = Color(0xFFE879A0);
  static const stressBar = Color(0xFFE879A0);
  static const hydrationBg = Color(0xFFE6FAF8);
  static const hydrationIcon = Color(0xFF34C9C9);
  static const hydrationBar = Color(0xFF34C9C9);
  static const focusBg = Color(0xFFFFF6E6);
  static const focusIcon = Color(0xFFF5A623);
  static const focusBar = Color(0xFFF5A623);
  static const navBg = Color(0xFFFFFFFF);
  static const navInactive = Color(0xFFB0A8C8);
  static const navActiveBg = Color(0xFFE8E0FA);
  static const navActiveIcon = Color(0xFF7C5CBF);
  static const navLabel = Color(0xFF5B3B8C);
}

// ─── Entry Widget ─────────────────────────────────────────────────────────────
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int _navIndex = 0;

  // Entrance animation controllers (staggered)
  late final AnimationController _entranceCtrl;
  late final Animation<double> _headerFade;
  late final Animation<Offset> _headerSlide;
  late final Animation<double> _moodFade;
  late final Animation<Offset> _moodSlide;
  late final Animation<double> _wellnessFade;
  late final Animation<Offset> _wellnessSlide;
  late final Animation<double> _grid1Fade;
  late final Animation<Offset> _grid1Slide;
  late final Animation<double> _grid2Fade;
  late final Animation<Offset> _grid2Slide;
  late final Animation<double> _envFade;

  // Progress bar animation controller
  late final AnimationController _progressCtrl;
  late final Animation<double> _progressAnim;

  @override
  void initState() {
    super.initState();

    // ── Entrance: total 1200ms, staggered intervals ──
    _entranceCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _headerFade = _curved(0.00, 0.20);
    _headerSlide = _slide(0.00, 0.20);

    _moodFade = _curved(0.12, 0.35);
    _moodSlide = _slide(0.12, 0.35);

    _wellnessFade = _curved(0.25, 0.50);
    _wellnessSlide = _slide(0.25, 0.50);

    _grid1Fade = _curved(0.38, 0.65);
    _grid1Slide = _slide(0.38, 0.65);

    _grid2Fade = _curved(0.50, 0.78);
    _grid2Slide = _slide(0.50, 0.78);

    _envFade = _curved(0.65, 0.90);

    // ── Progress bars: 900ms, starts slightly after entrance ──
    _progressCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _progressAnim = CurvedAnimation(
      parent: _progressCtrl,
      curve: Curves.easeOutCubic,
    );

    // Kick off
    _entranceCtrl.forward();
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) _progressCtrl.forward();
    });
  }

  Animation<double> _curved(double begin, double end) => CurvedAnimation(
        parent: _entranceCtrl,
        curve: Interval(begin, end, curve: Curves.easeOutCubic),
      );

  Animation<Offset> _slide(double begin, double end) => Tween<Offset>(
        begin: const Offset(0, 0.06),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: _entranceCtrl,
        curve: Interval(begin, end, curve: Curves.easeOutCubic),
      ));

  @override
  void dispose() {
    _entranceCtrl.dispose();
    _progressCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _C.bg,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final w = constraints.maxWidth;
                  final hPad = w * 0.052; // ~20px on 375px screen
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.fromLTRB(hPad, hPad, hPad, hPad),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _entranceWrap(_headerFade, _headerSlide, _buildHeader(w)),
                        SizedBox(height: w * 0.053),
                        _entranceWrap(_moodFade, _moodSlide, _buildMoodCard(w)),
                        SizedBox(height: w * 0.048),
                        _entranceWrap(_wellnessFade, _wellnessSlide, _buildWellnessScoreCard(w)),
                        SizedBox(height: w * 0.048),
                        _entranceWrap(_grid1Fade, _grid1Slide,
                          Row(children: [
                            Expanded(child: _MetricCard(
                              iconBg: _C.sleepBg, iconColor: _C.sleepIcon,
                              icon: Icons.nightlight_round,
                              label: 'Sleep Quality', value: '8.2h',
                              barColor: _C.sleepBar, barValue: 0.82,
                              progressAnim: _progressAnim,
                            )),
                            SizedBox(width: w * 0.037),
                            Expanded(child: _MetricCard(
                              iconBg: _C.stressBg, iconColor: _C.stressIcon,
                              icon: Icons.psychology_outlined,
                              label: 'Stress Level', value: 'Low',
                              barColor: _C.stressBar, barValue: 0.25,
                              progressAnim: _progressAnim,
                            )),
                          ]),
                        ),
                        SizedBox(height: w * 0.037),
                        _entranceWrap(_grid2Fade, _grid2Slide,
                          Row(children: [
                            Expanded(child: _MetricCard(
                              iconBg: _C.hydrationBg, iconColor: _C.hydrationIcon,
                              icon: Icons.water_drop_outlined,
                              label: 'Hydration', value: '6/8',
                              barColor: _C.hydrationBar, barValue: 0.75,
                              progressAnim: _progressAnim,
                            )),
                            SizedBox(width: w * 0.037),
                            Expanded(child: _MetricCard(
                              iconBg: _C.focusBg, iconColor: _C.focusIcon,
                              icon: Icons.lightbulb_outline_rounded,
                              label: 'Focus Time', value: '2.5h',
                              barColor: _C.focusBar, barValue: 0.5,
                              progressAnim: _progressAnim,
                            )),
                          ]),
                        ),
                        SizedBox(height: w * 0.069),
                        FadeTransition(
                          opacity: _envFade,
                          child: _buildEnvironmentHeader(w),
                        ),
                        SizedBox(height: w * 0.042),
                      ],
                    ),
                  );
                },
              ),
            ),
            _buildBottomNav(),
          ],
        ),
      ),
    );
  }

  Widget _entranceWrap(Animation<double> fade, Animation<Offset> slide, Widget child) {
    return FadeTransition(
      opacity: fade,
      child: SlideTransition(position: slide, child: child),
    );
  }

  // ─── Header ────────────────────────────────────────────────────────────────
  Widget _buildHeader(double w) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Good Evening',
            style: GoogleFonts.dmSans(
              fontSize: w * 0.037,
              fontWeight: FontWeight.w400,
              color: _C.headerSub,
              letterSpacing: 0.1,
            )),
        SizedBox(height: w * 0.008),
        Text('Welcome back',
            style: GoogleFonts.dmSans(
              fontSize: w * 0.069,
              fontWeight: FontWeight.w800,
              color: _C.headerMain,
              letterSpacing: -0.5,
            )),
      ],
    );
  }

  // ─── Mood Card ─────────────────────────────────────────────────────────────
  Widget _buildMoodCard(double w) {
    return _TapScale(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(w * 0.059),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFD8BCEF), Color(0xFFEDD8FA)],
          ),
          borderRadius: BorderRadius.circular(w * 0.064),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF9B7FD4).withValues(alpha: 0.18),
              blurRadius: 20,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Current Mood',
                style: GoogleFonts.dmSans(
                  fontSize: w * 0.034,
                  fontWeight: FontWeight.w500,
                  color: _C.moodLabel,
                  letterSpacing: 0.2,
                )),
            SizedBox(height: w * 0.016),
            Text('Calm & Focused',
                style: GoogleFonts.dmSans(
                  fontSize: w * 0.059,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF2E1B4E),
                  letterSpacing: -0.3,
                )),
            SizedBox(height: w * 0.048),
            _TapScale(
              scaleTo: 0.97,
              child: Container(
                decoration: BoxDecoration(
                  color: _C.moodBtnBg,
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.5), width: 1),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(999),
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: w * 0.034),
                      child: Center(
                        child: Text('Update Mood Check-in',
                            style: GoogleFonts.dmSans(
                              fontSize: w * 0.037,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF5B3B8C),
                              letterSpacing: 0.1,
                            )),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Wellness Score Card ───────────────────────────────────────────────────
  Widget _buildWellnessScoreCard(double w) {
    return _WhiteCard(
      width: w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Wellness Score',
                  style: GoogleFonts.dmSans(
                    fontSize: w * 0.043,
                    fontWeight: FontWeight.w700,
                    color: _C.headerMain,
                    letterSpacing: -0.2,
                  )),
              Container(
                padding: EdgeInsets.all(w * 0.016),
                decoration: BoxDecoration(
                  color: _C.wellnessTrend.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(w * 0.021),
                ),
                child: Icon(Icons.trending_up_rounded,
                    color: _C.wellnessTrend, size: w * 0.048),
              ),
            ],
          ),
          SizedBox(height: w * 0.043),
          // Animated progress bar
          AnimatedBuilder(
            animation: _progressAnim,
            builder: (context, _) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(999),
                child: LinearProgressIndicator(
                  value: _progressAnim.value * 0.78,
                  minHeight: w * 0.027,
                  backgroundColor: _C.wellnessTrack,
                  valueColor: const AlwaysStoppedAnimation<Color>(_C.wellnessFill),
                ),
              );
            },
          ),
          SizedBox(height: w * 0.037),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('78',
                  style: GoogleFonts.dmSans(
                    fontSize: w * 0.107,
                    fontWeight: FontWeight.w800,
                    color: _C.wellnessScoreBig,
                    height: 1,
                    letterSpacing: -1,
                  )),
              SizedBox(width: w * 0.021),
              Padding(
                padding: EdgeInsets.only(bottom: w * 0.016),
                child: Text('out of 100',
                    style: GoogleFonts.dmSans(
                      fontSize: w * 0.034,
                      fontWeight: FontWeight.w400,
                      color: _C.headerSub,
                    )),
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.only(bottom: w * 0.016),
                child: Text('+5 from yesterday',
                    style: GoogleFonts.dmSans(
                      fontSize: w * 0.034,
                      fontWeight: FontWeight.w600,
                      color: _C.wellnessTrend,
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ─── Environment Header ────────────────────────────────────────────────────
  Widget _buildEnvironmentHeader(double w) {
    return Text('Environment Controls',
        style: GoogleFonts.dmSans(
          fontSize: w * 0.053,
          fontWeight: FontWeight.w800,
          color: _C.headerMain,
          letterSpacing: -0.4,
        ));
  }

  // ─── Bottom Navigation ────────────────────────────────────────────────────
  Widget _buildBottomNav() {
    final items = [
      _NavItem(icon: Icons.home_rounded, label: 'Home'),
      _NavItem(icon: Icons.favorite_border_rounded, label: 'Mood'),
      _NavItem(icon: Icons.auto_awesome_rounded, label: 'AI'),
      _NavItem(icon: Icons.speed_rounded, label: 'Dock'),
      _NavItem(icon: Icons.palette_outlined, label: 'Scenes'),
    ];

    return LayoutBuilder(builder: (context, constraints) {
      final w = constraints.maxWidth;
      return Container(
        decoration: BoxDecoration(
          color: _C.navBg,
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
              children: List.generate(items.length, (i) {
                final active = i == _navIndex;
                return _TapScale(
                  scaleTo: 0.92,
                  child: GestureDetector(
                    onTap: () {
                      setState(() => _navIndex = i);
                      if (i == 3) {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (_) => const DockScreen(),
                          ),
                        );
                      }
                    },
                    behavior: HitTestBehavior.opaque,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 220),
                      curve: Curves.easeOutCubic,
                      padding: EdgeInsets.symmetric(
                        horizontal: w * 0.037,
                        vertical: w * 0.021,
                      ),
                      decoration: BoxDecoration(
                        color: active ? _C.navActiveBg : Colors.transparent,
                        borderRadius: BorderRadius.circular(w * 0.043),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(items[i].icon,
                              size: w * 0.064,
                              color: active ? _C.navActiveIcon : _C.navInactive),
                          SizedBox(height: w * 0.011),
                          Text(items[i].label,
                              style: GoogleFonts.dmSans(
                                fontSize: w * 0.029,
                                fontWeight:
                                    active ? FontWeight.w700 : FontWeight.w500,
                                color: active ? _C.navLabel : _C.navInactive,
                              )),
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
    });
  }
}

// ─── Reusable: White Card ─────────────────────────────────────────────────────
class _WhiteCard extends StatelessWidget {
  const _WhiteCard({required this.child, required this.width});
  final Widget child;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(width * 0.053),
      decoration: BoxDecoration(
        color: _C.white,
        borderRadius: BorderRadius.circular(width * 0.059),
        boxShadow: const [
          BoxShadow(
            color: _C.cardShadow,
            blurRadius: 20,
            spreadRadius: 2,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}

// ─── Reusable: Metric Card ────────────────────────────────────────────────────
class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.iconBg,
    required this.iconColor,
    required this.icon,
    required this.label,
    required this.value,
    required this.barColor,
    required this.barValue,
    required this.progressAnim,
  });

  final Color iconBg;
  final Color iconColor;
  final IconData icon;
  final String label;
  final String value;
  final Color barColor;
  final double barValue;
  final Animation<double> progressAnim;

  @override
  Widget build(BuildContext context) {
    return _TapScale(
      child: LayoutBuilder(builder: (context, constraints) {
        final w = constraints.maxWidth;
        return Container(
          padding: EdgeInsets.fromLTRB(w * 0.107, w * 0.107, w * 0.107, w * 0.093),
          decoration: BoxDecoration(
            color: _C.white,
            borderRadius: BorderRadius.circular(w * 0.133),
            boxShadow: const [
              BoxShadow(
                color: _C.cardShadow,
                blurRadius: 18,
                spreadRadius: 2,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: w * 0.253,
                    height: w * 0.253,
                    decoration: BoxDecoration(
                      color: iconBg,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, color: iconColor, size: w * 0.133),
                  ),
                  SizedBox(width: w * 0.066),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(label,
                            style: GoogleFonts.dmSans(
                              fontSize: w * 0.076,
                              fontWeight: FontWeight.w500,
                              color: _C.headerSub,
                              letterSpacing: 0.1,
                            )),
                        SizedBox(height: w * 0.013),
                        Text(value,
                            style: GoogleFonts.dmSans(
                              fontSize: w * 0.12,
                              fontWeight: FontWeight.w800,
                              color: _C.headerMain,
                              letterSpacing: -0.4,
                              height: 1.1,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: w * 0.093),
              AnimatedBuilder(
                animation: progressAnim,
                builder: (context, _) => ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: LinearProgressIndicator(
                    value: progressAnim.value * barValue,
                    minHeight: w * 0.027,
                    backgroundColor: barColor.withValues(alpha: 0.15),
                    valueColor: AlwaysStoppedAnimation<Color>(barColor),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

// ─── Reusable: Tap Scale Widget ───────────────────────────────────────────────
class _TapScale extends StatefulWidget {
  const _TapScale({required this.child, this.scaleTo = 0.95});
  final Widget child;
  final double scaleTo;

  @override
  State<_TapScale> createState() => _TapScaleState();
}

class _TapScaleState extends State<_TapScale>
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

// ─── Nav Item Model ───────────────────────────────────────────────────────────
class _NavItem {
  const _NavItem({required this.icon, required this.label});
  final IconData icon;
  final String label;
}