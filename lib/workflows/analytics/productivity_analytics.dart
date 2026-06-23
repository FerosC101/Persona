import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductivityAnalyticsScreen extends StatelessWidget {
  const ProductivityAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F2F8), // Soft app background
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Header ---
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF1A0A2E), size: 20),
                    onPressed: () => Navigator.of(context).pop(),
                    padding: EdgeInsets.zero,
                    alignment: Alignment.centerLeft,
                  ),
                  Text(
                    'Productivity', 
                    style: GoogleFonts.dmSans(fontSize: 24, fontWeight: FontWeight.w800, color: const Color(0xFF1A0A2E)),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // --- Daily Summary Cards ---
              Row(
                children: [
                  Expanded(child: _buildSummaryCard('Focus Time', '2h 45m', Icons.timer_outlined, const Color(0xFF1D9D98))),
                  const SizedBox(width: 16),
                  Expanded(child: _buildSummaryCard('Sessions', '4', Icons.check_circle_outline, const Color(0xFF2E9F64))),
                ],
              ),
              const SizedBox(height: 32),

              // --- Focus Trend Chart ---
              Text('This Week', style: GoogleFonts.dmSans(fontSize: 20, fontWeight: FontWeight.bold, color: const Color(0xFF1A0A2E))),
              const SizedBox(height: 16),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _buildChartBar('M', 0.4, false),
                        _buildChartBar('T', 0.7, false),
                        _buildChartBar('W', 0.9, false),
                        _buildChartBar('T', 1.0, true), // Today (highlighted)
                        _buildChartBar('F', 0.0, false),
                        _buildChartBar('S', 0.0, false),
                        _buildChartBar('S', 0.0, false),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // --- Recent Activity List ---
              Text('Recent Activity', style: GoogleFonts.dmSans(fontSize: 20, fontWeight: FontWeight.bold, color: const Color(0xFF1A0A2E))),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: const [BoxShadow(color: Color(0x14A090C0), blurRadius: 20, offset: Offset(0, 4))],
                ),
                child: Column(
                  children: [
                    _buildActivityTile('Deep Work Session', '25 Minutes • Focus Lighting', Icons.bolt, const Color(0xFF1D9D98)),
                    const Divider(height: 1, color: Color(0xFFEAE5F0), indent: 72),
                    _buildActivityTile('Pomodoro Focus', '25 Minutes • Peppermint', Icons.local_cafe_outlined, const Color(0xFF2E9F64)),
                    const Divider(height: 1, color: Color(0xFFEAE5F0), indent: 72),
                    _buildActivityTile('Deep Work Session', '90 Minutes • Focus Lighting', Icons.bolt, const Color(0xFF1D9D98)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [BoxShadow(color: Color(0x14A090C0), blurRadius: 20, offset: Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: color.withValues(alpha: 0.15), shape: BoxShape.circle),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 16),
          Text(title, style: GoogleFonts.inter(color: const Color(0xFF8C8CA0), fontWeight: FontWeight.w600, fontSize: 13)),
          const SizedBox(height: 4),
          Text(value, style: GoogleFonts.dmSans(color: const Color(0xFF1A0A2E), fontWeight: FontWeight.bold, fontSize: 22)),
        ],
      ),
    );
  }

  Widget _buildChartBar(String day, double percentage, bool isToday) {
    return Column(
      children: [
        Container(
          height: 120,
          width: 24,
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
            color: const Color(0xFFF4F2F8),
            borderRadius: BorderRadius.circular(12),
          ),
          child: FractionallySizedBox(
            heightFactor: percentage,
            child: Container(
              decoration: BoxDecoration(
                color: isToday ? const Color(0xFF1D9D98) : const Color(0xFFD0CADA),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          day,
          style: GoogleFonts.inter(
            color: isToday ? const Color(0xFF1D9D98) : const Color(0xFF8C8CA0),
            fontWeight: isToday ? FontWeight.bold : FontWeight.w600,
          ),
        )
      ],
    );
  }

  Widget _buildActivityTile(String title, String subtitle, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: color.withValues(alpha: 0.15), shape: BoxShape.circle),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.inter(color: const Color(0xFF1A0A2E), fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Text(subtitle, style: GoogleFonts.inter(color: const Color(0xFF8C8CA0), fontSize: 13, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}