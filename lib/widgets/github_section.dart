import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';
import 'common_widgets.dart';

class GitHubSection extends StatelessWidget {
  final bool isDark;
  const GitHubSection({super.key, required this.isDark});

  final String _githubUrl = 'https://github.com/';

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isWide = w > 900;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 32),
      decoration: BoxDecoration(
        color: AppTheme.bg2(isDark),
        border: Border(top: BorderSide(color: AppTheme.line(isDark))),
      ),
      child: MaxContentContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(
              tag: 'Open Source & Code',
              title: 'GitHub & Repositories',
              subtitle:
                  'Explore my public code repositories, open source contributions, and Flutter code samples on GitHub.',
              isDark: isDark,
            ),
            const SizedBox(height: 40),
            HoverCard(
              isDark: isDark,
              padding: const EdgeInsets.all(32),
              child: isWide
                  ? Row(
                      children: [
                        Expanded(child: _buildInfo()),
                        const SizedBox(width: 40),
                        _buildCtaButton(),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInfo(),
                        const SizedBox(height: 24),
                        _buildCtaButton(),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: AppTheme.acc(isDark), size: 28),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                '@faireenazaidi on GitHub',
                style: GoogleFonts.bebasNeue(
                  fontSize: 28,
                  letterSpacing: 1.2,
                  color: AppTheme.ink(isDark),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          'I regularly share custom Flutter components, utility packages, clean architecture boilerplate code, and mobile experiment repositories.',
          style: GoogleFonts.epilogue(
            fontSize: 14,
            color: AppTheme.ink2(isDark),
            fontWeight: FontWeight.w300,
            height: 1.65,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: const [
            _RepoPill(label: '⭐ Flutter Utilities'),
            _RepoPill(label: '📦 GetX Architecture'),
            _RepoPill(label: '🚀 Play Store Apps'),
            _RepoPill(label: '🎨 Material 3 Widgets'),
          ],
        ),
      ],
    );
  }

  Widget _buildCtaButton() {
    return OrangeButton(
      label: 'VIEW GITHUB PROFILE ➔',
      isDark: isDark,
      onTap: () => launchUrl(Uri.parse(_githubUrl)),
    );
  }
}

class _RepoPill extends StatelessWidget {
  final String label;
  const _RepoPill({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: GoogleFonts.ibmPlexMono(
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
