import 'package:flutter/material.dart';
import '../theme.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  // Hover state
  bool _isContactCardHovered = false;

  // Personal details
  final String _cvUrl =
      'https://drive.google.com/file/d/1ZcpXka01BQz6Rd1cyQtV9SqcegH5hh3l/view?usp=sharing';

  // Contact information
  final List<Map<String, dynamic>> _contactInfo = [
    {
      'icon': Icons.location_on,
      'title': 'Location',
      'content': 'India',
      'isClickable': false,
    },
    {
      'icon': Icons.email,
      'title': 'Email',
      'content': 'ryan.viajedor@gmail.com',
      'isClickable': true,
      'action': 'mailto:ryan.viajedor@gmail.com',
    },
    {
      'icon': Icons.share,
      'title': 'Social Profiles',
      'content': 'Follow me',
      'isClickable': false,
    },
  ];

  // Social links
  final List<Map<String, dynamic>> _socialLinks = [
    {'icon': Icons.code, 'url': 'https://github.com/ryanviajedor'},
    {'icon': Icons.work, 'url': 'https://www.linkedin.com/in/ryanviajedor/'},
    {'icon': Icons.alternate_email, 'url': 'https://twitter.com/ryanviajedor'},
    {
      'icon': Icons.photo_camera,
      'url': 'https://www.instagram.com/ryanviajedor/',
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutCubic,
          ),
        );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isWide = width > 768;

    // Start animation when widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _animationController.forward();
      }
    });

    return Container(
      key: const Key('contact'),
      color: AppColors.background,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              // Section title
              FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Get In ',
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: AppColors.foreground,
                            ),
                          ),
                          GradientText(
                            'Touch',
                            style: const TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        "Whether you have a question or just want to say hi, I'll do my best to get back to you!",
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.mutedForeground,
                          height: 1.6,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 48),
                    ],
                  ),
                ),
              ),

              // Contact information card
              FadeTransition(
                opacity: _fadeAnimation,
                child: MouseRegion(
                  onEnter: (_) => setState(() => _isContactCardHovered = true),
                  onExit: (_) => setState(() => _isContactCardHovered = false),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: isWide
                        ? MediaQuery.of(context).size.width * 0.67
                        : double.infinity,
                    padding: const EdgeInsets.all(24),
                    transform: _isContactCardHovered
                        ? Matrix4.translationValues(0, -8, 0)
                        : Matrix4.identity(),
                    decoration: BoxDecoration(
                      color: AppColors.muted,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 
                            _isContactCardHovered ? 0.2 : 0.1,
                          ),
                          blurRadius: _isContactCardHovered ? 20 : 10,
                          offset: Offset(0, _isContactCardHovered ? 8 : 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Contact Information',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.foreground,
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Contact info items
                        isWide
                            ? Row(
                                children: _contactInfo.asMap().entries.map((
                                  entry,
                                ) {
                                  final index = entry.key;
                                  final info = entry.value;
                                  return Expanded(
                                    child: _buildContactItem(info, index),
                                  );
                                }).toList(),
                              )
                            : Column(
                                children: _contactInfo.asMap().entries.map((
                                  entry,
                                ) {
                                  final index = entry.key;
                                  final info = entry.value;
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 24),
                                    child: _buildContactItem(info, index),
                                  );
                                }).toList(),
                              ),

                        const SizedBox(height: 32),

                        // Download Resume button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => _launchUrl(_cvUrl),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              foregroundColor: AppColors.primary,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: const BorderSide(
                                  color: AppColors.primary,
                                  width: 2,
                                ),
                              ),
                              elevation: 0,
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Download Resume',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Icon(Icons.download, size: 20),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactItem(Map<String, dynamic> info, int index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Icon container
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(info['icon'], color: AppColors.primary, size: 20),
        ),
        const SizedBox(width: 16),

        // Content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                info['title'],
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.foreground,
                ),
              ),
              const SizedBox(height: 4),

              if (info['title'] == 'Social Profiles')
                // Social links
                Row(
                  children: _socialLinks.map((link) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () => _launchUrl(link['url']),
                          child: Icon(
                            link['icon'],
                            color: AppColors.mutedForeground,
                            size: 20,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                )
              else if (info['isClickable'])
                // Clickable content (email)
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () => _launchUrl(info['action']),
                    child: Text(
                      info['content'],
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.mutedForeground,
                      ),
                    ),
                  ),
                )
              else
                // Regular content
                Text(
                  info['content'],
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.mutedForeground,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  void _launchUrl(String url) {
    // TODO: Implement URL launching
    debugPrint('Launching URL: $url');
  }
}
