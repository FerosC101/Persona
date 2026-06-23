import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'pomodoro_active.dart';
import 'pomodoro_completion.dart';
import '../../core/session_manager.dart';

class PomodoroBreakScreen extends StatefulWidget {
  final int workDuration;
  final int breakDuration;
  final int totalCycles;
  final int currentCycle;

  const PomodoroBreakScreen({
    super.key,
    required this.workDuration,
    required this.breakDuration,
    required this.totalCycles,
    required this.currentCycle,
  });

  @override
  State<PomodoroBreakScreen> createState() => _PomodoroBreakScreenState();
}

class _PomodoroBreakScreenState extends State<PomodoroBreakScreen> {

  @override
  void initState() {
    super.initState();
    globalSessionManager.startSession(
      title: 'Pomodoro Break',
      icon: Icons.self_improvement, 
      color: const Color(0xFF34C9C9), 
      durationMinutes: widget.breakDuration,
      completionScreen: PomodoroCompletionScreen(
        cyclesCompleted: widget.currentCycle, 
        workDuration: widget.workDuration,
        breakDuration: widget.breakDuration,
      ),
      activeScreen: PomodoroBreakScreen(
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

  void _finishBreak() {
    globalSessionManager.endSession();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => PomodoroActiveScreen(
          workDuration: widget.workDuration,
          breakDuration: widget.breakDuration,
          totalCycles: widget.totalCycles,
          currentCycle: widget.currentCycle + 1,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF34C9C9), 
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 32), onPressed: () => Navigator.of(context).pop()),
              ),
              Text('Break Time', style: GoogleFonts.dmSans(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
              const Spacer(),
              
              ListenableBuilder(
                listenable: globalSessionManager,
                builder: (context, _) {
                  return Text(globalSessionManager.formattedTime, style: GoogleFonts.dmSans(fontSize: 80, fontWeight: FontWeight.w800, color: Colors.white, height: 1.1));
                }
              ),
              
              const Spacer(),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.15), // <-- Changed to black for a darker, high-contrast glass effect
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Suggested Actions', style: GoogleFonts.inter(color: Colors.white70, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 16),
                    _buildActionItem('Stretch'),
                    const SizedBox(height: 12),
                    _buildActionItem('Drink Water'),
                    const SizedBox(height: 12),
                    _buildActionItem('Breathing Exercise'),
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
                          style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 18), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), side: const BorderSide(color: Colors.white, width: 2)),
                          child: Icon(globalSessionManager.isPaused ? Icons.play_arrow_rounded : Icons.pause_rounded, color: Colors.white),
                        );
                      }
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 3,
                    child: ElevatedButton(
                      onPressed: _finishBreak, 
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 18), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                      child: Text('Skip Break', style: GoogleFonts.inter(fontWeight: FontWeight.w700, color: const Color(0xFF34C9C9), fontSize: 16)),
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

  Widget _buildActionItem(String title) {
    return Row(
      children: [
        Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.white70, shape: BoxShape.circle)), // <-- Changed dot to white70
        const SizedBox(width: 12),
        Text(title, style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16)), // <-- Changed text to solid white
      ],
    );
  }
}