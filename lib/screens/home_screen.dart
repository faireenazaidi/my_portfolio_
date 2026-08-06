import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../theme/theme_notifier.dart';
import '../widgets/nav_bar.dart';
import '../widgets/hero_section.dart';
import '../widgets/stats_section.dart';
import '../widgets/about_section.dart';
import '../widgets/specialization_section.dart';
import '../widgets/skills_section.dart';
import '../widgets/experience_section.dart';
import '../widgets/projects_section.dart';
import '../widgets/architecture_section.dart';
import '../widgets/education_section.dart';
import '../widgets/github_section.dart';
import '../widgets/resume_cta_section.dart';
import '../widgets/contact_section.dart';
import '../widgets/footer_widget.dart';

class HomeScreen extends StatefulWidget {
  final ThemeNotifier themeNotifier;
  const HomeScreen({super.key, required this.themeNotifier});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final _scroll = ScrollController();
  final _scrollProgress = ValueNotifier<double>(0.0);
  final _showBtt = ValueNotifier<bool>(false);

  // Section keys for scroll-to navigation
  final _heroKey = GlobalKey();
  final _aboutKey = GlobalKey();
  final _specKey = GlobalKey();
  final _skillsKey = GlobalKey();
  final _expKey = GlobalKey();
  final _projKey = GlobalKey();
  final _archKey = GlobalKey();
  final _eduKey = GlobalKey();
  final _githubKey = GlobalKey();
  final _contactKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _scroll.addListener(_onScroll);
  }

  void _onScroll() {
    if (!mounted || !_scroll.hasClients) return;
    final maxExt = _scroll.position.maxScrollExtent;
    final cur = _scroll.offset;
    _scrollProgress.value = maxExt > 0 ? (cur / maxExt).clamp(0.0, 1.0) : 0.0;
    _showBtt.value = cur > 400;
  }

  void _navTo(String section) {
    final key = {
      'hero': _heroKey,
      'about': _aboutKey,
      'specialization': _specKey,
      'skills': _skillsKey,
      'experience': _expKey,
      'projects': _projKey,
      'architecture': _archKey,
      'education': _eduKey,
      'github': _githubKey,
      'contact': _contactKey,
    }[section];

    if (key?.currentContext != null) {
      Scrollable.ensureVisible(
        key!.currentContext!,
        duration: const Duration(milliseconds: 750),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  void dispose() {
    _scroll.removeListener(_onScroll);
    _scroll.dispose();
    _scrollProgress.dispose();
    _showBtt.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.themeNotifier,
      builder: (_, __) {
        final isDark = widget.themeNotifier.isDark;
        return Scaffold(
          backgroundColor: AppTheme.bg(isDark),
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: ValueListenableBuilder<double>(
              valueListenable: _scrollProgress,
              builder: (_, progress, __) => PortfolioNav(
                isDark: isDark,
                onToggleTheme: widget.themeNotifier.toggle,
                onNav: _navTo,
                scrollProgress: progress,
              ),
            ),
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                controller: _scroll,
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                child: Column(
                  children: [
                    // 1. Hero Section
                    KeyedSubtree(
                      key: _heroKey,
                      child: HeroSection(
                        isDark: isDark,
                        onViewProjects: () => _navTo('projects'),
                        onContact: () => _navTo('contact'),
                      ),
                    ),

                    // 2. Stats Section (Positioned right below Hero)
                    StatsSection(isDark: isDark),

                    // 3. About Section
                    KeyedSubtree(
                      key: _aboutKey,
                      child: AboutSection(isDark: isDark),
                    ),

                    // 4. Specialization / What I Build Section
                    KeyedSubtree(
                      key: _specKey,
                      child: SpecializationSection(isDark: isDark),
                    ),

                    // 5. Skills Section
                    KeyedSubtree(
                      key: _skillsKey,
                      child: SkillsSection(isDark: isDark),
                    ),

                    // 6. Experience Section
                    KeyedSubtree(
                      key: _expKey,
                      child: ExperienceSection(isDark: isDark),
                    ),

                    // 7. Projects Section
                    KeyedSubtree(
                      key: _projKey,
                      child: ProjectsSection(isDark: isDark),
                    ),

                    // 8. Engineering / Technical Architecture Section
                    KeyedSubtree(
                      key: _archKey,
                      child: ArchitectureSection(isDark: isDark),
                    ),

                    // 9. Education Section
                    KeyedSubtree(
                      key: _eduKey,
                      child: EducationSection(isDark: isDark),
                    ),

                    // 10. Dedicated GitHub Section
                    KeyedSubtree(
                      key: _githubKey,
                      child: GitHubSection(isDark: isDark),
                    ),

                    // 11. Resume CTA Banner
                    ResumeCtaSection(isDark: isDark),

                    // 12. Contact Section
                    KeyedSubtree(
                      key: _contactKey,
                      child: ContactSection(isDark: isDark),
                    ),

                    // 13. Footer
                    PortfolioFooter(isDark: isDark, onNav: _navTo),
                  ],
                ),
              ),

              // Back to top floating button
              ValueListenableBuilder<bool>(
                valueListenable: _showBtt,
                builder: (_, show, __) => AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  bottom: show ? 28 : -60,
                  right: 28,
                  child: _BttBtn(
                    isDark: isDark,
                    onTap: () {
                      _scroll.animateTo(
                        0,
                        duration: const Duration(milliseconds: 600),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _BttBtn extends StatefulWidget {
  final bool isDark;
  final VoidCallback onTap;
  const _BttBtn({required this.isDark, required this.onTap});

  @override
  State<_BttBtn> createState() => _BttBtnState();
}

class _BttBtnState extends State<_BttBtn> {
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
          width: 44,
          height: 44,
          transform: Matrix4.translationValues(0, _hover ? -2 : 0, 0),
          decoration: BoxDecoration(
            color: AppTheme.acc(widget.isDark),
            borderRadius: BorderRadius.circular(6),
            boxShadow: _hover
                ? [
                    BoxShadow(
                      color: AppTheme.acc(widget.isDark).withValues(alpha: 0.4),
                      blurRadius: 20,
                      offset: const Offset(0, 6),
                    )
                  ]
                : [],
          ),
          child: const Center(
            child: Icon(Icons.keyboard_arrow_up, color: Colors.white, size: 24),
          ),
        ),
      ),
    );
  }
}
