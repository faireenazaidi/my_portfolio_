import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';
import 'common_widgets.dart';

class ResumeCtaSection extends StatelessWidget {
  final bool isDark;
  const ResumeCtaSection({super.key, required this.isDark});

  static const String kResumeUrl =
      'https://drive.google.com/file/d/1fhjghU9NKYepW0N6fObXyyXCgRkhwIsn/view?usp=drivesdk';

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isWide = w > 800;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 32),
      color: AppTheme.bg(isDark),
      child: MaxContentContainer(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isDark
                  ? [const Color(0xFF1E1C18), const Color(0xFF2A2620)]
                  : [const Color(0xFFEFECE6), const Color(0xFFE5E1D8)],
            ),
            border: Border.all(color: AppTheme.acc(isDark), width: 1.5),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: AppTheme.acc(isDark).withValues(alpha: 0.15),
                blurRadius: 36,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: isWide
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: _buildTextContent()),
                    const SizedBox(width: 32),
                    _buildDownloadButton(),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTextContent(),
                    const SizedBox(height: 24),
                    _buildDownloadButton(),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildTextContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            BlinkingDot(color: AppTheme.acc(isDark), size: 8),
            const SizedBox(width: 10),
            Text(
              'CURRICULUM VITAE & CAREER SUMMARY',
              style: GoogleFonts.ibmPlexMono(
                fontSize: 11,
                letterSpacing: 1.5,
                color: AppTheme.acc(isDark),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          'Want to review my full experience and skills?',
          style: GoogleFonts.bebasNeue(
            fontSize: 36,
            letterSpacing: 1.5,
            color: AppTheme.ink(isDark),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Download my resume for a detailed breakdown of my projects at Criterion Tech, educational background, and technical toolset.',
          style: GoogleFonts.epilogue(
            fontSize: 14,
            color: AppTheme.ink2(isDark),
            fontWeight: FontWeight.w300,
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildDownloadButton() {
    return OrangeButton(
      label: '↓  DOWNLOAD RESUME (PDF)',
      isDark: isDark,
      onTap: () async {
        final url = Uri.parse(kResumeUrl);
        await launchUrl(url, mode: LaunchMode.platformDefault);
      },
    );
  }
}
