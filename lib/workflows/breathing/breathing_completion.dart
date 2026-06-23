import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BreathingCompletionScreen extends StatefulWidget {
  final int durationCompleted;
  final String technique;

  const BreathingCompletionScreen({
    super.key, 
    required this.durationCompleted,
    required this.technique,
  });

  @override
  State<BreathingCompletionScreen> createState() => _BreathingCompletionScreenState();
}

class _BreathingCompletionScreenState extends State<BreathingCompletionScreen> {
  String _selectedMood = '';

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
                decoration: BoxDecoration(color: const Color(0xFFFFEAF0), shape: BoxShape.circle),
                child: const Icon(Icons.self_improvement, size: 72, color: Color(0xFFE879A0)),
              ),
              const SizedBox(height: 24),
              Text('Exercise Complete', style: GoogleFonts.dmSans(fontSize: 28, fontWeight: FontWeight.w800, color: const Color(0xFF1A0A2E))),
              
              const SizedBox(height: 32),
              
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
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Duration', style: GoogleFonts.inter(color: const Color(0xFF8C8CA0))), Text('${widget.durationCompleted} Minutes', style: GoogleFonts.inter(fontWeight: FontWeight.bold, color: const Color(0xFF1A0A2E)))]),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 16), child: Divider(height: 1, color: Color(0xFFEAE5F0))),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Technique', style: GoogleFonts.inter(color: const Color(0xFF8C8CA0))), Text(widget.technique, style: GoogleFonts.inter(fontWeight: FontWeight.bold, color: const Color(0xFF1A0A2E)))]),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              Align(alignment: Alignment.centerLeft, child: Text('Mood Check-In', style: GoogleFonts.dmSans(fontSize: 20, fontWeight: FontWeight.bold, color: const Color(0xFF1A0A2E)))),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: _MoodButton(label: 'Better', isSelected: _selectedMood == 'Better', onTap: () => setState(() => _selectedMood = 'Better'))),
                  const SizedBox(width: 12),
                  Expanded(child: _MoodButton(label: 'Calm', isSelected: _selectedMood == 'Calm', onTap: () => setState(() => _selectedMood = 'Calm'))),
                  const SizedBox(width: 12),
                  Expanded(child: _MoodButton(label: 'Same', isSelected: _selectedMood == 'Same', onTap: () => setState(() => _selectedMood = 'Same'))),
                ],
              ),
              
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _selectedMood.isEmpty ? null : () => Navigator.of(context).popUntil((route) => route.isFirst),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD3A4B4), // A softer disabled state color
                    disabledBackgroundColor: const Color(0xFFD0CADA),
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ).copyWith(
                    backgroundColor: WidgetStateProperty.resolveWith<Color>(
                      (Set<WidgetState> states) {
                        if (states.contains(WidgetState.disabled)) return const Color(0xFFD0CADA);
                        return const Color(0xFF5B3B8C); // Original deep purple when active
                      },
                    ),
                  ),
                  child: Text('Submit', style: GoogleFonts.inter(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _MoodButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _MoodButton({required this.label, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20), // Thicker padding since emoji is gone
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFE879A0).withOpacity(0.15) : Colors.white,
          border: Border.all(color: isSelected ? const Color(0xFFE879A0) : Colors.transparent, width: 2),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text(
            label, 
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w600, 
              color: isSelected ? const Color(0xFFE879A0) : const Color(0xFF1A0A2E),
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}