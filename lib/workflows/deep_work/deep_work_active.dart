import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'deep_work_completion.dart';
import '../../core/session_manager.dart';

class DeepWorkActiveScreen extends StatefulWidget {
  final int duration;
  
  const DeepWorkActiveScreen({super.key, required this.duration});

  @override
  State<DeepWorkActiveScreen> createState() => _DeepWorkActiveScreenState();
}

class _DeepWorkActiveScreenState extends State<DeepWorkActiveScreen> {

@override
  void initState() {
    super.initState();
    globalSessionManager.startSession(
      title: 'Deep Work Session',
      icon: Icons.bolt, 
      color: const Color(0xFF34C9C9), 
      durationMinutes: widget.duration,
      completionScreen: DeepWorkCompletionScreen(duration: widget.duration), 
      // ADD THIS LINE:
      activeScreen: DeepWorkActiveScreen(duration: widget.duration), 
    );
    
    globalSessionManager.setOverlaySuppressed(true);
  }

  @override
  void dispose() {
    // Show the floating card again when we leave this screen
    globalSessionManager.setOverlaySuppressed(false);
    super.dispose();
  }

  void _endSession(BuildContext context) {
    globalSessionManager.endSession(); // Clear global state
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => DeepWorkCompletionScreen(duration: widget.duration),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1D9D98), // Deep Focus immersive color
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 32),
                  onPressed: () => Navigator.of(context).pop(), // Minimize to overlay!
                ),
              ),
              Text('Deep Work Session', style: GoogleFonts.dmSans(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white70)),
              const Spacer(),
              
              // Progress Ring Component now listens to the global manager
              ListenableBuilder(
                listenable: globalSessionManager,
                builder: (context, _) {
                  // Calculate percentage for the ring
                  final totalSeconds = widget.duration * 60;
                  final progress = totalSeconds > 0 
                      ? globalSessionManager.remainingSeconds / totalSeconds 
                      : 0.0;

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
                          Text('Remaining Time', style: GoogleFonts.inter(color: Colors.white70, fontWeight: FontWeight.w500)),
                          Text(
                            globalSessionManager.formattedTime, // Real live time!
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
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Today's Goal", style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16)),
                    Text("2 / 4 Sessions", style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16)),
                  ],
                ),
              ),
              
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: ListenableBuilder( // Small trick to make pause button rebuild when paused
                      listenable: globalSessionManager,
                      builder: (context, _) {
                        return OutlinedButton(
                          onPressed: () => globalSessionManager.togglePause(), // Real pause!
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            side: const BorderSide(color: Colors.white, width: 1.5),
                          ),
                          child: Text(
                            globalSessionManager.isPaused ? 'Resume' : 'Pause', 
                            style: GoogleFonts.inter(fontWeight: FontWeight.w700, color: Colors.white, fontSize: 16)
                          ),
                        );
                      }
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _endSession(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: Text('End Session', style: GoogleFonts.inter(fontWeight: FontWeight.w700, color: const Color(0xFF1D9D98), fontSize: 16)),
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