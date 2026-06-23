import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'wind_down_completion.dart';
import '../../core/session_manager.dart';

class WindDownActiveScreen extends StatefulWidget {
  final int duration;

  const WindDownActiveScreen({super.key, required this.duration});

  @override
  State<WindDownActiveScreen> createState() => _WindDownActiveScreenState();
}

class _WindDownActiveScreenState extends State<WindDownActiveScreen> {

  @override
  void initState() {
    super.initState();
    globalSessionManager.startSession(
      title: 'Wind-Down Routine',
      icon: Icons.favorite_outline, 
      color: const Color(0xFFF3A33E), 
      durationMinutes: widget.duration,
      completionScreen: WindDownCompletionScreen(duration: widget.duration),
      activeScreen: WindDownActiveScreen(duration: widget.duration),
    );
    globalSessionManager.setOverlaySuppressed(true);
  }

  @override
  void dispose() {
    globalSessionManager.setOverlaySuppressed(false);
    super.dispose();
  }

  void _endRoutine() {
    globalSessionManager.endSession();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => WindDownCompletionScreen(duration: widget.duration),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE47F23), // Deep Warm Orange
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
              Text('Wind-Down Routine', style: GoogleFonts.dmSans(color: Colors.white70, fontSize: 20, fontWeight: FontWeight.bold)),
              const Spacer(),
              
              ListenableBuilder(
                listenable: globalSessionManager,
                builder: (context, _) {
                  final totalSeconds = widget.duration * 60;
                  final progress = totalSeconds > 0 ? globalSessionManager.remainingSeconds / totalSeconds : 0.0;

                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 280,
                        height: 280,
                        child: CircularProgressIndicator(
                          value: progress, 
                          strokeWidth: 12,
                          backgroundColor: Colors.white.withValues(alpha: 0.2),
                          valueColor: const AlwaysStoppedAnimation(Colors.white),
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Remaining', style: GoogleFonts.inter(color: Colors.white70, fontWeight: FontWeight.w500)),
                          Text(
                            globalSessionManager.formattedTime, 
                            style: GoogleFonts.dmSans(fontSize: 64, fontWeight: FontWeight.w800, color: Colors.white, height: 1.1),
                          ),
                        ],
                      ),
                    ],
                  );
                }
              ),
              
              const Spacer(),
              
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
                        Text('Warm Lighting Active', style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(Icons.spa_outlined, color: Colors.white70, size: 20),
                        const SizedBox(width: 12),
                        Text('Lavender Diffusing', style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16)),
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
              
              Row(
                children: [
                  Expanded(
                    child: ListenableBuilder(
                      listenable: globalSessionManager,
                      builder: (context, _) {
                        return OutlinedButton(
                          onPressed: () => globalSessionManager.togglePause(), 
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
                      onPressed: _endRoutine,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: Text('End Routine', style: GoogleFonts.inter(fontWeight: FontWeight.w700, color: const Color(0xFFE47F23), fontSize: 16)),
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