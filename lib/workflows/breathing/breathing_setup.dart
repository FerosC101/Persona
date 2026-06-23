import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'breathing_active.dart';

class BreathingSetupSheet extends StatefulWidget {
  const BreathingSetupSheet({super.key});

  @override
  State<BreathingSetupSheet> createState() => _BreathingSetupSheetState();
}

class _BreathingSetupSheetState extends State<BreathingSetupSheet> {
  int _duration = 5;
  String _technique = 'Box Breathing';
  bool _softLighting = true;
  bool _vanillaScent = true;

  void _startExercise() {
    Navigator.of(context).pop();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BreathingActiveScreen(
          duration: _duration,
          technique: _technique,
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
          Text('Breathing Exercise', style: GoogleFonts.dmSans(fontSize: 24, fontWeight: FontWeight.w800, color: const Color(0xFF1A0A2E))),
          const SizedBox(height: 24),
          
          // Dropdowns for Duration and Technique
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Duration', style: GoogleFonts.inter(fontWeight: FontWeight.w600, color: const Color(0xFF8C8CA0))),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<int>(
                      value: _duration,
                      decoration: InputDecoration(filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none)),
                      items: [1, 3, 5, 10].map((m) => DropdownMenuItem(value: m, child: Text('$m Min', style: GoogleFonts.inter(fontWeight: FontWeight.w600)))).toList(),
                      onChanged: (v) => setState(() => _duration = v ?? _duration),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Technique', style: GoogleFonts.inter(fontWeight: FontWeight.w600, color: const Color(0xFF8C8CA0))),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: _technique,
                      decoration: InputDecoration(filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none)),
                      items: ['Box Breathing', '4-7-8', 'Awake'].map((m) => DropdownMenuItem(value: m, child: Text(m, style: GoogleFonts.inter(fontWeight: FontWeight.w600)))).toList(),
                      onChanged: (v) => setState(() => _technique = v ?? _technique),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),
          Text('Dock Automation', style: GoogleFonts.inter(fontWeight: FontWeight.w600, color: const Color(0xFF8C8CA0))),
          const SizedBox(height: 8),
          
          // THE FIX: Wrapped the checkboxes in a white container to match SleepSetupSheet
          Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: Column(
              children: [
                CheckboxListTile(
                  title: Text('Soft Lighting', style: GoogleFonts.inter(fontWeight: FontWeight.w600, color: const Color(0xFF1A0A2E))),
                  value: _softLighting,
                  activeColor: const Color(0xFFE879A0), // Kept the pink color!
                  onChanged: (v) => setState(() => _softLighting = v ?? true),
                ),
                CheckboxListTile(
                  title: Text('Vanilla Scent', style: GoogleFonts.inter(fontWeight: FontWeight.w600, color: const Color(0xFF1A0A2E))),
                  value: _vanillaScent,
                  activeColor: const Color(0xFFE879A0), // Kept the pink color!
                  onChanged: (v) => setState(() => _vanillaScent = v ?? true),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16), 
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    side: const BorderSide(color: Color(0xFFD0CADA))
                  ),
                  child: Text('Cancel', style: GoogleFonts.inter(fontWeight: FontWeight.w600, color: const Color(0xFF5B3B8C))),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: _startExercise,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE879A0), // Kept the pink button!
                    padding: const EdgeInsets.symmetric(vertical: 16), 
                    elevation: 0, 
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))
                  ),
                  child: Text('Start Exercise', style: GoogleFonts.inter(fontWeight: FontWeight.w700, color: Colors.white)),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}