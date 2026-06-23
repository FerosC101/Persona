import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'session_manager.dart';

class GlobalSessionOverlay extends StatelessWidget {
  const GlobalSessionOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: globalSessionManager,
      builder: (context, _) {
        if (!globalSessionManager.isActive || globalSessionManager.isOverlaySuppressed) {
          return const SizedBox.shrink();
        }

        return Positioned(
          left: 16,
          right: 16,
          bottom: 100, 
          child: Material(
            color: Colors.transparent,
            
            child: GestureDetector(
              onTap: () {
                final targetScreen = globalSessionManager.activeScreen;
                if (targetScreen != null) {
                  // Uses the global key to push the screen from anywhere!
                  globalNavigatorKey.currentState?.push(
                    MaterialPageRoute(builder: (_) => targetScreen),
                  );
                }
              },
              
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white, 
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12, 
                      blurRadius: 20,
                      offset: Offset(0, 8),
                    ),
                  ],
                  border: Border.all(color: const Color(0xFFEAE5F0)), // Subtle border
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: globalSessionManager.color, 
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        globalSessionManager.icon, 
                        color: Colors.white, 
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Active Session', style: GoogleFonts.inter(color: const Color(0xFF8C8CA0), fontSize: 12, fontWeight: FontWeight.w600)),
                          const SizedBox(height: 2),
                          Text(
                            globalSessionManager.title,
                            style: GoogleFonts.inter(color: const Color(0xFF1A0A2E), fontSize: 16, fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text('${globalSessionManager.formattedTime} Remaining', style: GoogleFonts.inter(color: const Color(0xFF34C9C9), fontSize: 13, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    
                    IconButton(
                      onPressed: () => globalSessionManager.togglePause(),
                      icon: Icon(
                        globalSessionManager.isPaused ? Icons.play_arrow_rounded : Icons.pause_rounded,
                        color: const Color(0xFF1A0A2E), // Darker icon
                        size: 28,
                      ),
                    ),
                    
                    IconButton(
                      onPressed: () {
                        final targetScreen = globalSessionManager.completionScreen;
                        globalSessionManager.endSession();
                        
                        if (targetScreen != null) {
                          // Uses the global key so it doesn't crash from being an overlay!
                          globalNavigatorKey.currentState?.push(
                            MaterialPageRoute(builder: (_) => targetScreen),
                          );
                        }
                      },
                      icon: const Icon(Icons.stop_circle_rounded, color: Color(0xFFE879A0), size: 28),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}