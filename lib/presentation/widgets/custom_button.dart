import 'package:flutter/material.dart';

class FeatureCard extends StatelessWidget {
  final String title;
  final IconData? icon;
  final IconData? trailIcon;
  final VoidCallback onTap;
  final Color color;

  const FeatureCard({
    super.key,
    required this.title,
    this.icon,
    this.trailIcon,
    required this.onTap,
    this.color = const Color(0xFF2E323F), // Dark background
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
        ),
        child: Row(
          children: [
            if (icon != null)
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Icon(icon, color: const Color(0xFFF9C300), size: 30),
              ),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            if (trailIcon != null)
              Icon(trailIcon, color: const Color(0xFFF9C300), size: 24),
          ],
        ),
      ),
    );
  }
}

class StatusOverlay extends StatelessWidget {
  final String message;
  final bool isSuccess;

  const StatusOverlay({
    super.key,
    required this.message,
    required this.isSuccess,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSuccess
            ? const Color(0xFF4CAF50).withOpacity(0.9)
            : const Color(0xFFFF9800).withOpacity(0.9),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
