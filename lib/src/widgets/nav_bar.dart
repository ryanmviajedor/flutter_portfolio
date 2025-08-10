import 'package:flutter/material.dart';
import '../theme.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  bool _isMenuOpen = false;
  String _activeSection = 'home';
  bool _isScrolled = false;

  final List<Map<String, String>> _navItems = [
    {'name': 'Home', 'path': 'home'},
    {'name': 'About', 'path': 'about'},
    {'name': 'Testimonials', 'path': 'testimonials'},
    {'name': 'Packages', 'path': 'packages'},
    {'name': 'Blog', 'path': 'blog'},
    {'name': 'Contact', 'path': 'contact'},
  ];

  @override
  void initState() {
    super.initState();
    // Listen to scroll events to update header background
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        // Add scroll listener here if needed
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 768;

    return Container(
      decoration: BoxDecoration(
        color: _isScrolled
            ? AppColors.background.withValues(alpha: 0.9)
            : AppColors.background.withValues(alpha: 0.8),
        boxShadow: _isScrolled
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1200),
        margin: const EdgeInsets.symmetric(horizontal: 24),
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Logo/Brand
            GestureDetector(
              onTap: () => _scrollToSection('home'),
              child: const Text(
                'Ryan',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.foreground,
                ),
              ),
            ),

            // Desktop Navigation
            if (isWide)
              Row(
                children: _navItems.map((item) {
                  final isActive = _activeSection == item['path'];
                  return _NavButton(
                    label: item['name']!,
                    path: item['path']!,
                    isActive: isActive,
                    onTap: () => _scrollToSection(item['path']!),
                  );
                }).toList(),
              )
            else
              // Mobile Menu Button
              IconButton(
                icon: Icon(
                  _isMenuOpen ? Icons.close : Icons.menu,
                  color: AppColors.foreground,
                ),
                onPressed: () {
                  setState(() {
                    _isMenuOpen = !_isMenuOpen;
                  });
                },
              ),
          ],
        ),
      ),
    );
  }

  void _scrollToSection(String section) {
    setState(() {
      _activeSection = section;
      _isMenuOpen = false;
    });

    // TODO: Implement actual scrolling to section
    // This would typically use a ScrollController or GlobalKeys
  }
}

class _NavButton extends StatefulWidget {
  final String label;
  final String path;
  final bool isActive;
  final VoidCallback onTap;

  const _NavButton({
    required this.label,
    required this.path,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_NavButton> createState() => _NavButtonState();
}

class _NavButtonState extends State<_NavButton>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _animationController;
  late Animation<double> _underlineAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _underlineAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    if (widget.isActive) {
      _animationController.forward();
    }
  }

  @override
  void didUpdateWidget(_NavButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive != oldWidget.isActive) {
      if (widget.isActive) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: TextStyle(
                  color: _isHovered || widget.isActive
                      ? AppColors.primary
                      : AppColors.foreground,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              AnimatedBuilder(
                animation: _underlineAnimation,
                builder: (context, child) {
                  return Container(
                    height: 2,
                    width: 40 * _underlineAnimation.value,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.all(Radius.circular(1)),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
