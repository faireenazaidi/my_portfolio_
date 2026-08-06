import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';
import '../models/content.dart';
import 'common_widgets.dart';

class HeroSection extends StatefulWidget {
  final bool isDark;
  final VoidCallback onViewProjects;
  final VoidCallback onContact;

  const HeroSection({
    super.key,
    required this.isDark,
    required this.onViewProjects,
    required this.onContact,
  });

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  int _roleIndex = 0;
  int _charIndex = 0;
  bool _deleting = false;
  String _typed = '';
  Timer? _timer;
  late AnimationController _fadeIn;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _fadeIn = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _fadeAnim = CurvedAnimation(parent: _fadeIn, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.05),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _fadeIn, curve: Curves.easeOut));
    _fadeIn.forward();
    _startTyping();
  }

  void _startTyping() {
    _timer = Timer.periodic(
      Duration(milliseconds: _deleting ? 45 : 85),
      (_) => _tick(),
    );
  }

  void _tick() {
    if (!mounted) return;
    final cur = kRoles[_roleIndex];
    setState(() {
      if (!_deleting) {
        _charIndex++;
        _typed = cur.substring(0, _charIndex.clamp(0, cur.length));
        if (_charIndex >= cur.length) {
          _deleting = true;
          _timer?.cancel();
          Future.delayed(const Duration(milliseconds: 1800), () {
            if (mounted) {
              _timer?.cancel();
              _startTyping();
            }
          });
        }
      } else {
        _charIndex--;
        _typed = cur.substring(0, _charIndex.clamp(0, cur.length));
        if (_charIndex <= 0) {
          _deleting = false;
          _roleIndex = (_roleIndex + 1) % kRoles.length;
          _timer?.cancel();
          _startTyping();
        }
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _fadeIn.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isWide = w > 900;
    final isMobile = w <= 600;

    return Container(
      color: AppTheme.bg(widget.isDark),
      constraints: BoxConstraints(minHeight: isMobile ? 480 : 640),
      child: Stack(
        children: [
          // Background watermark
          if (!isMobile)
            Positioned(
              bottom: -20,
              right: -10,
              child: IgnorePointer(
                child: Text(
                  'FLUTTER',
                  style: GoogleFonts.bebasNeue(
                    fontSize: 210,
                    color: Colors.transparent,
                    height: 1,
                  ).copyWith(
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 1
                      ..color = AppTheme.line(widget.isDark),
                  ),
                ),
              ),
            ),
          // Right border line
          Positioned(
            top: 0,
            right: 0,
            bottom: 0,
            child: Container(width: 1, color: AppTheme.line(widget.isDark)),
          ),
          FadeTransition(
            opacity: _fadeAnim,
            child: SlideTransition(
              position: _slideAnim,
              child: MaxContentContainer(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 16 : 32,
                    vertical: isMobile ? 32 : 48,
                  ),
                  child: isWide
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(child: _buildLeft(isMobile)),
                            const SizedBox(width: 48),
                            _buildIdeCard(isMobile),
                            const SizedBox(width: 16),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLeft(isMobile),
                            const SizedBox(height: 32),
                            _buildIdeCard(isMobile),
                          ],
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeft(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Available for opportunities tag
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppTheme.orangeDim(widget.isDark),
            border: Border.all(
                color: AppTheme.orangeMid(widget.isDark), width: 1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              BlinkingDot(color: AppTheme.acc(widget.isDark), size: 6),
              const SizedBox(width: 8),
              Text(
                'AVAILABLE FOR OPPORTUNITIES',
                style: GoogleFonts.ibmPlexMono(
                  fontSize: isMobile ? 10 : 11,
                  color: AppTheme.acc(widget.isDark),
                  letterSpacing: 1,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Strong Hierarchy Header
        Text(
          'FLUTTER DEVELOPER',
          style: GoogleFonts.ibmPlexMono(
            fontSize: isMobile ? 12 : 14,
            fontWeight: FontWeight.bold,
            letterSpacing: isMobile ? 2 : 3,
            color: AppTheme.acc(widget.isDark),
          ),
        ),
        const SizedBox(height: 6),
        RichText(
          text: TextSpan(
            style: GoogleFonts.bebasNeue(
              fontSize: isMobile ? 48 : 76,
              letterSpacing: 2,
              height: 0.92,
              color: AppTheme.ink(widget.isDark),
            ),
            children: [
              const TextSpan(text: 'Syed '),
              TextSpan(
                text: 'Faireena\n',
                style: TextStyle(color: AppTheme.acc(widget.isDark)),
              ),
              const TextSpan(text: 'Zaidi'),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // Tagline & Typing role
        Row(
          children: [
            Container(
                width: 24, height: 1.5, color: AppTheme.acc(widget.isDark)),
            const SizedBox(width: 10),
            _TypingText(typed: _typed, isDark: widget.isDark),
          ],
        ),
        const SizedBox(height: 16),

        // Description / Value Proposition
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 580),
          child: Text(
            'Flutter Developer at Criterion Tech Pvt Ltd. Crafting production-grade cross-platform apps for Android & iOS with pixel-perfect Figma UI, REST APIs, GetX, and Firebase.',
            style: GoogleFonts.epilogue(
              fontSize: isMobile ? 14 : 15,
              color: AppTheme.ink2(widget.isDark),
              fontWeight: FontWeight.w300,
              height: 1.6,
            ),
          ),
        ),
        const SizedBox(height: 24),

        // CTA Buttons
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            OrangeButton(
              label: 'VIEW MY WORK ➔',
              onTap: widget.onViewProjects,
              isDark: widget.isDark,
            ),
            OutlineButton2(
              label: '↓ RESUME',
              isDark: widget.isDark,
              onTap: () async {
                final url = Uri.parse(
                  'https://drive.google.com/file/d/1fhjghU9NKYepW0N6fObXyyXCgRkhwIsn/view?usp=drivesdk',
                );
                await launchUrl(url, mode: LaunchMode.platformDefault);
              },
            ),
            OutlineButton2(
              label: "LET'S TALK",
              onTap: widget.onContact,
              isDark: widget.isDark,
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Social Icons Row
        Row(
          children: [
            Text(
              'CONNECT: ',
              style: GoogleFonts.ibmPlexMono(
                fontSize: 11,
                letterSpacing: 1.2,
                color: AppTheme.ink3(widget.isDark),
              ),
            ),
            const SizedBox(width: 8),
            SocialBtn(
              icon: const Icon(FontAwesomeIcons.github, size: 16),
              tooltip: 'GitHub Profile',
              isDark: widget.isDark,
              onTap: () => launchUrl(Uri.parse('https://github.com/faireenazaidi')),
            ),
            const SizedBox(width: 10),
            SocialBtn(
              icon: const Icon(FontAwesomeIcons.linkedinIn, size: 16),
              tooltip: 'LinkedIn Profile',
              isDark: widget.isDark,
              onTap: () => launchUrl(Uri.parse('https://linkedin.com/in/')),
            ),
            const SizedBox(width: 10),
            SocialBtn(
              icon: const Icon(FontAwesomeIcons.envelope, size: 16),
              tooltip: 'Send Email',
              isDark: widget.isDark,
              onTap: () => launchUrl(Uri.parse('mailto:fairenazaidi@gmail.com')),
            ),
            const SizedBox(width: 10),
            SocialBtn(
              icon: const Icon(FontAwesomeIcons.whatsapp, size: 16),
              tooltip: 'WhatsApp Chat',
              isDark: widget.isDark,
              onTap: () => launchUrl(Uri.parse('https://wa.me/918173822136')),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildIdeCard(bool isMobile) {
    return Container(
      width: isMobile ? double.infinity : 360,
      decoration: BoxDecoration(
        color: AppTheme.cardBg(widget.isDark),
        border: Border.all(color: AppTheme.line(widget.isDark)),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // IDE Window bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: widget.isDark
                  ? const Color(0xFF1E1B18)
                  : const Color(0xFFE5E1D8),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(9)),
            ),
            child: Row(
              children: [
                _dot(const Color(0xFFFF5F56)),
                const SizedBox(width: 6),
                _dot(const Color(0xFFFFBD2E)),
                const SizedBox(width: 6),
                _dot(const Color(0xFF27C93F)),
                const SizedBox(width: 14),
                Text(
                  'faireena_developer.dart',
                  style: GoogleFonts.ibmPlexMono(
                    fontSize: 11,
                    color: AppTheme.ink3(widget.isDark),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          // Code Window Content
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _codeLine('class ', 'FlutterDeveloper', ' {'),
                _codeProp('  final String ', 'name', " = 'Syed Faireena Zaidi';"),
                _codeProp('  final String ', 'company', " = 'Criterion Tech';"),
                _codeProp('  final int ', 'appsShipped', " = 3; // Play Store"),
                _codeProp('  final List<String> ', 'stack', " = ["),
                _codeArrayItem("    'Flutter'", "    'Dart',"),
                _codeArrayItem("    'GetX'", "    'Firebase',"),
                _codeArrayItem("    'REST APIs'", "    'Material 3'"),
                _codeProp('  ', '];', ''),
                _codeLine('}', '', ''),
                const SizedBox(height: 16),
                Divider(color: AppTheme.line(widget.isDark), height: 1),
                const SizedBox(height: 14),

                // Card Footer Details
                Row(
                  children: [
                    BlinkingDot(color: AppTheme.acc(widget.isDark), size: 8),
                    const SizedBox(width: 8),
                    Text(
                      'STATUS: Active Developer',
                      style: GoogleFonts.ibmPlexMono(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.acc(widget.isDark),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  'Lucknow, UP · Criterion Tech Pvt Ltd',
                  style: GoogleFonts.epilogue(
                    fontSize: 12,
                    color: AppTheme.ink3(widget.isDark),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _dot(Color c) => Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(color: c, shape: BoxShape.circle),
      );

  Widget _codeLine(String keyword, String identifier, String rest) {
    return RichText(
      text: TextSpan(
        style: GoogleFonts.ibmPlexMono(fontSize: 12),
        children: [
          TextSpan(
            text: keyword,
            style: TextStyle(
                color: AppTheme.acc(widget.isDark),
                fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: identifier,
            style: TextStyle(
                color: AppTheme.ink(widget.isDark),
                fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: rest,
            style: TextStyle(color: AppTheme.ink3(widget.isDark)),
          ),
        ],
      ),
    );
  }

  Widget _codeProp(String prefix, String prop, String val) {
    return RichText(
      text: TextSpan(
        style: GoogleFonts.ibmPlexMono(fontSize: 11.5),
        children: [
          TextSpan(
            text: prefix,
            style: TextStyle(color: AppTheme.acc(widget.isDark)),
          ),
          TextSpan(
            text: prop,
            style: TextStyle(color: AppTheme.ink(widget.isDark)),
          ),
          TextSpan(
            text: val,
            style: TextStyle(color: AppTheme.ink3(widget.isDark)),
          ),
        ],
      ),
    );
  }

  Widget _codeArrayItem(String left, String right) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Text(
        '$left $right',
        style: GoogleFonts.ibmPlexMono(
          fontSize: 11,
          color: widget.isDark ? const Color(0xFF9ECE6A) : const Color(0xFF2E7D32),
        ),
      ),
    );
  }
}

class _TypingText extends StatefulWidget {
  final String typed;
  final bool isDark;
  const _TypingText({required this.typed, required this.isDark});

  @override
  State<_TypingText> createState() => _TypingTextState();
}

class _TypingTextState extends State<_TypingText>
    with SingleTickerProviderStateMixin {
  late AnimationController _blink;
  late Animation<double> _blinkAnim;

  @override
  void initState() {
    super.initState();
    _blink = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 900));
    _blinkAnim = Tween<double>(begin: 1, end: 0).animate(_blink);
    _blink.repeat(reverse: true);
  }

  @override
  void dispose() {
    _blink.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.typed,
          style: GoogleFonts.ibmPlexMono(
            fontSize: 13,
            color: AppTheme.acc(widget.isDark),
            letterSpacing: 1,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 2),
        AnimatedBuilder(
          animation: _blinkAnim,
          builder: (_, __) => Opacity(
            opacity: _blinkAnim.value,
            child: Container(
              width: 2,
              height: 16,
              color: AppTheme.acc(widget.isDark),
            ),
          ),
        ),
      ],
    );
  }
}
