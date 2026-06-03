import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';
import '../models/content.dart';
import '../models/portfolio_data.dart';
import 'common_widgets.dart';

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
            tag: 'Live Projects',
            title: "Things I've\nShipped",
            subtitle:
                'Production apps developed at Criterion Tech Pvt Ltd — live on the Google Play Store.',
            isDark: isDark,
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            decoration: BoxDecoration(
              color: AppTheme.orangeDim(isDark),
              border: Border.all(color: AppTheme.orangeMid(isDark)),
              borderRadius: BorderRadius.circular(3),
            ),
            child: Text(
              '◆  Live on Google Play Store · Flutter · Firebase · GetX · Custom UI',
              style: GoogleFonts.ibmPlexMono(
                  fontSize: 11,
                  letterSpacing: 0.8,
                  color: AppTheme.acc(isDark)),
            ),
          ),
          const SizedBox(height: 32),
          // Grid
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
                            project: p, isDark: isDark),
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
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform:
            Matrix4.translationValues(0, _hover ? -4 : 0, 0),
        decoration: BoxDecoration(
          color: AppTheme.cardBg(widget.isDark),
          border: Border.all(
            color: _hover
                ? AppTheme.acc(widget.isDark)
                : AppTheme.line(widget.isDark),
          ),
          borderRadius: BorderRadius.circular(8),
          boxShadow: _hover
              ? [
                  BoxShadow(
                    color:
                        AppTheme.acc(widget.isDark).withOpacity(0.1),
                    blurRadius: 48,
                    offset: const Offset(0, 16),
                  )
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumb
            Container(
              height: 160,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [p.gradientStart, p.gradientEnd],
                ),
                borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(8)),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 16,
                    left: 16,
                    child: Text(
                      p.num,
                      style: GoogleFonts.bebasNeue(
                        fontSize: 56,
                        color: Colors.white.withOpacity(0.12),
                        letterSpacing: 2,
                        height: 1,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(p.emoji,
                        style: const TextStyle(fontSize: 44)),
                  ),
                ],
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 6,
                    runSpacing: 4,
                    children: p.tags
                        .map((t) => _ProjTag(label: t, isDark: widget.isDark))
                        .toList(),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    p.title,
                    style: GoogleFonts.bebasNeue(
                        fontSize: 22,
                        letterSpacing: 1.2,
                        color: AppTheme.ink(widget.isDark)),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    p.desc,
                    style: GoogleFonts.epilogue(
                        fontSize: 13,
                        color: AppTheme.ink2(widget.isDark),
                        fontWeight: FontWeight.w300,
                        height: 1.65),
                  ),
                  const SizedBox(height: 14),
                  ...p.features.map((f) => Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Row(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 4, right: 8),
                              child: Container(
                                width: 6,
                                height: 6,
                                decoration: BoxDecoration(
                                  color: AppTheme.acc(widget.isDark),
                                  borderRadius:
                                      BorderRadius.circular(1),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                f,
                                style: GoogleFonts.epilogue(
                                    fontSize: 12,
                                    color: AppTheme.ink3(widget.isDark),
                                    height: 1.5,
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                          ],
                        ),
                      )),
                  const SizedBox(height: 16),
                  Divider(color: AppTheme.line(widget.isDark), height: 1),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _ProjBtn(
                          label: '▶  PLAY STORE',
                          primary: true,
                          isDark: widget.isDark,
                          onTap: () =>
                              launchUrl(Uri.parse(p.playStoreUrl)),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _ProjBtn(
                          label: '↓  TRY APK',
                          primary: false,
                          isDark: widget.isDark,
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

class _ProjTag extends StatelessWidget {
  final String label;
  final bool isDark;
  const _ProjTag({required this.label, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: AppTheme.bg3(isDark),
        border: Border.all(color: AppTheme.line(isDark)),
        borderRadius: BorderRadius.circular(2),
      ),
      child: Text(
        label,
        style: GoogleFonts.ibmPlexMono(
            fontSize: 10,
            letterSpacing: 0.5,
            color: AppTheme.ink3(isDark)),
      ),
    );
  }
}

class _ProjBtn extends StatefulWidget {
  final String label;
  final bool primary;
  final bool isDark;
  final VoidCallback? onTap;

  const _ProjBtn({
    required this.label,
    required this.primary,
    required this.isDark,
    this.onTap,
  });

  @override
  State<_ProjBtn> createState() => _ProjBtnState();
}

class _ProjBtnState extends State<_ProjBtn> {
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
          transform:
              Matrix4.translationValues(0, _hover && widget.primary ? -1 : 0, 0),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: widget.primary
                ? AppTheme.acc(widget.isDark)
                : Colors.transparent,
            border: Border.all(
              color: widget.primary
                  ? AppTheme.acc(widget.isDark)
                  : _hover
                      ? AppTheme.acc(widget.isDark)
                      : AppTheme.line(widget.isDark),
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(4),
            boxShadow: _hover && widget.primary
                ? [
                    BoxShadow(
                      color:
                          AppTheme.acc(widget.isDark).withOpacity(0.3),
                      blurRadius: 18,
                      offset: const Offset(0, 6),
                    )
                  ]
                : [],
          ),
          child: Center(
            child: Text(
              widget.label,
              style: GoogleFonts.epilogue(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
                color: widget.primary
                    ? Colors.white
                    : _hover
                        ? AppTheme.acc(widget.isDark)
                        : AppTheme.ink2(widget.isDark),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
