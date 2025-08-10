import 'package:flutter/material.dart';
import '../theme.dart';

class AboutSection extends StatefulWidget {
  const AboutSection({super.key});

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  // Hover states
  bool _isLeftCardHovered = false;
  bool _isRightCardHovered = false;
  final List<bool> _isStatCardHovered = [false, false, false];
  final List<bool> _isServiceCardHovered = [false, false, false, false];

  // Personal details matching the original portfolio
  final String _aboutText =
      "Flutter Developer specializing in creating beautiful, high-performance mobile and web applications with Flutter. With extensive experience, I transform your vision into reality and give your app a soul that resonates with users. Let's collaborate and bring your ideas to life with cutting-edge technology.";

  // Experience timeline
  final List<Map<String, String>> _experiences = [
    {
      'title': 'Senior Flutter Developer',
      'company': 'Freelance & Consulting',
      'period': '2022 - Present',
      'description':
          'Working with clients globally to develop high-performance Flutter applications. Specializing in complex app architecture, state management solutions, and cross-platform development. Delivered multiple successful projects with exceptional client satisfaction.',
    },
    {
      'title': 'Flutter Developer',
      'company': 'Tech Companies',
      'period': '2020 - 2022',
      'description':
          'Developed applications across diverse domains including e-commerce, healthcare, education, and fintech. Built a strong foundation in mobile app development and contributed to open source Flutter packages.',
    },
    {
      'title': 'Mobile App Developer',
      'company': 'Various Projects',
      'period': '2019 - 2020',
      'description':
          'Started my journey with mobile development. Gained experience in creating user-friendly applications and learned the fundamentals of cross-platform development with Flutter.',
    },
  ];

  // Stats
  final List<Map<String, String>> _stats = [
    {'number': '8', 'label': 'Happy Clients'},
    {'number': '3', 'label': 'Years of Experience'},
    {'number': '15', 'label': 'Completed Projects'},
  ];

  // Services
  final List<Map<String, dynamic>> _services = [
    {
      'title': 'Flutter Development',
      'icon': Icons.code,
      'description':
          'Expert Flutter development for mobile, web, and desktop applications with clean architecture and robust state management.',
    },
    {
      'title': 'Firebase Integration',
      'icon': Icons.cloud,
      'description':
          'Seamless integration of Firebase services including Authentication, Firestore, Cloud Functions, and Analytics for scalable backends.',
    },
    {
      'title': 'App Optimization',
      'icon': Icons.mobile_friendly,
      'description':
          'Performance optimization for Flutter apps, ensuring smooth animations, reduced build size, and efficient resource usage.',
    },
    {
      'title': 'Technical Consultation',
      'icon': Icons.people,
      'description':
          'Strategic guidance on app architecture, technology choices, and development workflows for teams adopting Flutter.',
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
    {'icon': Icons.article, 'url': 'https://medium.com/@ryanviajedor'},
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
      key: const Key('about'),
      color: AppColors.muted,
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
                            'About ',
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: AppColors.foreground,
                            ),
                          ),
                          GradientText(
                            'Me',
                            style: const TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 48),
                    ],
                  ),
                ),
              ),

              // Main content
              isWide
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _buildLeftContent()),
                        const SizedBox(width: 32),
                        Expanded(child: _buildRightContent()),
                      ],
                    )
                  : Column(
                      children: [
                        _buildLeftContent(),
                        const SizedBox(height: 32),
                        _buildRightContent(),
                      ],
                    ),

              const SizedBox(height: 64),

              // Stats section
              _buildStatsSection(),

              const SizedBox(height: 64),

              // Services section
              _buildServicesSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLeftContent() {
    return MouseRegion(
      onEnter: (_) => setState(() => _isLeftCardHovered = true),
      onExit: (_) => setState(() => _isLeftCardHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(24),
        transform: _isLeftCardHovered
            ? Matrix4.translationValues(0, -8, 0)
            : Matrix4.identity(),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(_isLeftCardHovered ? 0.2 : 0.1),
              blurRadius: _isLeftCardHovered ? 20 : 10,
              offset: Offset(0, _isLeftCardHovered ? 8 : 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Who am I section
            Row(
              children: [
                Icon(Icons.book, color: AppColors.primary, size: 24),
                const SizedBox(width: 8),
                const Text(
                  'Who am I?',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.foreground,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // About text
            Text(
              _aboutText,
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.mutedForeground,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 16),

            // Call to action
            RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: 'Have an app idea? ',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.foreground,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text:
                        "Let's transform it into reality with Flutter's power and flexibility!",
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.mutedForeground,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Social links
            const Text(
              'Connect with me on social media:',
              style: TextStyle(fontSize: 16, color: AppColors.mutedForeground),
            ),
            const SizedBox(height: 12),

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
            ),
            const SizedBox(height: 32),

            // Let's Talk button
            ElevatedButton(
              onPressed: () => _scrollToContact(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.foreground,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              child: const Text(
                "Let's Talk",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRightContent() {
    return MouseRegion(
      onEnter: (_) => setState(() => _isRightCardHovered = true),
      onExit: (_) => setState(() => _isRightCardHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(24),
        transform: _isRightCardHovered
            ? Matrix4.translationValues(0, -8, 0)
            : Matrix4.identity(),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(_isRightCardHovered ? 0.2 : 0.1),
              blurRadius: _isRightCardHovered ? 20 : 10,
              offset: Offset(0, _isRightCardHovered ? 8 : 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'My Journey',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.foreground,
              ),
            ),
            const SizedBox(height: 24),

            // Experience timeline
            Column(
              children: _experiences.asMap().entries.map((entry) {
                final index = entry.key;
                final exp = entry.value;
                final isLast = index == _experiences.length - 1;

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Timeline indicator
                    Column(
                      children: [
                        Container(
                          width: 16,
                          height: 16,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                        if (!isLast)
                          Container(
                            width: 2,
                            height: 60,
                            color: AppColors.primary.withOpacity(0.3),
                          ),
                      ],
                    ),
                    const SizedBox(width: 16),

                    // Experience content
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            exp['title']!,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppColors.foreground,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${exp['company']} | ${exp['period']}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.primary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            exp['description']!,
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.mutedForeground,
                              height: 1.5,
                            ),
                          ),
                          if (!isLast) const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: _stats.asMap().entries.map((entry) {
        final index = entry.key;
        final stat = entry.value;
        return Expanded(
          child: MouseRegion(
            onEnter: (_) => setState(() => _isStatCardHovered[index] = true),
            onExit: (_) => setState(() => _isStatCardHovered[index] = false),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.all(24),
              transform: _isStatCardHovered[index]
                  ? Matrix4.translationValues(0, -8, 0)
                  : Matrix4.identity(),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(
                      _isStatCardHovered[index] ? 0.2 : 0.1,
                    ),
                    blurRadius: _isStatCardHovered[index] ? 20 : 10,
                    offset: Offset(0, _isStatCardHovered[index] ? 8 : 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  GradientText(
                    '${stat['number']}+',
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    stat['label']!,
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppColors.mutedForeground,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildServicesSection() {
    return Column(
      children: [
        // Services title
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Services I ',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: AppColors.foreground,
              ),
            ),
            GradientText(
              'Offer',
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 32),

        // Services grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.of(context).size.width > 768 ? 4 : 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.8,
          ),
          itemCount: _services.length,
          itemBuilder: (context, index) {
            final service = _services[index];
            return MouseRegion(
              onEnter: (_) =>
                  setState(() => _isServiceCardHovered[index] = true),
              onExit: (_) =>
                  setState(() => _isServiceCardHovered[index] = false),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.all(24),
                transform: _isServiceCardHovered[index]
                    ? Matrix4.translationValues(0, -8, 0)
                    : Matrix4.identity(),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(
                        _isServiceCardHovered[index] ? 0.2 : 0.1,
                      ),
                      blurRadius: _isServiceCardHovered[index] ? 20 : 10,
                      offset: Offset(0, _isServiceCardHovered[index] ? 8 : 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(service['icon'], color: AppColors.primary, size: 48),
                    const SizedBox(height: 16),
                    Text(
                      service['title'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.foreground,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      service['description'],
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.mutedForeground,
                        height: 1.4,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  void _launchUrl(String url) {
    // TODO: Implement URL launching
    debugPrint('Launching URL: $url');
  }

  void _scrollToContact() {
    // TODO: Implement scroll to contact section
    debugPrint('Scrolling to contact section');
  }
}
