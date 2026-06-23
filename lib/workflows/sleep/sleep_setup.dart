import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'sleep_completion.dart';

class SleepSetupSheet extends StatefulWidget {
  const SleepSetupSheet({super.key});

  @override
  State<SleepSetupSheet> createState() => _SleepSetupSheetState();
}

class _SleepSetupSheetState extends State<SleepSetupSheet> {
  bool _warmLighting = true;
  bool _chamomileScent = true;

  void _applySchedule() {
    Navigator.of(context).pop(); // Close setup
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const SleepCompletionScreen(),
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
          Text('Sleep Optimization', style: GoogleFonts.dmSans(fontSize: 24, fontWeight: FontWeight.w800, color: const Color(0xFF1A0A2E))),
          const SizedBox(height: 24),
          
          // Bedtime Comparison Box
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE8DFF5)),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Current Bedtime', style: GoogleFonts.inter(fontWeight: FontWeight.w600, color: const Color(0xFF8C8CA0))),
                    Text('11:30 PM', style: GoogleFonts.inter(fontWeight: FontWeight.w600, color: const Color(0xFF1A0A2E))),
                  ],
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 12), child: Divider(height: 1, color: Color(0xFFEAE5F0))),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Recommended', style: GoogleFonts.inter(fontWeight: FontWeight.w700, color: const Color(0xFF8B5CF6))),
                    Text('10:45 PM', style: GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 16, color: const Color(0xFF8B5CF6))),
                  ],
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          Text('Reason', style: GoogleFonts.inter(fontWeight: FontWeight.w600, color: const Color(0xFF8C8CA0))),
          const SizedBox(height: 4),
          Text('Your best sleep quality occurs between 10 PM and 6 AM.', style: GoogleFonts.inter(color: const Color(0xFF1A0A2E), height: 1.4)),
          
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Sleep Goal', style: GoogleFonts.inter(fontWeight: FontWeight.w600, color: const Color(0xFF8C8CA0))),
              Text('8 Hours', style: GoogleFonts.inter(fontWeight: FontWeight.w700, color: const Color(0xFF1A0A2E))),
            ],
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
                  activeColor: const Color(0xFF8B5CF6), // Sleep Purple
                  onChanged: (v) => setState(() => _warmLighting = v ?? true),
                ),
                CheckboxListTile(
                  title: Text('Chamomile Scent', style: GoogleFonts.inter(fontWeight: FontWeight.w600, color: const Color(0xFF1A0A2E))),
                  value: _chamomileScent,
                  activeColor: const Color(0xFF8B5CF6),
                  onChanged: (v) => setState(() => _chamomileScent = v ?? true),
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
                  style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                  child: Text('Cancel', style: GoogleFonts.inter(fontWeight: FontWeight.w600, color: const Color(0xFF5B3B8C))),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: _applySchedule,
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF8B5CF6), padding: const EdgeInsets.symmetric(vertical: 16), elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                  child: Text('Apply Schedule', style: GoogleFonts.inter(fontWeight: FontWeight.w700, color: Colors.white)),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}