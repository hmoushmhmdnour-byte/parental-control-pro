class AppExtensions {
  // String Extensions
  static bool isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  static String truncate(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }

  // DateTime Extensions
  static String formatDateTime(DateTime dateTime) {
    return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  static String timeAgo(DateTime dateTime) {
    final duration = DateTime.now().difference(dateTime);
    if (duration.inSeconds < 60) {
      return 'الآن';
    } else if (duration.inMinutes < 60) {
      return 'قبل ${duration.inMinutes} دقيقة';
    } else if (duration.inHours < 24) {
      return 'قبل ${duration.inHours} ساعة';
    } else if (duration.inDays < 7) {
      return 'قبل ${duration.inDays} أيام';
    } else {
      return formatDateTime(dateTime);
    }
  }

  // Number Extensions
  static String formatBytes(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(2)} KB';
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(2)} GB';
  }

  static String formatDuration(int milliseconds) {
    final seconds = milliseconds ~/ 1000;
    final minutes = seconds ~/ 60;
    final hours = minutes ~/ 60;
    
    if (hours > 0) {
      return '$hours ساعة ${minutes % 60} دقيقة';
    } else if (minutes > 0) {
      return '${minutes % 60} دقيقة';
    } else {
      return '$seconds ثانية';
    }
  }
}
