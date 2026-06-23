import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'energy_reset_active.dart';

class EnergyResetSetupSheet extends StatefulWidget {
  const EnergyResetSetupSheet({super.key});

  @override
  State<EnergyResetSetupSheet> createState() => _EnergyResetSetupSheetState();
}

class _EnergyResetSetupSheetState extends State<EnergyResetSetupSheet> {
  bool _stretching = true;
  bool _brightLighting = true;
  bool _citrusScent = true;

  void _startReset() {
    Navigator.of(context).pop();
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => const EnergyResetActiveScreen(duration: 3)));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Color(0xFFF4F2F8), borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.black12, borderRadius: BorderRadius.circular(4)))),
          const SizedBox(height: 24),
          Text('Afternoon Energy Reset', style: GoogleFonts.dmSans(fontSize: 24, fontWeight: FontWeight.w800, color: const Color(0xFF1A0A2E))),
          const SizedBox(height: 24),
          
          Text('Duration', style: GoogleFonts.inter(fontWeight: FontWeight.w600, color: const Color(0xFF8C8CA0))),
          const SizedBox(height: 8),
          Container(width: double.infinity, padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)), child: Text('3 Minutes', style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 16, color: const Color(0xFF1A0A2E)))),
          
          const SizedBox(height: 24),
          Text('Recommended Actions', style: GoogleFonts.inter(fontWeight: FontWeight.w600, color: const Color(0xFF8C8CA0))),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: Column(
              children: [
                CheckboxListTile(title: Text('Stretching', style: GoogleFonts.inter(fontWeight: FontWeight.w600)), value: _stretching, activeColor: const Color(0xFFF3A33E), onChanged: (v) => setState(() => _stretching = v ?? true)),
                CheckboxListTile(title: Text('Bright Lighting', style: GoogleFonts.inter(fontWeight: FontWeight.w600)), value: _brightLighting, activeColor: const Color(0xFFF3A33E), onChanged: (v) => setState(() => _brightLighting = v ?? true)),
                CheckboxListTile(title: Text('Citrus Scent', style: GoogleFonts.inter(fontWeight: FontWeight.w600)), value: _citrusScent, activeColor: const Color(0xFFF3A33E), onChanged: (v) => setState(() => _citrusScent = v ?? true)),
              ],
            ),
          ),

          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(child: OutlinedButton(onPressed: () => Navigator.of(context).pop(), style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))), child: Text('Cancel', style: GoogleFonts.inter(fontWeight: FontWeight.w600, color: const Color(0xFF5B3B8C))))),
              const SizedBox(width: 16),
              Expanded(child: ElevatedButton(onPressed: _startReset, style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFF3A33E), padding: const EdgeInsets.symmetric(vertical: 16), elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))), child: Text('Start Reset', style: GoogleFonts.inter(fontWeight: FontWeight.w700, color: Colors.white)))),
            ],
          )
        ],
      ),
    );
  }
}