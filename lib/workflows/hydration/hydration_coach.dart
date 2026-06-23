import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'hydration_success.dart';

class HydrationCoachSheet extends StatelessWidget {
  const HydrationCoachSheet({super.key});

  void _logWater(BuildContext context) {
    Navigator.of(context).pop();
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const HydrationSuccessScreen()),
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
          Text('Stay Hydrated', style: GoogleFonts.dmSans(fontSize: 24, fontWeight: FontWeight.w800, color: const Color(0xFF1A0A2E))),
          const SizedBox(height: 24),
          
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Today's Intake", style: GoogleFonts.inter(fontWeight: FontWeight.w600, color: const Color(0xFF8C8CA0))),
                    Text('6 / 8 Glasses', style: GoogleFonts.inter(fontWeight: FontWeight.w700, color: const Color(0xFF1A0A2E))),
                  ],
                ),
                const SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: 6 / 8,
                    minHeight: 12,
                    backgroundColor: const Color(0xFFE8DFF5),
                    valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF34C9C9)),
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          Text('Recommendation', style: GoogleFonts.inter(fontWeight: FontWeight.w600, color: const Color(0xFF8C8CA0))),
          const SizedBox(height: 8),
          Text('Drink 250ml of water now.', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600, color: const Color(0xFF1A0A2E))),

          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _logWater(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF34C9C9),
                padding: const EdgeInsets.symmetric(vertical: 18),
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: Text('I Drank It', style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 16, color: Colors.white)),
            ),
          )
        ],
      ),
    );
  }
}