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
                Expanded(child: _buildRightTimeline()),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLeft(),
                const SizedBox(height: 48),
                _buildRightTimeline(),
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
              'Building production-ready Flutter mobile applications with clean architecture, responsive design, and attention to every UI detail.',
          isDark: isDark,
        ),
        const SizedBox(height: 28),
        _para(
          "I am ",
          bold: "Syed Faireena Zaidi",
          rest:
              ", a Flutter Developer based in Lucknow, Uttar Pradesh. Since September 2024, I've been building and maintaining cross-platform mobile apps for Android and iOS at Criterion Tech Pvt Ltd.",
        ),
        const SizedBox(height: 16),
        _para(
          'My core philosophy: ',
          bold: 'Clean code, pixel-perfect UI fidelity, and smooth user experience',
          rest:
              '. I bridge the gap between Figma designs and production apps — implementing GetX state management, Dio/http REST API integration, and Firebase cloud services.',
        ),
        const SizedBox(height: 16),
        _para(
          'Educational background: ',
          bold: 'Bachelor of Computer Applications (BCA, 79%)',
          rest:
              ' from ERA University, Lucknow (2022–2024), backed by strong foundations in computer science, object-oriented programming, and mathematical problem-solving.',
        ),
        const SizedBox(height: 28),

        // Key Value Pillars
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppTheme.bg2(isDark),
            border: Border.all(color: AppTheme.line(isDark)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'WHAT DISTINGUISHES MY DEVELOPMENT WORK',
                style: GoogleFonts.ibmPlexMono(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  color: AppTheme.acc(isDark),
                ),
              ),
              const SizedBox(height: 12),
              _pillar('⚡ Production Focus', '3 apps successfully published to Google Play Store.'),
              _pillar('🎨 Figma to Flutter', 'Translating design mockups into exact responsive widgets.'),
              _pillar('📐 Clean Architecture', 'GetX reactive state, dependency injection, and clean layers.'),
            ],
          ),
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

  Widget _pillar(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('• ', style: TextStyle(color: AppTheme.acc(isDark), fontWeight: FontWeight.bold)),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: GoogleFonts.epilogue(fontSize: 13, color: AppTheme.ink2(isDark)),
                children: [
                  TextSpan(
                    text: '$title — ',
                    style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.ink(isDark)),
                  ),
                  TextSpan(text: subtitle),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _para(String before, {required String bold, required String rest}) {
    return RichText(
      text: TextSpan(
        style: GoogleFonts.epilogue(
          fontSize: 15,
          color: AppTheme.ink2(isDark),
          fontWeight: FontWeight.w300,
          height: 1.75,
        ),
        children: [
          TextSpan(text: before),
          TextSpan(
            text: bold,
            style: GoogleFonts.epilogue(
              fontSize: 15,
              color: AppTheme.ink(isDark),
              fontWeight: FontWeight.w600,
              height: 1.75,
            ),
          ),
          TextSpan(text: rest),
        ],
      ),
    );
  }

  Widget _buildRightTimeline() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(width: 24, height: 1.5, color: AppTheme.acc(isDark)),
            const SizedBox(width: 10),
            Text(
              'MY JOURNEY & GROWTH',
              style: GoogleFonts.ibmPlexMono(
                fontSize: 11,
                letterSpacing: 1.8,
                color: AppTheme.acc(isDark),
                fontWeight: FontWeight.bold,
              ),
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
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              if (!isLast)
                Container(
                  width: 1,
                  height: 64,
                  color: AppTheme.line(isDark),
                ),
            ],
          ),
        ),
        const SizedBox(width: 16),
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
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.title,
                  style: GoogleFonts.epilogue(
                    fontSize: 15,
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