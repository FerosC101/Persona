import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'wind_down_active.dart';

class WindDownSetupSheet extends StatefulWidget {
  const WindDownSetupSheet({super.key});

  @override
  State<WindDownSetupSheet> createState() => _WindDownSetupSheetState();
}

class _WindDownSetupSheetState extends State<WindDownSetupSheet> {
  bool _warmLighting = true;
  bool _lavenderScent = true;
  final int _duration = 20;

  void _startRoutine() {
    Navigator.of(context).pop(); // Close setup
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => WindDownActiveScreen(duration: _duration),
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
          Text('Wind-Down Routine', style: GoogleFonts.dmSans(fontSize: 24, fontWeight: FontWeight.w800, color: const Color(0xFF1A0A2E))),
          const SizedBox(height: 24),
          
          Text('Routine Duration', style: GoogleFonts.inter(fontWeight: FontWeight.w600, color: const Color(0xFF8C8CA0))),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text('$_duration Minutes', style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 16, color: const Color(0xFF1A0A2E))),
          ),
          
          const SizedBox(height: 24),
          Text('Dock Automation', style: GoogleFonts.inter(fontWeight: FontWeight.w600, color: const Color(0xFF8C8CA0))),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: Column(
              children: [
                CheckboxListTile(
                  title: Text('Warm Lighting', style: GoogleFonts.inter(fontWeight: FontWeight.w600, color: const Color(0xFF1A0A2E))),
                  value: _warmLighting,
                  activeColor: const Color(0xFFF3A33E), // Self-Care Orange
                  onChanged: (v) => setState(() => _warmLighting = v ?? true),
                ),
                CheckboxListTile(
                  title: Text('Lavender Scent', style: GoogleFonts.inter(fontWeight: FontWeight.w600, color: const Color(0xFF1A0A2E))),
                  value: _lavenderScent,
                  activeColor: const Color(0xFFF3A33E),
                  onChanged: (v) => setState(() => _lavenderScent = v ?? true),
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
                    side: const BorderSide(color: Color(0xFFD0CADA)),
                  ),
                  child: Text('Cancel', style: GoogleFonts.inter(fontWeight: FontWeight.w600, color: const Color(0xFF5B3B8C))),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: _startRoutine,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF3A33E), // Self-Care Orange
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: Text('Start Routine', style: GoogleFonts.inter(fontWeight: FontWeight.w700, color: Colors.white)),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}