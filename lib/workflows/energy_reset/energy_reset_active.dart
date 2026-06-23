import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/session_manager.dart';
import 'energy_reset_completion.dart'; 

class EnergyResetActiveScreen extends StatefulWidget {
  final int duration;

  const EnergyResetActiveScreen({super.key, required this.duration});

  @override
  State<EnergyResetActiveScreen> createState() => _EnergyResetActiveScreenState();
}

class _EnergyResetActiveScreenState extends State<EnergyResetActiveScreen> {

  @override
  void initState() {
    super.initState();
    globalSessionManager.startSession(
      title: 'Energy Reset',
      icon: Icons.wb_sunny_outlined, // Sun icon for energy
      color: const Color(0xFFF19D38), // Your beautiful orange
      durationMinutes: widget.duration,
      completionScreen: EnergyResetCompletionScreen(duration: widget.duration), 
      activeScreen: EnergyResetActiveScreen(duration: widget.duration),
    );
    // Hide the overlay while we are on this screen
    globalSessionManager.setOverlaySuppressed(true);
  }

  @override
  void dispose() {
    globalSessionManager.setOverlaySuppressed(false);
    super.dispose();
  }

  void _endSession() {
    globalSessionManager.endSession();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => EnergyResetCompletionScreen(duration: widget.duration),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF19D38), 
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
              Text('Energy Reset', style: GoogleFonts.dmSans(color: Colors.white70, fontSize: 20, fontWeight: FontWeight.bold)),
              const Spacer(),
              
              ListenableBuilder(
                listenable: globalSessionManager,
                builder: (context, _) {
                  return Text(
                    globalSessionManager.formattedTime, 
                    style: GoogleFonts.dmSans(fontSize: 80, fontWeight: FontWeight.w800, color: Colors.white, height: 1.1),
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
                    Text('Step 1', style: GoogleFonts.inter(color: Colors.white70, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    Text('Raise Arms Overhead', style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18)),
                    const SizedBox(height: 16),
                    // Progress Bar
                    Container(
                      height: 6,
                      width: double.infinity,
                      decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.3), borderRadius: BorderRadius.circular(3)),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: 0.3, // Example: 30% complete
                        child: Container(
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(3)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 32),
              
              // 3. The new Row with TWO buttons!
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
                      onPressed: _endSession, // Routes to completion
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: Text('End Session', style: GoogleFonts.inter(fontWeight: FontWeight.w700, color: const Color(0xFFF19D38), fontSize: 16)),
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