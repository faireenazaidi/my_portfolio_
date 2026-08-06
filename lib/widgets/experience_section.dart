import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../models/content.dart';
import 'common_widgets.dart';

class ExperienceSection extends StatelessWidget {
  final bool isDark;
  const ExperienceSection({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isWide = w > 900;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 32),
      decoration: BoxDecoration(
        color: AppTheme.bg(isDark),
        border: Border(top: BorderSide(color: AppTheme.line(isDark))),
      ),
      child: MaxContentContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(
              tag: 'Work Experience',
              title: 'Professional Timeline',
              subtitle:
                  'Hands-on cross-platform engineering, sprint contributions, and Google Play Store app delivery.',
              isDark: isDark,
            ),
            const SizedBox(height: 40),
            HoverCard(
              isDark: isDark,
              padding: EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Company & Role Header
                  Container(
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: AppTheme.line(isDark))),
                    ),
                    child: isWide
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              _buildCompanyTitle(isDark),
                              _buildStatusBadge(),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildCompanyTitle(isDark),
                              const SizedBox(height: 16),
                              _buildStatusBadge(),
                            ],
                          ),
                  ),

                  // Meta Row
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 14),
                    color: AppTheme.bg2(isDark),
                    child: Wrap(
                      spacing: 24,
                      runSpacing: 8,
                      children: [
                        _meta('📅 Sep 2024 – Present (Active)', isDark),
                        _meta('📍 Lucknow, Uttar Pradesh, India', isDark),
                        _meta('💼 Full-time Flutter Developer', isDark),
                      ],
                    ),
                  ),

                  // Responsibilities & Impact
                  Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'KEY RESPONSIBILITIES & DEVELOPMENT IMPACT',
                          style: GoogleFonts.ibmPlexMono(
                            fontSize: 11,
                            letterSpacing: 1.5,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.acc(isDark),
                          ),
                        ),
                        const SizedBox(height: 20),
                        ...kExpBullets.map(
                          (b) => Padding(
                            padding: const EdgeInsets.only(bottom: 14),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 4, right: 14),
                                  child: Text(
                                    '➔',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.acc(isDark),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    b,
                                    style: GoogleFonts.epilogue(
                                      fontSize: 14,
                                      color: AppTheme.ink2(isDark),
                                      fontWeight: FontWeight.w300,
                                      height: 1.65,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Divider(color: AppTheme.line(isDark), height: 32),
                        const SizedBox(height: 8),

                        // Tech Stack Used
                        Text(
                          'TECHNOLOGIES USED IN PRODUCTION',
                          style: GoogleFonts.ibmPlexMono(
                            fontSize: 11,
                            letterSpacing: 1.5,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.acc(isDark),
                          ),
                        ),
                        const SizedBox(height: 14),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: kExpStack
                              .map((s) => _stackPill(s, isDark))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompanyTitle(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: GoogleFonts.bebasNeue(
              fontSize: 34,
              letterSpacing: 1.5,
              color: AppTheme.ink(isDark),
            ),
            children: [
              const TextSpan(text: 'Criterion '),
              TextSpan(
                text: 'Tech',
                style: TextStyle(color: AppTheme.acc(isDark)),
              ),
              const TextSpan(text: ' Pvt Ltd'),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: AppTheme.orangeDim(isDark),
            border: Border.all(color: AppTheme.orangeMid(isDark)),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            'Flutter Developer · Mobile Engineering',
            style: GoogleFonts.ibmPlexMono(
              fontSize: 11,
              letterSpacing: 0.8,
              color: AppTheme.acc(isDark),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.green.withValues(alpha: 0.12),
        border: Border.all(color: Colors.green.withValues(alpha: 0.35)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          BlinkingDot(color: Colors.green.shade500, size: 6),
          const SizedBox(width: 8),
          Text(
            'CURRENTLY EMPLOYED',
            style: GoogleFonts.ibmPlexMono(
              fontSize: 11,
              letterSpacing: 1.2,
              color: Colors.green.shade500,
              fontWeight: FontWeight.bold,
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
        color: AppTheme.ink3(isDark),
      ),
    );
  }

  Widget _stackPill(String text, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppTheme.bg2(isDark),
        border: Border.all(color: AppTheme.line(isDark)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: GoogleFonts.ibmPlexMono(
          fontSize: 11,
          color: AppTheme.ink2(isDark),
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
