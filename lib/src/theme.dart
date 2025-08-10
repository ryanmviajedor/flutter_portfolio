import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Color scheme matching the original portfolio
class AppColors {
  static const Color background = Color(0xFF121212); // Dark background
  static const Color foreground = Color(0xFFFFFFFF); // White text
  static const Color card = Color(0xFF1A1A1A); // Card background
  static const Color primary = Color(0xFF667eea); // Primary purple-blue
  static const Color secondary = Color(0xFF764ba2); // Secondary purple
  static const Color muted = Color(0xFF374151); // Muted gray
  static const Color mutedForeground = Color(0xFF9CA3AF); // Muted text
  static const Color border = Color(0xFF374151); // Border color
  static const Color accent = Color(0xFF10B981); // Accent color

  // Gradient colors for text effects - Updated to user's preference
  static const List<Color> primaryGradient = [
    Color(0xFF667eea), // Purple-blue
    Color(0xFF764ba2), // Purple
  ];
}

// Gradient text widget
class GradientText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final List<Color> colors;

  const GradientText(
    this.text, {
    super.key,
    this.style,
    this.colors = AppColors.primaryGradient,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => LinearGradient(
        colors: colors,
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
      child: Text(text, style: style),
    );
  }
}

ThemeData buildAppTheme() {
  final base = ThemeData.dark();
  return base.copyWith(
    textTheme: GoogleFonts.interTextTheme().apply(
      bodyColor: AppColors.foreground,
      displayColor: AppColors.foreground,
    ),
    scaffoldBackgroundColor: AppColors.background,
    primaryColor: AppColors.primary,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: AppColors.card,
      onPrimary: AppColors.foreground,
      onSecondary: AppColors.foreground,
      onSurface: AppColors.foreground,
    ),
    cardTheme: const CardThemeData(color: AppColors.card, elevation: 0),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      foregroundColor: AppColors.foreground,
    ),
  );
}
