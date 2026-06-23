import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HydrationSuccessScreen extends StatelessWidget {
  const HydrationSuccessScreen({super.key});

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
                decoration: BoxDecoration(color: const Color(0xFF34C9C9).withValues(alpha: 0.15), shape: BoxShape.circle),
                child: const Icon(Icons.water_drop, size: 72, color: Color(0xFF34C9C9)),
              ),
              const SizedBox(height: 24),
              Text('Water Logged', style: GoogleFonts.dmSans(fontSize: 28, fontWeight: FontWeight.w800, color: const Color(0xFF1A0A2E))),
              
              const SizedBox(height: 48),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), boxShadow: const [BoxShadow(color: Color(0x14A090C0), blurRadius: 20, offset: Offset(0, 4))]),
                child: Column(
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("Today's Intake", style: GoogleFonts.inter(color: const Color(0xFF8C8CA0), fontWeight: FontWeight.w500)), Text('7 / 8 Glasses', style: GoogleFonts.inter(color: const Color(0xFF1A0A2E), fontWeight: FontWeight.w700))]),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 16), child: Divider(height: 1, color: Color(0xFFEAE5F0))),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Progress', style: GoogleFonts.inter(color: const Color(0xFF8C8CA0), fontWeight: FontWeight.w500)), Text('87%', style: GoogleFonts.inter(color: const Color(0xFF34C9C9), fontWeight: FontWeight.w800))]),
                  ],
                ),
              ),
              
              const SizedBox(height: 32),
              Text('Great job!', style: GoogleFonts.dmSans(fontSize: 20, fontWeight: FontWeight.bold, color: const Color(0xFF1A0A2E))),
              const SizedBox(height: 8),
              Text('Only one glass remaining\nto reach today\'s goal.', textAlign: TextAlign.center, style: GoogleFonts.inter(color: const Color(0xFF8C8CA0), height: 1.5)),

              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF34C9C9), padding: const EdgeInsets.symmetric(vertical: 18), elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                  child: Text('Done', style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 18, color: Colors.white)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}