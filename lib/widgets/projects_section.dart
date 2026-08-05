import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';
import '../models/content.dart';
import '../models/portfolio_data.dart';
import 'common_widgets.dart';
import 'project_detail_modal.dart';

class ProjectsSection extends StatelessWidget {
  final bool isDark;
  const ProjectsSection({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final cols = w > 1100 ? 3 : w > 700 ? 2 : 1;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 32),
      decoration: BoxDecoration(
        color: AppTheme.bg2(isDark),
        border: Border(top: BorderSide(color: AppTheme.line(isDark))),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            tag: 'Featured Work',
            title: "Things I've Shipped",
            subtitle:
                'Production mobile applications engineered at Criterion Tech Pvt Ltd — deployed live on the Google Play Store.',
            isDark: isDark,
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            decoration: BoxDecoration(
              color: AppTheme.orangeDim(isDark),
              border: Border.all(color: AppTheme.orangeMid(isDark)),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              '◆  Live Play Store Apps · Flutter · GetX · Firebase · REST APIs · Production Architecture',
              style: GoogleFonts.ibmPlexMono(
                fontSize: 11,
                letterSpacing: 0.8,
                color: AppTheme.acc(isDark),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 36),
          // Projects Grid
          LayoutBuilder(builder: (ctx, constraints) {
            final cardW =
                (constraints.maxWidth - (cols - 1) * 20) / cols;
            return Wrap(
              spacing: 20,
              runSpacing: 20,
              children: kProjects
                  .map((p) => SizedBox(
                        width: cardW,
                        child: _ProjectCard(
                          project: p,
                          isDark: isDark,
                        ),
                      ))
                  .toList(),
            );
          }),
        ],
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final ProjectItem project;
  final bool isDark;
  const _ProjectCard({required this.project, required this.isDark});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final p = widget.project;
    final isDark = widget.isDark;

    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: Matrix4.translationValues(0, _hover ? -5 : 0, 0),
        decoration: BoxDecoration(
          color: AppTheme.cardBg(isDark),
          border: Border.all(
            color: _hover ? AppTheme.acc(isDark) : AppTheme.line(isDark),
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(10),
          boxShadow: _hover
              ? [
                  BoxShadow(
                    color: AppTheme.acc(isDark).withOpacity(0.12),
                    blurRadius: 36,
                    offset: const Offset(0, 14),
                  )
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Interactive 3-Phone Rotational Showcase Header Banner
            ProjectDevicePreview(
              project: p,
              isDark: isDark,
            ),

            // Body Content
            Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tech stack tags
                  Wrap(
                    spacing: 6,
                    runSpacing: 4,
                    children: p.tags
                        .map((t) => PortfolioChip(
                              label: t,
                              isDark: isDark,
                              filled: true,
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 12),

                  // Title & Subtitle
                  Text(
                    p.title,
                    style: GoogleFonts.bebasNeue(
                      fontSize: 24,
                      letterSpacing: 1.2,
                      color: AppTheme.ink(isDark),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    p.desc,
                    style: GoogleFonts.epilogue(
                      fontSize: 13,
                      color: AppTheme.ink2(isDark),
                      fontWeight: FontWeight.w300,
                      height: 1.6,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 16),

                  // Contribution highlights
                  Text(
                    'MY CONTRIBUTION',
                    style: GoogleFonts.ibmPlexMono(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      color: AppTheme.acc(isDark),
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...p.features.take(3).map(
                        (f) => Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 4, right: 8),
                                child: Container(
                                  width: 5,
                                  height: 5,
                                  decoration: BoxDecoration(
                                    color: AppTheme.acc(isDark),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  f,
                                  style: GoogleFonts.epilogue(
                                    fontSize: 12,
                                    color: AppTheme.ink3(isDark),
                                    height: 1.4,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  const SizedBox(height: 16),
                  Divider(color: AppTheme.line(isDark), height: 1),
                  const SizedBox(height: 14),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: OrangeButton(
                          label: '▶ PLAY STORE',
                          isDark: isDark,
                          onTap: () => launchUrl(Uri.parse(p.playStoreUrl)),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: OutlineButton2(
                          label: 'CASE STUDY',
                          isDark: isDark,
                          onTap: () =>
                              ProjectDetailModal.show(context, p, isDark),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Interactive showcase component: 3 phone mockups where clicking or hovering any screen/tab smoothly rotates it into the center position.
class ProjectDevicePreview extends StatefulWidget {
  final ProjectItem project;
  final bool isDark;

  const ProjectDevicePreview({
    super.key,
    required this.project,
    required this.isDark,
  });

  @override
  State<ProjectDevicePreview> createState() => _ProjectDevicePreviewState();
}

class _ProjectDevicePreviewState extends State<ProjectDevicePreview> {
  int _focusedIndex = 0; // The phone index currently rotated into the center position
  bool _isCardHovered = false;

  String _getScreenTitle(int idx) {
    final title = widget.project.title.toLowerCase();
    if (title.contains('quran')) {
      if (idx == 0) return 'Journal Home';
      if (idx == 1) return 'Surah Reader';
      if (idx == 2) return 'Reading Progress';
    }
    if (title.contains('care')) {
      if (idx == 0) return 'Exam Result';
      if (idx == 1) return 'TBL Activity';
      if (idx == 2) return 'iRAT Assessment';
    }
    if (idx == 0) return 'Dashboard';
    if (idx == 1) return 'Prayer Schedule';
    if (idx == 2) return 'Leaderboard';
    return 'Screen ${idx + 1}';
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.project;
    final images = p.previewImages;
    final hasImages = images.isNotEmpty;

    return MouseRegion(
      onEnter: (_) => setState(() => _isCardHovered = true),
      onExit: (_) => setState(() => _isCardHovered = false),
      child: Container(
        height: 250,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: widget.isDark
              ? const Color(0xFF0D1117)
              : const Color(0xFFF3F4F6),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
        ),
        child: Column(
          children: [
            // Interactive Screen Selector Chips
            if (hasImages && images.length > 1)
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(images.length, (idx) {
                    final isSel = _focusedIndex == idx;
                    return GestureDetector(
                      onTap: () => setState(() => _focusedIndex = idx),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 9, vertical: 3.5),
                        decoration: BoxDecoration(
                          color: isSel
                              ? AppTheme.acc(widget.isDark)
                              : (widget.isDark
                                  ? Colors.white.withOpacity(0.08)
                                  : Colors.black.withOpacity(0.06)),
                          border: Border.all(
                            color: isSel
                                ? AppTheme.acc(widget.isDark)
                                : (widget.isDark
                                    ? Colors.white.withOpacity(0.15)
                                    : Colors.black.withOpacity(0.12)),
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          _getScreenTitle(idx),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight:
                                isSel ? FontWeight.bold : FontWeight.w500,
                            color: isSel
                                ? Colors.white
                                : (widget.isDark
                                    ? Colors.white.withOpacity(0.7)
                                    : Colors.black.withOpacity(0.7)),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),

            // 3-Phone Showcase Area with 3D Rotation Swap
            Expanded(
              child: hasImages
                  ? _buildInteractiveRotationalShowcase(images)
                  : Center(
                      child:
                          Text(p.emoji, style: const TextStyle(fontSize: 48)),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInteractiveRotationalShowcase(List<String> images) {
    if (images.length == 1) {
      return _buildPhoneFrame(
        imagePath: images[0],
        width: 96,
        height: 190,
        isCenter: true,
      );
    }

    final total = images.length;
    final sideSpacing = _isCardHovered ? 84.0 : 76.0;

    // Order indices so the focused/center phone is rendered last (on top of stack)
    final phoneIndices = List.generate(total, (i) => i);
    phoneIndices.sort((a, b) {
      if (a == _focusedIndex) return 1;
      if (b == _focusedIndex) return -1;
      return 0;
    });

    return SizedBox(
      height: 200,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: phoneIndices.map((i) {
          int diff = (i - _focusedIndex) % total;
          if (diff > total ~/ 2) diff -= total;
          if (diff < -total ~/ 2) diff += total;

          final isCenter = diff == 0;
          final double offsetX = isCenter
              ? 0.0
              : (diff < 0 ? -sideSpacing : sideSpacing);
          final double offsetY = isCenter ? -4.0 : 10.0;
          final double width = isCenter ? 92.0 : 76.0;
          final double height = isCenter ? 180.0 : 148.0;
          final double rotY = isCenter ? 0.0 : (diff < 0 ? 0.18 : -0.18);

          return AnimatedPositioned(
            key: ValueKey<int>(i),
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOutCubic,
            left: 0,
            right: 0,
            top: 5,
            child: Center(
              child: MouseRegion(
                onEnter: (_) {
                  if (_focusedIndex != i) {
                    setState(() => _focusedIndex = i);
                  }
                },
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    if (_focusedIndex != i) {
                      setState(() => _focusedIndex = i);
                    }
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOutCubic,
                    transform: Matrix4.translationValues(offsetX, offsetY, 0.0)
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(rotY),
                    transformAlignment: Alignment.center,
                    child: _buildPhoneFrame(
                      imagePath: images[i],
                      width: width,
                      height: height,
                      isCenter: isCenter,
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPhoneFrame({
    required String imagePath,
    required double width,
    required double height,
    required bool isCenter,
  }) {
    final isDark = widget.isDark;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOutCubic,
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFF16161A), // Dark phone chassis
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isCenter
              ? AppTheme.acc(isDark)
              : Colors.white.withOpacity(0.25),
          width: isCenter ? 2.5 : 1.8,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isCenter ? 0.45 : 0.32),
            blurRadius: isCenter ? 22 : 14,
            offset: Offset(0, isCenter ? 10 : 6),
          ),
          if (isCenter)
            BoxShadow(
              color: AppTheme.acc(isDark).withOpacity(0.28),
              blurRadius: 18,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: [
            // App Screenshot Image
            Positioned.fill(
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
                errorBuilder: (ctx, err, stack) => Image.asset(
                  imagePath.contains('projects/')
                      ? imagePath.replaceFirst('projects/', '')
                      : imagePath,
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                  errorBuilder: (ctx2, err2, stack2) => Center(
                    child: Text(
                      widget.project.emoji,
                      style: const TextStyle(fontSize: 28),
                    ),
                  ),
                ),
              ),
            ),

            // Dimming Overlay for non-centered side phones
            if (!isCenter)
              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.12),
                ),
              ),

            // Top Notch Island Pill
            Positioned(
              top: 4,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: 26,
                  height: 3.5,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.85),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
