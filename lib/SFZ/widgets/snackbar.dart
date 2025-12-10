import 'package:flutter/material.dart';

enum SnackbarType { success, error, info }

class CustomSnackbar {
  static SnackBar show(String message, SnackbarType type) {
    late Color gradientStart;
    late Color gradientEnd;
    late Color titleColor;
    late IconData icon;
    late String title;

    switch (type) {
      case SnackbarType.success:
        gradientStart = const Color(0xFF8b5cf6);
        gradientEnd = const Color(0xFF6d28d9);
        titleColor = gradientStart;
        icon = Icons.check_circle_outline;
        title = "Success";
        break;
      case SnackbarType.error:
        gradientStart = const Color(0xFFef4444);
        gradientEnd = const Color(0xFFdc2626);
        titleColor = gradientStart;
        icon = Icons.error_outline;
        title = "Error";
        break;
      case SnackbarType.info:
        gradientStart = const Color(0xFF3b82f6);
        gradientEnd = const Color(0xFF2563eb);
        titleColor = gradientStart;
        icon = Icons.info_outline;
        title = "Info";
        break;
    }

    return SnackBar(
      content: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [gradientStart, gradientEnd],
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: gradientStart.withOpacity(0.4),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 22,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: titleColor,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    message,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: const Color(0xFF0a0015),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: titleColor.withOpacity(0.5),
          width: 1.5,
        ),
      ),
      margin: const EdgeInsets.all(20),
      duration: const Duration(seconds: 3),
      elevation: 0,
    );
  }
}
