import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'deep_work_active.dart';

class DeepWorkSetupSheet extends StatefulWidget {
  const DeepWorkSetupSheet({super.key});

  @override
  State<DeepWorkSetupSheet> createState() => _DeepWorkSetupSheetState();
}

class _DeepWorkSetupSheetState extends State<DeepWorkSetupSheet> {
  int _minutes = 25;
  bool _focusLighting = true;
  bool _peppermintScent = true;
  bool _silenceNotifications = true;

  void _startFocus() {
    Navigator.of(context).pop(); // Close the setup sheet
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => DeepWorkActiveScreen(duration: _minutes),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFF4F2F8), // Soft wellness background
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Deep Work Session',
            style: GoogleFonts.dmSans(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF1A0A2E),
            ),
          ),
          const SizedBox(height: 24),
          
          Text('Duration', style: GoogleFonts.inter(fontWeight: FontWeight.w600, color: const Color(0xFF8C8CA0))),
          const SizedBox(height: 8),
          DropdownButtonFormField<int>(
            value: _minutes,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
            ),
            items: [15, 25, 45, 60, 90].map((m) => DropdownMenuItem(value: m, child: Text('$m Minutes', style: GoogleFonts.inter(fontWeight: FontWeight.w600)))).toList(),
            onChanged: (v) => setState(() => _minutes = v ?? _minutes),
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
                  activeColor: const Color(0xFF34C9C9), // Focus Teal
                  onChanged: (v) => setState(() => _focusLighting = v ?? true),
                ),
                CheckboxListTile(
                  title: Text('Peppermint Scent', style: GoogleFonts.inter(fontWeight: FontWeight.w600, color: const Color(0xFF1A0A2E))),
                  value: _peppermintScent,
                  activeColor: const Color(0xFF34C9C9),
                  onChanged: (v) => setState(() => _peppermintScent = v ?? true),
                ),
                CheckboxListTile(
                  title: Text('Silence Notifications', style: GoogleFonts.inter(fontWeight: FontWeight.w600, color: const Color(0xFF1A0A2E))),
                  value: _silenceNotifications,
                  activeColor: const Color(0xFF34C9C9),
                  onChanged: (v) => setState(() => _silenceNotifications = v ?? true),
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
                  onPressed: _startFocus,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF34C9C9), // Focus Teal
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: Text('Start Focus', style: GoogleFonts.inter(fontWeight: FontWeight.w700, color: Colors.white)),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}