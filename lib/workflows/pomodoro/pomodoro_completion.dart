import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../analytics/productivity_analytics.dart';

class PomodoroCompletionScreen extends StatelessWidget {
  final int cyclesCompleted;
  final int workDuration;
  final int breakDuration;

  const PomodoroCompletionScreen({
    super.key, 
    required this.cyclesCompleted,
    required this.workDuration,
    required this.breakDuration,
  });

  @override
  Widget build(BuildContext context) {
    final totalFocus = cyclesCompleted * workDuration;
    final totalBreak = (cyclesCompleted - 1) * breakDuration; 

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
                decoration: BoxDecoration(color: const Color(0xFF2E9F64).withValues(alpha: 0.15), shape: BoxShape.circle),
                child: const Icon(Icons.emoji_events, size: 72, color: Color(0xFF2E9F64)),
              ),
              const SizedBox(height: 24),
              Text('Pomodoro Complete', style: GoogleFonts.dmSans(fontSize: 28, fontWeight: FontWeight.w800, color: const Color(0xFF1A0A2E))),
              const SizedBox(height: 8),
              Text('Incredible focus session today.', style: GoogleFonts.inter(fontSize: 16, color: const Color(0xFF8C8CA0))),
              
              const SizedBox(height: 48),
              
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: const [BoxShadow(color: Color(0x14A090C0), blurRadius: 20, offset: Offset(0, 4))],
                ),
                child: Column(
                  children: [
                    _buildSummaryRow('Cycles Completed', '$cyclesCompleted'),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 16), child: Divider(height: 1, color: Color(0xFFEAE5F0))),
                    _buildSummaryRow('Focus Time', '$totalFocus Minutes', isBold: true),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 16), child: Divider(height: 1, color: Color(0xFFEAE5F0))),
                    _buildSummaryRow('Break Time', '$totalBreak Minutes'),
                  ],
                ),
              ),
              
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const ProductivityAnalyticsScreen(),
                        ),
                      );
                    },
                      style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 18), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), side: const BorderSide(color: Color(0xFFD0CADA))),
                      child: Text('View Analytics', style: GoogleFonts.inter(fontWeight: FontWeight.w700, color: const Color(0xFF5B3B8C))),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2E9F64), padding: const EdgeInsets.symmetric(vertical: 18), elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                      child: Text('Done', style: GoogleFonts.inter(fontWeight: FontWeight.w700, color: Colors.white)),
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

  Widget _buildSummaryRow(String label, String value, {bool isBold = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: Text(label, style: GoogleFonts.inter(color: const Color(0xFF8C8CA0), fontWeight: FontWeight.w500, fontSize: 15))),
        Text(value, textAlign: TextAlign.right, style: GoogleFonts.inter(color: isBold ? const Color(0xFF2E9F64) : const Color(0xFF1A0A2E), fontWeight: isBold ? FontWeight.w800 : FontWeight.w600, fontSize: 15)),
      ],
    );
  }
}