import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';
import '../models/portfolio_data.dart';
import 'common_widgets.dart';

class ProjectDetailModal extends StatelessWidget {
  final ProjectItem project;
  final bool isDark;

  const ProjectDetailModal({
    super.key,
    required this.project,
    required this.isDark,
  });

  static void show(BuildContext context, ProjectItem project, bool isDark) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (ctx) => ProjectDetailModal(project: project, isDark: isDark),
    );
  }

  @override
  Widget build(BuildContext context) {
    final p = project;
    final w = MediaQuery.of(context).size.width;
    final maxW = w > 800 ? 760.0 : w * 0.92;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: maxW,
            maxHeight: MediaQuery.of(context).size.height * 0.88,
          ),
          decoration: BoxDecoration(
            color: AppTheme.bg(isDark),
            border: Border.all(color: AppTheme.acc(isDark), width: 1.5),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 40,
                offset: const Offset(0, 16),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [p.gradientStart, p.gradientEnd],
                  ),
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(10)),
                ),
                child: Row(
                  children: [
                    Text(
                      p.emoji,
                      style: const TextStyle(fontSize: 28),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            p.title,
                            style: GoogleFonts.bebasNeue(
                              fontSize: 26,
                              letterSpacing: 1.5,
                              color: Colors.white,
                            ),
                          ),
                          if (p.subtitle.isNotEmpty)
                            Text(
                              p.subtitle,
                              style: GoogleFonts.epilogue(
                                fontSize: 12,
                                color: Colors.white.withOpacity(0.8),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () => Navigator.of(context).pop(),
                      tooltip: 'Close Modal',
                    ),
                  ],
                ),
              ),
              // Body Content
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Tech stack tags
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: p.tags
                            .map((t) => PortfolioChip(
                                  label: t,
                                  isDark: isDark,
                                  filled: true,
                                ))
                            .toList(),
                      ),
                      const SizedBox(height: 24),
                      // Application Screenshots (if present)
                      if (p.previewImages.isNotEmpty) ...[
                        _SectionHeaderTitle(title: 'APPLICATION SCREENSHOTS', isDark: isDark),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: 180,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: p.previewImages.length,
                            separatorBuilder: (_, __) => const SizedBox(width: 12),
                            itemBuilder: (ctx, idx) => Container(
                              width: 96,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: AppTheme.line(isDark)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(9),
                                child: Image.asset(
                                  p.previewImages[idx],
                                  fit: BoxFit.cover,
                                  alignment: Alignment.topCenter,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                      // Role & Play Store badge
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: AppTheme.bg2(isDark),
                          border: Border.all(color: AppTheme.line(isDark)),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.person_outline,
                                size: 18, color: AppTheme.acc(isDark)),
                            const SizedBox(width: 8),
                            Text(
                              'MY ROLE: ',
                              style: GoogleFonts.ibmPlexMono(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.acc(isDark),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                p.myRole,
                                style: GoogleFonts.epilogue(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.ink(isDark),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Overview / Case Study
                      _SectionHeaderTitle(title: 'CASE STUDY OVERVIEW', isDark: isDark),
                      const SizedBox(height: 8),
                      Text(
                        p.caseStudyOverview.isNotEmpty ? p.caseStudyOverview : p.desc,
                        style: GoogleFonts.epilogue(
                          fontSize: 14,
                          color: AppTheme.ink2(isDark),
                          height: 1.7,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      if (p.problem.isNotEmpty) ...[
                        const SizedBox(height: 20),
                        _SectionHeaderTitle(title: 'THE CHALLENGE & PROBLEM', isDark: isDark),
                        const SizedBox(height: 8),
                        Text(
                          p.problem,
                          style: GoogleFonts.epilogue(
                            fontSize: 14,
                            color: AppTheme.ink2(isDark),
                            height: 1.7,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                      const SizedBox(height: 20),
                      // Key Contributions
                      if (p.contributionPoints.isNotEmpty) ...[
                        _SectionHeaderTitle(title: 'MY CONTRIBUTIONS & IMPLEMENTATION', isDark: isDark),
                        const SizedBox(height: 10),
                        ...p.contributionPoints.map(
                          (c) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 4, right: 10),
                                  child: Container(
                                    width: 6,
                                    height: 6,
                                    decoration: BoxDecoration(
                                      color: AppTheme.acc(isDark),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    c,
                                    style: GoogleFonts.epilogue(
                                      fontSize: 13,
                                      color: AppTheme.ink(isDark),
                                      height: 1.6,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                      // Key Features List
                      _SectionHeaderTitle(title: 'KEY APP FEATURES', isDark: isDark),
                      const SizedBox(height: 10),
                      ...p.features.map(
                        (f) => Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Row(
                            children: [
                              Text('✓  ',
                                  style: TextStyle(
                                      color: AppTheme.acc(isDark),
                                      fontWeight: FontWeight.bold)),
                              Expanded(
                                child: Text(
                                  f,
                                  style: GoogleFonts.epilogue(
                                    fontSize: 13,
                                    color: AppTheme.ink2(isDark),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 28),
                      Divider(color: AppTheme.line(isDark)),
                      const SizedBox(height: 16),
                      // Action buttons
                      Row(
                        children: [
                          Expanded(
                            child: OrangeButton(
                              label: '▶  OPEN IN PLAY STORE',
                              isDark: isDark,
                              onTap: () => launchUrl(Uri.parse(p.playStoreUrl)),
                            ),
                          ),
                          if (p.githubUrl != null) ...[
                            const SizedBox(width: 12),
                            Expanded(
                              child: OutlineButton2(
                                label: 'CODE ON GITHUB',
                                isDark: isDark,
                                onTap: () => launchUrl(Uri.parse(p.githubUrl!)),
                              ),
                            ),
                          ],
                        ],
                      ),
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
}

class _SectionHeaderTitle extends StatelessWidget {
  final String title;
  final bool isDark;

  const _SectionHeaderTitle({required this.title, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 16, height: 1.5, color: AppTheme.acc(isDark)),
        const SizedBox(width: 8),
        Text(
          title,
          style: GoogleFonts.ibmPlexMono(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            color: AppTheme.acc(isDark),
          ),
        ),
      ],
    );
  }
}
