import 'package:flutter/foundation.dart';

/// Class logging terstruktur yang aman.
///
/// Log hanya ditampilkan saat aplikasi berjalan dalam mode debug ([kDebugMode]).
class Logger {
  static void debug(String message) {
    if (kDebugMode) {
      debugPrint('[DEBUG] $message');
    }
  }

  static void info(String message) {
    if (kDebugMode) {
      debugPrint('[INFO] $message');
    }
  }

  static void warning(String message) {
    if (kDebugMode) {
      debugPrint('[WARNING] $message');
    }
  }

  static void error(String message, [Object? error]) {
    if (kDebugMode) {
      debugPrint('[ERROR] $message${error != null ? ' -> $error' : ''}');
    }
  }
}