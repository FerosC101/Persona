import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SleepCompletionScreen extends StatelessWidget {
  const SleepCompletionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F2F8),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: const BoxDecoration(color: Color(0xFFF0EAFF), shape: BoxShape.circle),
                child: const Icon(Icons.nightlight_round, size: 72, color: Color(0xFF8B5CF6)),
              ),
              const SizedBox(height: 24),
              Text('Sleep Plan Activated', style: GoogleFonts.dmSans(fontSize: 28, fontWeight: FontWeight.w800, color: const Color(0xFF1A0A2E))),
              const SizedBox(height: 8),
              Text('Your dock is ready for tonight.', style: GoogleFonts.inter(fontSize: 16, color: const Color(0xFF8C8CA0))),
              
              const SizedBox(height: 48),
              
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: const [
                    BoxShadow(color: Color(0x14A090C0), blurRadius: 20, offset: Offset(0, 4)),
                  ],
                ),
                child: Column(
                  children: [
                    _buildSummaryRow('Scheduled Bedtime', '10:45 PM', isBold: true),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 16), child: Divider(height: 1, color: Color(0xFFEAE5F0))),
                    _buildSummaryRow('Reminder', '10:15 PM'),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 16), child: Divider(height: 1, color: Color(0xFFEAE5F0))),
                    _buildSummaryRow('Sleep Goal', '8 Hours'),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 16), child: Divider(height: 1, color: Color(0xFFEAE5F0))),
                    _buildSummaryRow('Dock Actions', '• Warm Lighting\n• Chamomile Scent'),
                  ],
                ),
              ),
              
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8B5CF6),
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: Text('Done', style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 18, color: Colors.white)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isBold = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(label, style: GoogleFonts.inter(color: const Color(0xFF8C8CA0), fontWeight: FontWeight.w500, fontSize: 15)),
        ),
        Text(
          value, 
          textAlign: TextAlign.right,
          style: GoogleFonts.inter(color: isBold ? const Color(0xFF8B5CF6) : const Color(0xFF1A0A2E), fontWeight: isBold ? FontWeight.w700 : FontWeight.w500, fontSize: 15),
        ),
      ],
    );
  }
}