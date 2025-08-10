import 'package:flutter/material.dart';
import '../theme.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  // Navigation links
  final List<Map<String, String>> _navLinks = const [
    {'name': 'Home', 'path': 'home'},
    {'name': 'About', 'path': 'about'},
    {'name': 'Testimonials', 'path': 'testimonials'},
    {'name': 'Packages', 'path': 'packages'},
    {'name': 'Blog', 'path': 'blog'},
    {'name': 'Contact', 'path': 'contact'},
  ];

  // Social links
  final List<Map<String, dynamic>> _socialLinks = const [
    {'icon': Icons.code, 'url': 'https://github.com/ryanviajedor'},
    {'icon': Icons.work, 'url': 'https://www.linkedin.com/in/ryanviajedor/'},
    {'icon': Icons.alternate_email, 'url': 'https://twitter.com/ryanviajedor'},
    {
      'icon': Icons.photo_camera,
      'url': 'https://www.instagram.com/ryanviajedor/',
    },
    {'icon': Icons.article, 'url': 'https://medium.com/@ryanviajedor'},
    {'icon': Icons.email, 'url': 'mailto:ryan.viajedor@gmail.com'},
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isWide = width > 768;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.muted,
        border: Border(
          top: BorderSide(color: AppColors.primary.withOpacity(0.2), width: 1),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              // Main footer content
              isWide
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildBrandSection(),
                        _buildNavigationSection(),
                        _buildSocialSection(),
                      ],
                    )
                  : Column(
                      children: [
                        _buildBrandSection(),
                        const SizedBox(height: 32),
                        _buildNavigationSection(),
                        const SizedBox(height: 32),
                        _buildSocialSection(),
                      ],
                    ),

              const SizedBox(height: 32),

              // Copyright section
              Container(
                padding: const EdgeInsets.only(top: 24),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: AppColors.primary.withOpacity(0.1),
                      width: 1,
                    ),
                  ),
                ),
                child: Text(
                  '© ${DateTime.now().year} Ryan Viajedor. All Rights Reserved.',
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.mutedForeground,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBrandSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GradientText(
          'Ryan',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'Flutter Developer passionate about mobile development',
          style: TextStyle(fontSize: 14, color: AppColors.mutedForeground),
        ),
      ],
    );
  }

  Widget _buildNavigationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 24,
          runSpacing: 8,
          children: _navLinks.map((link) {
            return MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => _scrollToSection(link['path']!),
                child: Text(
                  link['name']!,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.mutedForeground,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSocialSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 16,
          runSpacing: 8,
          children: _socialLinks.map((link) {
            return MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => _launchUrl(link['url']),
                child: Icon(
                  link['icon'],
                  color: AppColors.mutedForeground,
                  size: 20,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  void _scrollToSection(String section) {
    // TODO: Implement scroll to section
    debugPrint('Scrolling to section: $section');
  }

  void _launchUrl(String url) {
    // TODO: Implement URL launching
    debugPrint('Launching URL: $url');
  }
}
