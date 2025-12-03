import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'hero_section.dart';

Widget buildNavigationBar(BuildContext context, bool isScrolled) {
  final bool isDesktop = MediaQuery.of(context).size.width > 768;

  return Positioned(
    top: 0,
    left: 0,
    right: 0,
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: isScrolled ? Colors.black.withOpacity(0.95) : Colors.transparent,
        border: isScrolled
            ? Border(
          bottom: BorderSide(
            color: const Color(0xFF8b5cf6).withOpacity(0.5),
          ),
        )
            : null,
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            children: [
              const Icon(Icons.terminal, color: Color(0xFF8b5cf6)),
              const SizedBox(width: 8),
              const Text(
                '<SFZ/>',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const Spacer(),

              // Desktop Navigation
              if (isDesktop)
                Row(
                  children: [
                    _navItem('01.', 'Home'),
                    _navItem('02.', 'About'),
                    _navItem('03.', 'Skills'),
                    _navItem('04.', 'Projects'),
                    _navItem('05.', 'Contact'),
                  ],
                ),

              // Mobile Drawer Icon with Animation
              if (!isDesktop)
                Builder(
                  builder: (context) => _AnimatedMenuButton(
                    onPressed: () {
                      Scaffold.of(context).openEndDrawer();
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    ),
  );
}

// Animated Menu Button
class _AnimatedMenuButton extends StatefulWidget {
  final VoidCallback onPressed;

  const _AnimatedMenuButton({required this.onPressed});

  @override
  State<_AnimatedMenuButton> createState() => _AnimatedMenuButtonState();
}

class _AnimatedMenuButtonState extends State<_AnimatedMenuButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _controller.forward().then((_) => _controller.reverse());
        widget.onPressed();
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFF8b5cf6).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFF8b5cf6)
                    .withOpacity(0.3 + (_controller.value * 0.4)),
                width: 1,
              ),
            ),
            child: Transform.rotate(
              angle: _controller.value * 0.5,
              child: const Icon(
                Icons.menu_rounded,
                color: Color(0xFF8b5cf6),
                size: 24,
              ),
            ),
          );
        },
      ),
    );
  }
}

// Stylish Compact Drawer with Slide Animation
 //Drawer buildMobileDrawer(BuildContext context,GlobalKey aboutSectionKey,)
Drawer buildMobileDrawer(
    BuildContext context,
    Function(GlobalKey) scrollToSection,
    GlobalKey aboutSectionKey,
    GlobalKey contactSectionKey,
    )

{
  return Drawer(
    width: 280,
    backgroundColor: Colors.transparent,
    elevation: 0,
    child: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            const Color(0xFF1e002a).withOpacity(0.98),
            const Color(0xFF0a0015).withOpacity(0.98),
            Colors.black.withOpacity(0.98),
          ],
        ),
        border: Border(
          left: BorderSide(
            color: const Color(0xFF8b5cf6).withOpacity(0.5),
            width: 2,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF8b5cf6).withOpacity(0.2),
            blurRadius: 30,
            offset: const Offset(-10, 0),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Close Button
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF8b5cf6).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: const Color(0xFF8b5cf6).withOpacity(0.3),
                        ),
                      ),
                      child: const Icon(
                        Icons.close_rounded,
                        color: Color(0xFF8b5cf6),
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Menu Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'MENU',
                    style: TextStyle(
                      color: const Color(0xFF8b5cf6).withOpacity(0.6),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: 40,
                    height: 2,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF8b5cf6),
                          const Color(0xFF8b5cf6).withOpacity(0),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Navigation Items
            InkWell(
                child: _drawerItem(context, "01", "Home", Icons.home_outlined, 0),
              onTap: (){

              },
            ),
            InkWell(
                child: _drawerItem(context, "02", "About", Icons.person_outline, 50),
              onTap: () {
                Navigator.pop(context);
                Future.delayed(const Duration(milliseconds: 250), () {
                  scrollToSection(aboutSectionKey);   // scroll after closing
                });
              },

            ),
            _drawerItem(context, "03", "Skills", Icons.code_outlined, 100),
            _drawerItem(context, "04", "Projects", Icons.folder_outlined, 150),
            _drawerItem(context, "05", "Contact", Icons.mail_outline, 200),

            const Spacer(),

            // Footer
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 1,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF8b5cf6).withOpacity(0.5),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      _socialIcon(FontAwesomeIcons.github),
                      const SizedBox(width: 12),
                      _socialIcon(Icons.language),
                      const SizedBox(width: 12),
                      _socialIcon(Icons.mail_outline),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _drawerItem(
    BuildContext context, String number, String text, IconData icon, int delay) {
  return TweenAnimationBuilder<double>(
    tween: Tween(begin: 0.0, end: 1.0),
    duration: Duration(milliseconds: 400 + delay),
    curve: Curves.easeOutCubic,
    builder: (context, value, child) {
      return Transform.translate(
        offset: Offset(50 * (1 - value), 0),
        child: Opacity(
          opacity: value,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                borderRadius: BorderRadius.circular(12),
                splashColor: const Color(0xFF8b5cf6).withOpacity(0.2),
                highlightColor: const Color(0xFF8b5cf6).withOpacity(0.1),
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Row(
                    children: [
                      Text(
                        number,
                        style: const TextStyle(
                          color: Color(0xFF8b5cf6),
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Icon(
                        icon,
                        color: Colors.white.withOpacity(0.8),
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        text,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: const Color(0xFF8b5cf6).withOpacity(0.4),
                        size: 14,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}

Widget _socialIcon(IconData icon) {
  return Container(
    width: 40,
    height: 40,
    decoration: BoxDecoration(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: const Color(0xFF8b5cf6).withOpacity(0.3),
      ),
    ),
    child: Icon(
      icon,
      color: const Color(0xFF8b5cf6).withOpacity(0.7),
      size: 18,
    ),
  );
}

Widget _navItem(String number, String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12),
    child: InkWell(
      onTap: () {},
      child: Row(
        children: [
          Text(
            number,
            style: const TextStyle(
              color: Color(0xFF8b5cf6),
              fontSize: 12,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            text,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
        ],
      ),
    ),
  );
}