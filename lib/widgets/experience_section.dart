import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../models/content.dart';
import 'common_widgets.dart';

class ExperienceSection extends StatefulWidget {
  final bool isDark;
  const ExperienceSection({super.key, required this.isDark});

  @override
  State<ExperienceSection> createState() => _ExperienceSectionState();
}

class _ExperienceSectionState extends State<ExperienceSection> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return Container(

      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 32),
      decoration: BoxDecoration(
        color: AppTheme.bg(widget.isDark),
        border: Border(top: BorderSide(color: AppTheme.line(widget.isDark))),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            tag: 'Experience',
            title: 'Where I Work',
            subtitle:
                "One company so far — and I've made the most of every sprint, pull request, and deployment.",
            isDark: widget.isDark,
          ),
          const SizedBox(height: 40),
          MouseRegion(
            onEnter: (_) => setState(() => _hover = true),
            onExit: (_) => setState(() => _hover = false),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
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
                              AppTheme.acc(widget.isDark).withOpacity(0.08),
                          blurRadius: 40,
                          offset: const Offset(0, 8),
                        )
                      ]
                    : [],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Container(
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: AppTheme.line(widget.isDark))),
                    ),
                    child: Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                style: GoogleFonts.bebasNeue(
                                  fontSize: 30,
                                  letterSpacing: 1.500,
                                  color: AppTheme.ink(widget.isDark),
                                ),
                                children: [
                                  const TextSpan(text: 'Criterion '),
                                  TextSpan(
                                    text: 'Tech',
                                    style: TextStyle(
                                        color:
                                            AppTheme.acc(widget.isDark)),
                                  ),
                                  const TextSpan(text: ' Pvt Ltd'),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppTheme.orangeDim(widget.isDark),
                                border: Border.all(
                                    color:
                                        AppTheme.orangeMid(widget.isDark)),
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: Text(
                                'Flutter Developer',
                                style: GoogleFonts.ibmPlexMono(
                                    fontSize: 11,
                                    letterSpacing: 0.8,
                                    color: AppTheme.acc(widget.isDark),
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 7),
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.1),
                            border: Border.all(
                                color: Colors.green.withOpacity(0.3)),
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              BlinkingDot(
                                  color: Colors.green.shade500, size: 5),
                              const SizedBox(width: 6),
                              Text(
                                'CURRENTLY WORKING',
                                style: GoogleFonts.ibmPlexMono(
                                    fontSize: 11,
                                    letterSpacing: 1.2,
                                    color: Colors.green.shade500,
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Meta row
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 14),
                    color: AppTheme.bg2(widget.isDark),
                    child: Wrap(
                      spacing: 24,
                      runSpacing: 8,
                      children: [
                        _meta('📅 Sep 2024 – Present', widget.isDark),
                        _meta(
                            '📍 Lucknow, Uttar Pradesh', widget.isDark),
                        _meta('💼 Full-time', widget.isDark),
                      ],
                    ),
                  ),
                  // Body
                  Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...kExpBullets.map((b) => Padding(
                              padding: const EdgeInsets.only(bottom: 14),
                              child: Row(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 3, right: 14),
                                    child: Text(
                                      '→',
                                      style: GoogleFonts.epilogue(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700,
                                          color: AppTheme.acc(
                                              widget.isDark)),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      b,
                                      style: GoogleFonts.epilogue(
                                          fontSize: 14,
                                          color: AppTheme.ink2(
                                              widget.isDark),
                                          fontWeight: FontWeight.w300,
                                          height: 1.65),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                        Divider(
                          color: AppTheme.line(widget.isDark),
                          height: 40,
                        ),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: kExpStack
                              .map((s) => _stackPill(s, widget.isDark))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _meta(String text, bool isDark) {
    return Text(
      text,
      style: GoogleFonts.ibmPlexMono(
          fontSize: 12,
          letterSpacing: 0.5,
          color: AppTheme.ink3(isDark)),
    );
  }

  Widget _stackPill(String text, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppTheme.bg2(isDark),
        border: Border.all(color: AppTheme.line(isDark)),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Text(
        text,
        style: GoogleFonts.ibmPlexMono(
            fontSize: 11, color: AppTheme.ink2(isDark), letterSpacing: 0.5),
      ),
    );
  }
}
