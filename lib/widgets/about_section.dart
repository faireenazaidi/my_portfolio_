import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../models/content.dart';
import 'common_widgets.dart';

class AboutSection extends StatelessWidget {
  final bool isDark;
  const AboutSection({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 900;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 32),
      decoration: BoxDecoration(
        color: AppTheme.bg(isDark),
        border: Border(top: BorderSide(color: AppTheme.line(isDark))),
      ),
      child: isWide
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildLeft()),
                const SizedBox(width: 60),
                Expanded(child: _buildTimeline()),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLeft(),
                const SizedBox(height: 48),
                _buildTimeline(),
              ],
            ),
    );
  }

  Widget _buildLeft() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          tag: 'About Me',
          title: 'More Than\nJust Code',
          subtitle:
              "I build things people actually use — apps that are fast, maintainable, and look exactly the way designers intended.",
          isDark: isDark,
        ),
        const SizedBox(height: 28),
        _para(
          "I'm ",
          bold: "Faireena Zaidi",
          rest:
              ", a Flutter developer at Criterion Tech Pvt Ltd, Lucknow — building cross-platform mobile applications for Android and iOS since September 2024.",
        ),
        const SizedBox(height: 14),
        _para(
          'My approach is simple: ',
          bold: 'clean architecture, readable code, and UI that respects the design',
          rest:
              '. I translate Figma mockups into responsive widgets, integrate REST APIs cleanly using Dio/http, manage state with GetX, and wire Firebase services end-to-end.',
        ),
        const SizedBox(height: 14),
        _para(
          'Before Criterion Tech, I graduated from ',
          bold: 'ERA University, Lucknow',
          rest:
              ' with a BCA (79%) in 2024 — where I spent most of my time building Flutter projects and understanding what makes mobile software genuinely good.',
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: kChips
              .map((c) => PortfolioChip(label: c, isDark: isDark))
              .toList(),
        ),
      ],
    );
  }

  Widget _para(String before, {required String bold, required String rest}) {
    return RichText(
      text: TextSpan(
        style: GoogleFonts.epilogue(
            fontSize: 15,
            color: AppTheme.ink2(isDark),
            fontWeight: FontWeight.w300,
            height: 1.8),
        children: [
          TextSpan(text: before),
          TextSpan(
            text: bold,
            style: GoogleFonts.epilogue(
                fontSize: 15,
                color: AppTheme.ink(isDark),
                fontWeight: FontWeight.w600,
                height: 1.8),
          ),
          TextSpan(text: rest),
        ],
      ),
    );
  }

  Widget _buildTimeline() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
                width: 24, height: 1.5, color: AppTheme.acc(isDark)),
            const SizedBox(width: 10),
            Text(
              'JOURNEY',
              style: GoogleFonts.ibmPlexMono(
                  fontSize: 11,
                  letterSpacing: 1.8,
                  color: AppTheme.acc(isDark)),
            ),
          ],
        ),
        const SizedBox(height: 24),
        ...kTimeline.asMap().entries.map((e) {
          final i = e.key;
          final item = e.value;
          return _TimelineItem(
            item: item,
            isLast: i == kTimeline.length - 1,
            isDark: isDark,
          );
        }),
      ],
    );
  }
}

class _TimelineItem extends StatelessWidget {
  final dynamic item;
  final bool isLast;
  final bool isDark;

  const _TimelineItem({
    required this.item,
    required this.isLast,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left: number + line
        SizedBox(
          width: 32,
          child: Column(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppTheme.acc(isDark), width: 1.5),
                  color: AppTheme.bg(isDark),
                ),
                child: Center(
                  child: Text(
                    item.num,
                    style: GoogleFonts.ibmPlexMono(
                      fontSize: 10,
                      color: AppTheme.acc(isDark),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              if (!isLast)
                Container(
                  width: 1,
                  height: 60, // 🔥 fixed height instead of Expanded
                  color: AppTheme.line(isDark),
                ),
            ],
          ),
        ),

        const SizedBox(width: 16),

        // Right: content
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(bottom: isLast ? 0 : 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.date,
                  style: GoogleFonts.ibmPlexMono(
                    fontSize: 11,
                    letterSpacing: 1,
                    color: AppTheme.acc(isDark),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.title,
                  style: GoogleFonts.epilogue(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.ink(isDark),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.desc,
                  style: GoogleFonts.epilogue(
                    fontSize: 13,
                    color: AppTheme.ink3(isDark),
                    fontWeight: FontWeight.w300,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}