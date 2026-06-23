import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'pomodoro_break.dart';
import 'pomodoro_completion.dart';
import '../../core/session_manager.dart';

class PomodoroActiveScreen extends StatefulWidget {
  final int workDuration;
  final int breakDuration;
  final int totalCycles;
  final int currentCycle;

  const PomodoroActiveScreen({
    super.key,
    required this.workDuration,
    required this.breakDuration,
    required this.totalCycles,
    required this.currentCycle,
  });

  @override
  State<PomodoroActiveScreen> createState() => _PomodoroActiveScreenState();
}

class _PomodoroActiveScreenState extends State<PomodoroActiveScreen> {

  @override
  void initState() {
    super.initState();
    globalSessionManager.startSession(
      title: 'Pomodoro Focus',
      icon: Icons.local_cafe_outlined, 
      color: const Color(0xFF2E9F64), 
      durationMinutes: widget.workDuration,
      completionScreen: PomodoroCompletionScreen(
        cyclesCompleted: widget.currentCycle,
        workDuration: widget.workDuration,
        breakDuration: widget.breakDuration,
      ),
      // ADD THIS LINE:
      activeScreen: PomodoroActiveScreen(
        workDuration: widget.workDuration,
        breakDuration: widget.breakDuration,
        totalCycles: widget.totalCycles,
        currentCycle: widget.currentCycle,
      ),
    );
    globalSessionManager.setOverlaySuppressed(true);
  }

  @override
  void dispose() {
    globalSessionManager.setOverlaySuppressed(false);
    super.dispose();
  }

  void _finishWorkPhase() {
    globalSessionManager.endSession();
    if (widget.currentCycle < widget.totalCycles) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => PomodoroBreakScreen(
            workDuration: widget.workDuration,
            breakDuration: widget.breakDuration,
            totalCycles: widget.totalCycles,
            currentCycle: widget.currentCycle,
          ),
        ),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => PomodoroCompletionScreen(
            cyclesCompleted: widget.totalCycles,
            workDuration: widget.workDuration,
            breakDuration: widget.breakDuration,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2E9F64), 
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
              Text('Cycle ${widget.currentCycle} of ${widget.totalCycles}', style: GoogleFonts.dmSans(color: Colors.white70, fontSize: 20, fontWeight: FontWeight.bold)),
              const Spacer(),
              
              ListenableBuilder(
                listenable: globalSessionManager,
                builder: (context, _) {
                  final totalSeconds = widget.workDuration * 60;
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
                          Text('WORK SESSION', style: GoogleFonts.inter(color: Colors.white70, fontWeight: FontWeight.w700, letterSpacing: 1.5)),
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
                        Text('Focus Lighting Active', style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(Icons.spa_outlined, color: Colors.white70, size: 20),
                        const SizedBox(width: 12),
                        Text('Peppermint Diffusing', style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16)),
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
              const SizedBox(height: 16),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Next Break', style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16)),
                    Text('${widget.breakDuration} Minutes', style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16)),
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
                          style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 18), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), side: const BorderSide(color: Colors.white, width: 1.5)),
                          child: Text(globalSessionManager.isPaused ? 'Resume' : 'Pause', style: GoogleFonts.inter(fontWeight: FontWeight.w700, color: Colors.white, fontSize: 16)),
                        );
                      }
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _finishWorkPhase, // Skips to next phase
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 18), elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                      child: Text('End Phase', style: GoogleFonts.inter(fontWeight: FontWeight.w700, color: const Color(0xFF2E9F64), fontSize: 16)),
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