import 'dart:async';
import 'package:flutter/material.dart';
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
        vsync: this, duration: const Duration(milliseconds: 800));
    _fadeAnim = CurvedAnimation(parent: _fadeIn, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(
            begin: const Offset(0, 0.05), end: Offset.zero)
        .animate(CurvedAnimation(parent: _fadeIn, curve: Curves.easeOut));
    _fadeIn.forward();
    _startTyping();
  }

  void _startTyping() {
    _timer = Timer.periodic(
        Duration(milliseconds: _deleting ? 55 : 95), (_) => _tick());
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
    final isWide = MediaQuery.of(context).size.width > 900;
    return Container(
      color: AppTheme.bg(widget.isDark),
      constraints: const BoxConstraints(minHeight: 600),
      child: Stack(
        children: [
          // Big watermark text
          Positioned(
            bottom: -20,
            right: -10,
            child: Text(
              'FLUTTER',
              style: GoogleFonts.bebasNeue(
                fontSize: 180,
                color: Colors.transparent,
                height: 1,
                shadows: [],
              ).copyWith(
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 1
                  ..color = AppTheme.line(widget.isDark),
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: isWide
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(child: _buildLeft()),
                          const SizedBox(width: 48),
                          _buildCard(),
                          const SizedBox(width: 32),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLeft(),
                          const SizedBox(height: 32),
                          _buildCard(),
                        ],
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeft() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Available tag
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppTheme.orangeDim(widget.isDark),
              border: Border.all(
                  color: AppTheme.orangeMid(widget.isDark), width: 1),
              borderRadius: BorderRadius.circular(3),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                BlinkingDot(color: AppTheme.acc(widget.isDark), size: 6),
                const SizedBox(width: 8),
                Text(
                  'Available for opportunities',
                  style: GoogleFonts.ibmPlexMono(
                    fontSize: 11,
                    color: AppTheme.acc(widget.isDark),
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Big name
          RichText(
            text: TextSpan(
              style: GoogleFonts.bebasNeue(
                fontSize: 88,
                letterSpacing: 2,
                height: 0.92,
                color: AppTheme.ink(widget.isDark),
              ),
              children: [
                const TextSpan(text: 'Syed\n'),
                TextSpan(
                  text: 'Faireena\n',
                  style: TextStyle(color: AppTheme.acc(widget.isDark)),
                ),
                const TextSpan(text: 'Zaidi'),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Typing role
          Row(
            children: [
              Container(
                  width: 32, height: 1.5, color: AppTheme.acc(widget.isDark)),
              const SizedBox(width: 12),
              _TypingText(typed: _typed, isDark: widget.isDark),
            ],
          ),
          const SizedBox(height: 24),
          // Description
          Text(
            'Cross-platform mobile developer at ',
            style: GoogleFonts.epilogue(
                fontSize: 15,
                color: AppTheme.ink2(widget.isDark),
                fontWeight: FontWeight.w300,
                height: 1.75),
          ),
          RichText(
            text: TextSpan(
              style: GoogleFonts.epilogue(
                  fontSize: 15,
                  color: AppTheme.ink2(widget.isDark),
                  fontWeight: FontWeight.w300,
                  height: 1.75),
              children: [
                TextSpan(
                  text: 'Criterion Tech Pvt Ltd, Lucknow',
                  style: GoogleFonts.epilogue(
                      fontSize: 15,
                      color: AppTheme.ink(widget.isDark),
                      fontWeight: FontWeight.w600),
                ),
                const TextSpan(text: '.\nBuilding '),
                TextSpan(
                  text: 'production-ready Android & iOS apps',
                  style: GoogleFonts.epilogue(
                      fontSize: 15,
                      color: AppTheme.ink(widget.isDark),
                      fontWeight: FontWeight.w600),
                ),
                const TextSpan(
                    text:
                        ' with Flutter, Dart, GetX, REST APIs, and Firebase — one pixel-perfect widget at a time.'),
              ],
            ),
          ),
          const SizedBox(height: 32),
          // Buttons
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              OrangeButton(
                label: 'VIEW PROJECTS →',
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
          const SizedBox(height: 32),
          // Social icons
          Row(
            children: [
              SocialBtn(
                icon: const Icon(Icons.email_outlined),
                tooltip: 'Email',
                isDark: widget.isDark,
                onTap: () =>
                    launchUrl(Uri.parse('mailto:fairenazaidi@gmail.com')),
              ),
              const SizedBox(width: 10),
              SocialBtn(
                icon: const Icon(Icons.code),
                tooltip: 'GitHub',
                isDark: widget.isDark,
                onTap: () => launchUrl(Uri.parse('https://github.com/')),
              ),
              const SizedBox(width: 10),
              SocialBtn(
                icon: const Icon(Icons.work_outline),
                tooltip: 'LinkedIn',
                isDark: widget.isDark,
                onTap: () =>
                    launchUrl(Uri.parse('https://linkedin.com/in/')),
              ),
              const SizedBox(width: 10),
              SocialBtn(
                icon: const Icon(Icons.chat_bubble_outline),
                tooltip: 'WhatsApp',
                isDark: widget.isDark,
                onTap: () =>
                    launchUrl(Uri.parse('https://wa.me/918173822136')),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCard() {
    return Container(
      width: 320,
      decoration: BoxDecoration(
        color: AppTheme.cardBg(widget.isDark),
        border: Border.all(color: AppTheme.line(widget.isDark)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Card top (orange)
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppTheme.acc(widget.isDark),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(8)),
            ),
             child:  Row(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: Center(
                      child: Text(
                        'FZ',
                        style: GoogleFonts.bebasNeue(
                          fontSize: 22,
                          letterSpacing: 1.5,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // 🔥 FIX HERE
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Faireena Zaidi',
                          style: GoogleFonts.bebasNeue(
                            fontSize: 18,
                            letterSpacing: 1.2,
                            color: Colors.white,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'Flutter Developer · Lucknow, UP',
                          style: GoogleFonts.epilogue(
                            fontSize: 12,
                            color: Colors.white.withOpacity(0.75),
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              )
          ),
          // Card rows
          _cardRow('STATUS', widget.isDark, isLive: true),
          _cardRow('COMPANY', widget.isDark, value: 'Criterion Tech Pvt Ltd'),
          _cardRow('ROLE', widget.isDark, value: 'Flutter Developer'),
          _cardRow('SINCE', widget.isDark, value: 'Sep 2024'),
          _cardRow('EDUCATION', widget.isDark, value: 'BCA · ERA University'),
          _cardRow('EMAIL', widget.isDark,
              value: 'fairenazaidi@gmail.com', small: true),
          // Chips footer
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: AppTheme.line(widget.isDark))),
            ),
            child: Wrap(
              spacing: 6,
              runSpacing: 6,
              children: ['Flutter', 'Dart', 'GetX', 'Firebase', 'REST API']
                  .map((t) => PortfolioChip(
                      label: t, isDark: widget.isDark, filled: true))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cardRow(String label, bool isDark,
      {String? value, bool isLive = false, bool small = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: AppTheme.line(isDark))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.ibmPlexMono(
                fontSize: 11,
                letterSpacing: 1,
                color: AppTheme.ink3(isDark)),
          ),
          if (isLive)
            Row(
              children: [
                BlinkingDot(color: AppTheme.acc(isDark), size: 6),
                const SizedBox(width: 6),
                Text('Actively Working',
                    style: GoogleFonts.epilogue(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.acc(isDark))),
              ],
            )
          else
            Text(
              value ?? '',
              style: GoogleFonts.epilogue(
                  fontSize: small ? 12 : 13,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.ink(isDark)),
            ),
        ],
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
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 2),
        AnimatedBuilder(
          animation: _blinkAnim,
          builder: (_, __) => Opacity(
            opacity: _blinkAnim.value,
            child: Container(
              width: 2,
              height: 15,
              color: AppTheme.acc(widget.isDark),
            ),
          ),
        ),
      ],
    );
  }
}
