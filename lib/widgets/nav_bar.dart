import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';
import 'common_widgets.dart';

class PortfolioNav extends StatefulWidget implements PreferredSizeWidget {
  final bool isDark;
  final VoidCallback onToggleTheme;
  final Function(String) onNav;
  final double scrollProgress;

  const PortfolioNav({
    super.key,
    required this.isDark,
    required this.onToggleTheme,
    required this.onNav,
    required this.scrollProgress,
  });

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  State<PortfolioNav> createState() => _PortfolioNavState();
}

class _PortfolioNavState extends State<PortfolioNav> {
  final List<String> _links = [
    'About',
    'Specialization',
    'Skills',
    'Experience',
    'Projects',
    'Architecture',
    'Contact',
  ];

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 960;
    final isDark = widget.isDark;

    return Container(
      decoration: BoxDecoration(
        color: AppTheme.bg(isDark),
        border: Border(
          bottom: BorderSide(color: AppTheme.line(isDark)),
        ),
      ),
      child: Stack(
        children: [
          // Scroll Progress Bar
          Positioned(
            bottom: 0,
            left: 0,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 50),
              width: MediaQuery.of(context).size.width * widget.scrollProgress,
              height: 2.5,
              color: AppTheme.acc(isDark),
            ),
          ),
          SafeArea(
            child: SizedBox(
              height: 60,
              child: MaxContentContainer(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: [
                      // Brand Logo
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () => widget.onNav('hero'),
                          child: RichText(
                            text: TextSpan(
                              style: GoogleFonts.bebasNeue(
                                fontSize: 24,
                                letterSpacing: 1.5,
                                color: AppTheme.ink(isDark),
                              ),
                              children: [
                                const TextSpan(text: 'FAIREENA'),
                                TextSpan(
                                  text: '.',
                                  style: TextStyle(color: AppTheme.acc(isDark)),
                                ),
                                TextSpan(
                                  text: 'DEV',
                                  style: TextStyle(
                                    color: AppTheme.acc(isDark),
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),

                      // Desktop Navigation Links
                      if (isWide) ...[
                        ..._links.map(
                          (l) => _NavLink(
                            label: l,
                            isDark: isDark,
                            onTap: () => widget.onNav(l.toLowerCase()),
                          ),
                        ),
                        const SizedBox(width: 16),
                      ],

                      // Theme Mode Toggle Button
                      _ModeBtn(
                        isDark: isDark,
                        onTap: widget.onToggleTheme,
                      ),
                      const SizedBox(width: 8),

                      // Resume CTA Button in Nav
                      _ResumeNavBtn(isDark: isDark),

                      // Mobile Drawer Hamburger
                      if (!isWide) ...[
                        const SizedBox(width: 8),
                        _HamburgerBtn(
                          isDark: isDark,
                          links: _links,
                          onNav: widget.onNav,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavLink extends StatefulWidget {
  final String label;
  final bool isDark;
  final VoidCallback onTap;
  const _NavLink({
    required this.label,
    required this.isDark,
    required this.onTap,
  });

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label.toUpperCase(),
                style: GoogleFonts.epilogue(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                  color: _hover
                      ? AppTheme.ink(widget.isDark)
                      : AppTheme.ink3(widget.isDark),
                ),
              ),
              const SizedBox(height: 2),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: _hover ? 20 : 0,
                height: 1.5,
                color: AppTheme.acc(widget.isDark),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ModeBtn extends StatefulWidget {
  final bool isDark;
  final VoidCallback onTap;
  const _ModeBtn({required this.isDark, required this.onTap});

  @override
  State<_ModeBtn> createState() => _ModeBtnState();
}

class _ModeBtnState extends State<_ModeBtn> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            border: Border.all(
              color: _hover
                  ? AppTheme.acc(widget.isDark)
                  : AppTheme.lineStrong(widget.isDark),
              width: 1.2,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            children: [
              Icon(
                widget.isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
                size: 14,
                color: AppTheme.acc(widget.isDark),
              ),
              const SizedBox(width: 4),
              Text(
                widget.isDark ? 'LIGHT' : 'DARK',
                style: GoogleFonts.epilogue(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                  color: _hover
                      ? AppTheme.acc(widget.isDark)
                      : AppTheme.ink3(widget.isDark),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ResumeNavBtn extends StatefulWidget {
  final bool isDark;
  const _ResumeNavBtn({required this.isDark});

  @override
  State<_ResumeNavBtn> createState() => _ResumeNavBtnState();
}

class _ResumeNavBtnState extends State<_ResumeNavBtn> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () async {
          final url = Uri.parse(
            'https://drive.google.com/file/d/1fhjghU9NKYepW0N6fObXyyXCgRkhwIsn/view?usp=drivesdk',
          );
          await launchUrl(url, mode: LaunchMode.platformDefault);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.translationValues(0, _hover ? -1 : 0, 0),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
          decoration: BoxDecoration(
            color: AppTheme.acc(widget.isDark),
            borderRadius: BorderRadius.circular(4),
            boxShadow: _hover
                ? [
                    BoxShadow(
                      color: AppTheme.acc(widget.isDark).withValues(alpha: 0.3),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    )
                  ]
                : [],
          ),
          child: Text(
            'RESUME',
            style: GoogleFonts.epilogue(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class _HamburgerBtn extends StatefulWidget {
  final bool isDark;
  final List<String> links;
  final Function(String) onNav;
  const _HamburgerBtn({
    required this.isDark,
    required this.links,
    required this.onNav,
  });

  @override
  State<_HamburgerBtn> createState() => _HamburgerBtnState();
}

class _HamburgerBtnState extends State<_HamburgerBtn> {
  void _showDrawer() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.bg(widget.isDark),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widget.links
              .map(
                (l) => ListTile(
                  title: Text(
                    l.toUpperCase(),
                    style: GoogleFonts.bebasNeue(
                      fontSize: 26,
                      letterSpacing: 1.5,
                      color: AppTheme.ink(widget.isDark),
                    ),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                  onTap: () {
                    Navigator.pop(ctx);
                    widget.onNav(l.toLowerCase());
                  },
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showDrawer,
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 20, height: 2, color: AppTheme.ink(widget.isDark)),
            const SizedBox(height: 4),
            Container(width: 20, height: 2, color: AppTheme.ink(widget.isDark)),
            const SizedBox(height: 4),
            Container(width: 20, height: 2, color: AppTheme.ink(widget.isDark)),
          ],
        ),
      ),
    );
  }
}
