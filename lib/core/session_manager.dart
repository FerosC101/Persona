import 'dart:async';
import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> globalNavigatorKey = GlobalKey<NavigatorState>();
final globalSessionManager = SessionManager();

class SessionManager extends ChangeNotifier {
  bool _isActive = false;
  bool _isPaused = false;
  String _title = '';
  
  IconData? _icon;
  Color _color = Colors.grey;
  
  int _remainingSeconds = 0;
  Timer? _timer;
  
  int _overlaySuppressCount = 0; 
  bool get isOverlaySuppressed => _overlaySuppressCount > 0; 

  Widget? _completionScreen; 
  Widget? get completionScreen => _completionScreen;

  bool get isActive => _isActive;
  bool get isPaused => _isPaused;
  String get title => _title;
  
  IconData? get icon => _icon;
  Color get color => _color;
  
  int get remainingSeconds => _remainingSeconds;

  String get formattedTime {
    final m = (_remainingSeconds / 60).floor().toString().padLeft(2, '0');
    final s = (_remainingSeconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

Widget? _activeScreen; 
  Widget? get activeScreen => _activeScreen;

  void startSession({
    required String title, 
    required IconData icon, 
    required Color color, 
    required int durationMinutes,
    Widget? completionScreen, 
    Widget? activeScreen, // <--- NEW PARAMETER
  }) {
    if (_isActive && _title == title) {
      _completionScreen = completionScreen;
      _activeScreen = activeScreen;
      return; 
    }

    _title = title;
    _icon = icon;
    _color = color;
    _remainingSeconds = durationMinutes * 60;
    _completionScreen = completionScreen; 
    _activeScreen = activeScreen; // <--- SAVE IT
    _isActive = true;
    _isPaused = false;
    notifyListeners();

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!_isPaused && _remainingSeconds > 0) {
        _remainingSeconds--;
        notifyListeners();
      } else if (_remainingSeconds <= 0) {
        endSession();
      }
    });
  }

  void togglePause() {
    _isPaused = !_isPaused;
    notifyListeners();
  }

  void setOverlaySuppressed(bool suppress) {
    if (suppress) {
      _overlaySuppressCount++;
    } else {
      _overlaySuppressCount--;
      if (_overlaySuppressCount < 0) _overlaySuppressCount = 0; // Safety net
    }
    notifyListeners();
  }

  void endSession() {
    _isActive = false;
    _isPaused = false;
    _title = '';
    _timer?.cancel();
    notifyListeners();
  }
}