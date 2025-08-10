import 'package:flutter/material.dart';
import '../theme.dart';

class SkillsSection extends StatefulWidget {
  const SkillsSection({super.key});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  // Current selected tab
  int _selectedTabIndex = 0;

  // Hover states for skill cards
  final List<bool> _isSkillCardHovered = List.generate(24, (index) => false);

  // Skills data organized by categories
  final Map<String, List<Map<String, dynamic>>> _skillsData = {
    'Frontend': [
      {
        'name': 'Flutter',
        'description':
            'Cross-platform mobile app development with beautiful UIs',
        'icon': Icons.phone_android,
      },
      {
        'name': 'React',
        'description':
            'Modern web applications with component-based architecture',
        'icon': Icons.web,
      },
      {
        'name': 'Vue.js',
        'description': 'Progressive framework for building user interfaces',
        'icon': Icons.web_asset,
      },
      {
        'name': 'HTML/CSS',
        'description': 'Semantic markup and responsive styling fundamentals',
        'icon': Icons.code,
      },
      {
        'name': 'JavaScript',
        'description': 'Dynamic programming for interactive web experiences',
        'icon': Icons.javascript,
      },
      {
        'name': 'TypeScript',
        'description': 'Type-safe JavaScript for scalable applications',
        'icon': Icons.code,
      },
      {
        'name': 'Sass/SCSS',
        'description': 'Advanced CSS preprocessing for maintainable styles',
        'icon': Icons.style,
      },
      {
        'name': 'Bootstrap',
        'description': 'Responsive framework for rapid UI development',
        'icon': Icons.design_services,
      },
    ],
    'Backend': [
      {
        'name': 'Node.js',
        'description':
            'Server-side JavaScript runtime for scalable applications',
        'icon': Icons.dns,
      },
      {
        'name': 'Python',
        'description': 'Versatile programming language for backend development',
        'icon': Icons.code,
      },
      {
        'name': 'Firebase',
        'description':
            'Cloud platform for real-time databases and authentication',
        'icon': Icons.cloud,
      },
      {
        'name': 'MongoDB',
        'description': 'NoSQL database for flexible document storage',
        'icon': Icons.storage,
      },
      {
        'name': 'PostgreSQL',
        'description': 'Advanced relational database with powerful features',
        'icon': Icons.storage,
      },
      {
        'name': 'Express.js',
        'description': 'Fast web framework for Node.js applications',
        'icon': Icons.api,
      },
      {
        'name': 'REST APIs',
        'description': 'RESTful web services for client-server communication',
        'icon': Icons.api,
      },
      {
        'name': 'GraphQL',
        'description': 'Query language for efficient data fetching',
        'icon': Icons.api,
      },
    ],
    'Tools': [
      {
        'name': 'Git',
        'description': 'Version control system for tracking code changes',
        'icon': Icons.source,
      },
      {
        'name': 'VS Code',
        'description': 'Powerful code editor with extensive extensions',
        'icon': Icons.code,
      },
      {
        'name': 'Android Studio',
        'description': 'Official IDE for Android app development',
        'icon': Icons.android,
      },
      {
        'name': 'Figma',
        'description': 'Collaborative design tool for UI/UX prototyping',
        'icon': Icons.design_services,
      },
      {
        'name': 'Docker',
        'description': 'Containerization platform for application deployment',
        'icon': Icons.developer_board,
      },
      {
        'name': 'AWS',
        'description': 'Cloud computing services for scalable infrastructure',
        'icon': Icons.cloud_queue,
      },
      {
        'name': 'Postman',
        'description': 'API testing and development environment',
        'icon': Icons.api,
      },
      {
        'name': 'Jira',
        'description': 'Project management and issue tracking tool',
        'icon': Icons.task,
      },
    ],
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {
          _selectedTabIndex = _tabController.index;
        });
      }
    });

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
    _tabController.dispose();
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
      key: const Key('skills'),
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
                            'My ',
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: AppColors.foreground,
                            ),
                          ),
                          GradientText(
                            'Skills',
                            style: const TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Technologies and tools I work with',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.mutedForeground,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 48),
                    ],
                  ),
                ),
              ),

              // Tab bar
              FadeTransition(
                opacity: _fadeAnimation,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: isWide ? 0 : 8),
                  decoration: BoxDecoration(
                    color: AppColors.muted,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TabBar(
                    controller: _tabController,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      gradient: const LinearGradient(
                        colors: AppColors.primaryGradient,
                      ),
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: Colors.transparent,
                    labelColor: AppColors.foreground,
                    unselectedLabelColor: AppColors.mutedForeground,
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: isWide ? 16 : 14,
                    ),
                    unselectedLabelStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: isWide ? 16 : 14,
                    ),
                    tabs: const [
                      Tab(text: 'Frontend'),
                      Tab(text: 'Backend'),
                      Tab(text: 'Tools'),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Tab content
              FadeTransition(
                opacity: _fadeAnimation,
                child: SizedBox(
                  height: _getTabContentHeight(width),
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildSkillsGrid('Frontend'),
                      _buildSkillsGrid('Backend'),
                      _buildSkillsGrid('Tools'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double _getTabContentHeight(double width) {
    if (width <= 600) {
      return 480; // Mobile: single column, compact height
    } else if (width <= 900) {
      return 380; // Tablet: 2 columns
    } else if (width <= 1200) {
      return 320; // Desktop small: 3 columns
    } else {
      return 280; // Desktop large: 4 columns, more compact
    }
  }

  Widget _buildSkillsGrid(String category) {
    final skills = _skillsData[category] ?? [];
    final width = MediaQuery.of(context).size.width;

    // More responsive breakpoints with better aspect ratios
    int crossAxisCount;
    double childAspectRatio;

    if (width > 1200) {
      crossAxisCount = 4;
      childAspectRatio = 1.1; // More compact cards
    } else if (width > 900) {
      crossAxisCount = 3;
      childAspectRatio = 1.0;
    } else if (width > 600) {
      crossAxisCount = 2;
      childAspectRatio = 1.2;
    } else {
      crossAxisCount = 1; // Single column on mobile
      childAspectRatio = 3.5; // Much wider, less tall on mobile
    }

    return GridView.builder(
      padding: EdgeInsets.all(width > 600 ? 16 : 8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: width > 600 ? 16 : 8,
        mainAxisSpacing: width > 600 ? 16 : 8,
        childAspectRatio: childAspectRatio,
      ),
      itemCount: skills.length,
      itemBuilder: (context, index) {
        final skill = skills[index];
        final globalIndex =
            _selectedTabIndex * 8 + index; // Calculate global index
        return _buildSkillCard(skill, globalIndex);
      },
    );
  }

  Widget _buildSkillCard(Map<String, dynamic> skill, int index) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width <= 600;

    return MouseRegion(
      onEnter: (_) => setState(() => _isSkillCardHovered[index] = true),
      onExit: (_) => setState(() => _isSkillCardHovered[index] = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.all(isMobile ? 12 : 16),
        transform: _isSkillCardHovered[index]
            ? Matrix4.translationValues(0, -8, 0)
            : Matrix4.identity(),
        decoration: BoxDecoration(
          color: AppColors.muted,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 
                _isSkillCardHovered[index] ? 0.2 : 0.1,
              ),
              blurRadius: _isSkillCardHovered[index] ? 20 : 10,
              offset: Offset(0, _isSkillCardHovered[index] ? 8 : 4),
            ),
          ],
        ),
        child: isMobile
            ? _buildMobileSkillLayout(skill)
            : _buildDesktopSkillLayout(skill),
      ),
    );
  }

  Widget _buildDesktopSkillLayout(Map<String, dynamic> skill) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Skill icon
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(skill['icon'], color: AppColors.primary, size: 24),
        ),
        const SizedBox(height: 8),

        // Skill name
        Text(
          skill['name'],
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.foreground,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 6),

        // Skill description
        Expanded(
          child: Text(
            skill['description'],
            style: const TextStyle(
              fontSize: 11,
              color: AppColors.mutedForeground,
              height: 1.3,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildMobileSkillLayout(Map<String, dynamic> skill) {
    return Row(
      children: [
        // Skill icon
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(skill['icon'], color: AppColors.primary, size: 20),
        ),
        const SizedBox(width: 12),

        // Skill info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Skill name
              Text(
                skill['name'],
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.foreground,
                ),
              ),
              const SizedBox(height: 2),

              // Skill description
              Text(
                skill['description'],
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.mutedForeground,
                  height: 1.2,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
