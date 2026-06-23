import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'breathing_completion.dart';
import '../../core/session_manager.dart';

class BreathingActiveScreen extends StatefulWidget {
  final int duration;
  final String technique;

  const BreathingActiveScreen({
    super.key,
    required this.duration,
    required this.technique,
  });

  @override
  State<BreathingActiveScreen> createState() => _BreathingActiveScreenState();
}

class _BreathingActiveScreenState extends State<BreathingActiveScreen> with SingleTickerProviderStateMixin {
  late AnimationController _breatheController;

@override
  void initState() {
    super.initState();
    
    globalSessionManager.startSession(
      title: 'Breathing Exercise',
      icon: Icons.air, 
      color: const Color(0xFFE879A0),
      durationMinutes: widget.duration,
      completionScreen: BreathingCompletionScreen(
        durationCompleted: widget.duration,
        technique: widget.technique,
      ),
      activeScreen: BreathingActiveScreen(
        duration: widget.duration,
        technique: widget.technique,
      ),
    );
    globalSessionManager.setOverlaySuppressed(true);

    _breatheController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4), 
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _breatheController.dispose();
    globalSessionManager.setOverlaySuppressed(false);
    super.dispose();
  }

  void _endSession() {
    globalSessionManager.endSession();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => BreathingCompletionScreen(
          durationCompleted: widget.duration,
          technique: widget.technique,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE879A0), // Calming Pink
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 32),
                  onPressed: () => Navigator.of(context).pop(), 
                ),
              ),
              Text('Breathing Exercise', style: GoogleFonts.dmSans(color: Colors.white70, fontSize: 20, fontWeight: FontWeight.bold)),
              const Spacer(),
              
              ListenableBuilder(
                listenable: globalSessionManager,
                builder: (context, _) {
                  return Column(
                    children: [
                      Text(globalSessionManager.formattedTime, style: GoogleFonts.dmSans(color: Colors.white, fontSize: 64, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 48),
                      
                      // THE FIX: We wrap the animation in a fixed SizedBox so the timer never moves!
                      SizedBox(
                        height: 250,
                        width: 250,
                        child: Center(
                          child: AnimatedBuilder(
                            animation: _breatheController,
                            builder: (context, child) {
                              return Container(
                                width: 150 + (_breatheController.value * 100),
                                height: 150 + (_breatheController.value * 100),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white.withOpacity(0.2),
                                  border: Border.all(color: Colors.white.withOpacity(0.5), width: 2),
                                ),
                                child: Center(
                                  child: Text(
                                    _breatheController.status == AnimationStatus.forward ? 'Breathe In' : 'Exhale',
                                    style: GoogleFonts.inter(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600),
                                  ),
                                ),
                              );
                            }
                          ),
                        ),
                      ),
                    ],
                  );
                }
              ),
              
              const Spacer(),
              // --- ENVIRONMENT ACTIVE BLOCK ---
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Environment Active', style: GoogleFonts.inter(color: Colors.white70, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Icon(Icons.lightbulb_outline, color: Colors.white70, size: 20),
                        const SizedBox(width: 12),
                        Text('Soft Lighting Active', style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(Icons.spa_outlined, color: Colors.white70, size: 20),
                        const SizedBox(width: 12),
                        Text('Vanilla Diffusing', style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(Icons.notifications_off_outlined, color: Colors.white70, size: 20),
                        const SizedBox(width: 12),
                        Text('Notifications Muted', style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              // ---------------------------------
              Row(
                children: [
                  Expanded(
                    child: ListenableBuilder(
                      listenable: globalSessionManager,
                      builder: (context, _) {
                        return OutlinedButton(
                          onPressed: () {
                            globalSessionManager.togglePause();
                            if (globalSessionManager.isPaused) {
                              _breatheController.stop();
                            } else {
                              _breatheController.repeat(reverse: true);
                            }
                          }, 
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            side: const BorderSide(color: Colors.white, width: 1.5),
                          ),
                          child: Text(globalSessionManager.isPaused ? 'Resume' : 'Pause', style: GoogleFonts.inter(fontWeight: FontWeight.w700, color: Colors.white, fontSize: 16)),
                        );
                      }
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _endSession,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: Text('End Session', style: GoogleFonts.inter(fontWeight: FontWeight.w700, color: const Color(0xFFE879A0), fontSize: 16)),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}