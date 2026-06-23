import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'pomodoro_active.dart';

class PomodoroSetupSheet extends StatefulWidget {
  const PomodoroSetupSheet({super.key});

  @override
  State<PomodoroSetupSheet> createState() => _PomodoroSetupSheetState();
}

class _PomodoroSetupSheetState extends State<PomodoroSetupSheet> {
  int _workDuration = 25;
  int _breakDuration = 5;
  int _cycles = 4;
  bool _focusLighting = true;
  bool _peppermintScent = true;

  void _startSession() {
    Navigator.of(context).pop(); 
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PomodoroActiveScreen(
          workDuration: _workDuration,
          breakDuration: _breakDuration,
          totalCycles: _cycles,
          currentCycle: 1, // Start at cycle 1
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFF4F2F8),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.black12, borderRadius: BorderRadius.circular(4)))),
          const SizedBox(height: 24),
          Text('Pomodoro Session', style: GoogleFonts.dmSans(fontSize: 24, fontWeight: FontWeight.w800, color: const Color(0xFF1A0A2E))),
          const SizedBox(height: 24),
          
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Work Duration', style: GoogleFonts.inter(fontWeight: FontWeight.w600, color: const Color(0xFF8C8CA0))),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<int>(
                      value: _workDuration,
                      decoration: InputDecoration(filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none)),
                      items: [15, 25, 45, 60].map((m) => DropdownMenuItem(value: m, child: Text('$m Min', style: GoogleFonts.inter(fontWeight: FontWeight.w600)))).toList(),
                      onChanged: (v) => setState(() => _workDuration = v ?? _workDuration),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Break Duration', style: GoogleFonts.inter(fontWeight: FontWeight.w600, color: const Color(0xFF8C8CA0))),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<int>(
                      value: _breakDuration,
                      decoration: InputDecoration(filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none)),
                      items: [5, 10, 15].map((m) => DropdownMenuItem(value: m, child: Text('$m Min', style: GoogleFonts.inter(fontWeight: FontWeight.w600)))).toList(),
                      onChanged: (v) => setState(() => _breakDuration = v ?? _breakDuration),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          Text('Cycles', style: GoogleFonts.inter(fontWeight: FontWeight.w600, color: const Color(0xFF8C8CA0))),
          const SizedBox(height: 8),
          DropdownButtonFormField<int>(
            value: _cycles,
            decoration: InputDecoration(filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none)),
            items: [2, 3, 4, 5, 6].map((c) => DropdownMenuItem(value: c, child: Text('$c Cycles', style: GoogleFonts.inter(fontWeight: FontWeight.w600)))).toList(),
            onChanged: (v) => setState(() => _cycles = v ?? _cycles),
          ),

          const SizedBox(height: 24),
          Text('Dock Automation', style: GoogleFonts.inter(fontWeight: FontWeight.w600, color: const Color(0xFF8C8CA0))),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: Column(
              children: [
                CheckboxListTile(
                  title: Text('Focus Lighting', style: GoogleFonts.inter(fontWeight: FontWeight.w600, color: const Color(0xFF1A0A2E))),
                  value: _focusLighting,
                  activeColor: const Color(0xFF2E9F64), // Productivity Green
                  onChanged: (v) => setState(() => _focusLighting = v ?? true),
                ),
                CheckboxListTile(
                  title: Text('Peppermint Scent', style: GoogleFonts.inter(fontWeight: FontWeight.w600, color: const Color(0xFF1A0A2E))),
                  value: _peppermintScent,
                  activeColor: const Color(0xFF2E9F64),
                  onChanged: (v) => setState(() => _peppermintScent = v ?? true),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _startSession,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E9F64),
                padding: const EdgeInsets.symmetric(vertical: 18),
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: Text('Start Session', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white)),
            ),
          )
        ],
      ),
    );
  }
}