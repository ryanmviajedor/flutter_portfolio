import 'package:flutter/material.dart';
import '../theme.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late AnimationController _typewriterController;
  late AnimationController _fadeController;
  late Animation<int> _typewriterAnimation;
  late Animation<double> _fadeAnimation;

  final String _fullText = "Hi! I'm Ryan Viajedor";
  String _displayText = "";
  bool _showCursor = true;

  // Personal details matching the original portfolio
  final Map<String, String> _personalDetails = {
    'name': 'Ryan',
    'position': 'Flutter Developer',
    'intro': "Hi! I'm Ryan Viajedor",
    'description':
        "Passionate Flutter Developer with expertise in mobile development. I can bring your app ideas to life with beautiful, high-performance applications. Community Leader & Content Creator passionate about teaching and sharing knowledge.",
    'cvUrl':
        'https://drive.google.com/file/d/1ZcpXka01BQz6Rd1cyQtV9SqcegH5hh3l/view?usp=sharing',
  };

  // Social links
  final List<Map<String, dynamic>> _socialLinks = [
    {
      'icon': Icons.code,
      'url': 'https://github.com/ryanviajedor',
      'label': 'GitHub',
    },
    {
      'icon': Icons.work,
      'url': 'https://www.linkedin.com/in/ryanviajedor/',
      'label': 'LinkedIn',
    },
    {
      'icon': Icons.alternate_email,
      'url': 'https://twitter.com/AbhishekDoshi26',
      'label': 'Twitter',
    },
    {
      'icon': Icons.photo_camera,
      'url': 'https://www.instagram.com/abhishekdoshi26/',
      'label': 'Instagram',
    },
    {
      'icon': Icons.article,
      'url': 'https://abhishekdoshi26.medium.com/',
      'label': 'Medium',
    },
    {
      'icon': Icons.email,
      'url': 'mailto:adoshi26.ad@gmail.com',
      'label': 'Email',
    },
    {
      'icon': Icons.calendar_today,
      'url': 'https://calendly.com/abhishekdoshi26',
      'label': 'Calendly',
    },
  ];

  @override
  void initState() {
    super.initState();

    // Typewriter animation
    _typewriterController = AnimationController(
      duration: const Duration(milliseconds: 3500),
      vsync: this,
    );

    _typewriterAnimation = IntTween(begin: 0, end: _fullText.length).animate(
      CurvedAnimation(parent: _typewriterController, curve: Curves.easeInOut),
    );

    // Fade animation for other elements
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    // Start animations
    _startAnimations();
    _startCursorBlink();
  }

  void _startAnimations() {
    _typewriterController.forward();

    // Start fade animation after a delay
    Future.delayed(const Duration(milliseconds: 1000), () {
      if (mounted) {
        _fadeController.forward();
      }
    });
  }

  void _startCursorBlink() {
    // Cursor blinking effect
    Future.delayed(const Duration(milliseconds: 750), () {
      if (mounted) {
        setState(() {
          _showCursor = !_showCursor;
        });
        _startCursorBlink();
      }
    });
  }

  @override
  void dispose() {
    _typewriterController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isWide = width > 768;

    return Container(
      constraints: const BoxConstraints(minHeight: 600),
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: isWide
              ? Row(
                  children: [
                    Expanded(child: _buildLeftContent()),
                    const SizedBox(width: 60),
                    Expanded(child: _buildRightContent()),
                  ],
                )
              : Column(
                  children: [
                    _buildLeftContent(),
                    const SizedBox(height: 40),
                    _buildRightContent(),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildLeftContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Typewriter effect title
        AnimatedBuilder(
          animation: _typewriterAnimation,
          builder: (context, child) {
            _displayText = _fullText.substring(0, _typewriterAnimation.value);
            return Row(
              children: [
                Flexible(
                  child: GradientText(
                    _displayText,
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),
                ),
                if (_showCursor)
                  Container(width: 3, height: 48, color: AppColors.primary),
              ],
            );
          },
        ),

        const SizedBox(height: 16),

        // Position
        FadeTransition(
          opacity: _fadeAnimation,
          child: Text(
            _personalDetails['position']!,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.foreground,
            ),
          ),
        ),

        const SizedBox(height: 24),

        // Description
        FadeTransition(
          opacity: _fadeAnimation,
          child: Text(
            _personalDetails['description']!,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.mutedForeground,
              height: 1.6,
            ),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
        ),

        const SizedBox(height: 32),

        // Action buttons
        FadeTransition(
          opacity: _fadeAnimation,
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              _buildActionButton(
                'Download CV',
                AppColors.primary,
                AppColors.foreground,
                () => _launchUrl(_personalDetails['cvUrl']!),
              ),
              _buildActionButton(
                'Reach Out To Me',
                Colors.transparent,
                AppColors.foreground,
                () => _scrollToContact(),
                border: true,
              ),
            ],
          ),
        ),

        const SizedBox(height: 32),

        // Social links
        FadeTransition(
          opacity: _fadeAnimation,
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            children: _socialLinks.map((link) {
              return _buildSocialButton(link);
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildRightContent() {
    return Center(
      child: Container(
        width: 320,
        height: 320,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(160),
          border: Border.all(
            color: AppColors.primary.withValues(alpha: 0.3),
            width: 4,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.2),
              blurRadius: 20,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Stack(
          children: [
            // Animated background shapes
            Positioned.fill(
              child: CustomPaint(painter: _AnimatedShapesPainter()),
            ),
            // Profile placeholder or image
            Center(
              child: Container(
                width: 280,
                height: 280,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(140),
                  color: AppColors.card,
                ),
                child: const Icon(
                  Icons.person,
                  size: 120,
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(
    String text,
    Color backgroundColor,
    Color textColor,
    VoidCallback onPressed, {
    bool border = false,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: border
              ? const BorderSide(color: AppColors.primary, width: 2)
              : BorderSide.none,
        ),
        elevation: 0,
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildSocialButton(Map<String, dynamic> link) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _launchUrl(link['url']),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.mutedForeground.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(link['icon'], color: AppColors.mutedForeground, size: 24),
        ),
      ),
    );
  }

  void _launchUrl(String url) {
    // TODO: Implement URL launching
    // For now, just print the URL
    debugPrint('Launching URL: $url');
  }

  void _scrollToContact() {
    // TODO: Implement scroll to contact section
    debugPrint('Scrolling to contact section');
  }
}

// Custom painter for animated background shapes
class _AnimatedShapesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary.withValues(alpha: 0.1)
      ..style = PaintingStyle.fill;

    // Draw some animated shapes
    canvas.drawCircle(Offset(size.width * 0.3, size.height * 0.2), 20, paint);

    canvas.drawCircle(Offset(size.width * 0.7, size.height * 0.8), 15, paint);

    canvas.drawCircle(Offset(size.width * 0.8, size.height * 0.3), 25, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
