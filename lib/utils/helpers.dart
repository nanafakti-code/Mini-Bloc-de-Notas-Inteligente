import 'package:intl/intl.dart';

class DateHelper {
  // Format date for display
  static String formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return DateFormat('HH:mm').format(date);
    } else if (difference.inDays == 1) {
      return 'Ayer';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} días';
    } else {
      return DateFormat('dd/MM/yyyy').format(date);
    }
  }

  // Format full date
  static String formatFullDate(DateTime date) {
    return DateFormat('dd/MM/yyyy HH:mm').format(date);
  }
}

class TextHelper {
  // Truncate text to specified length
  static String truncate(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    }
    return '${text.substring(0, maxLength)}...';
  }

  // Validate if text is not empty
  static bool isNotEmpty(String? text) {
    return text != null && text.trim().isNotEmpty;
  }

  // Get word count
  static int wordCount(String text) {
    return text.trim().split(RegExp(r'\s+')).length;
  }

  // Get character count without spaces
  static int characterCount(String text) {
    return text.replaceAll(RegExp(r'\s+'), '').length;
  }
}

class ValidationHelper {
  // Validate note title
  static String? validateTitle(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'El título no puede estar vacío';
    }
    if (value.trim().length < 3) {
      return 'El título debe tener al menos 3 caracteres';
    }
    if (value.trim().length > 100) {
      return 'El título no puede tener más de 100 caracteres';
    }
    return null;
  }

  // Validate note content
  static String? validateContent(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'El contenido no puede estar vacío';
    }
    if (value.trim().length < 10) {
      return 'El contenido debe tener al menos 10 caracteres';
    }
    return null;
  }
}
