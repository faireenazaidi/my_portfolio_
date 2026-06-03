import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';

class PortfolioFooter extends StatelessWidget {
  final bool isDark;
  final Function(String) onNav;

  const PortfolioFooter(
      {super.key, required this.isDark, required this.onNav});

  @override
  Widget build(BuildContext context) {
    final bgColor = isDark ? AppTheme.bg3Dark : AppTheme.inkLight;
    final textColor =
        isDark ? AppTheme.inkDark : const Color(0xFFF5F2EC);
    final subColor = isDark
        ? AppTheme.ink3Dark
        : const Color(0xFFF5F2EC).withOpacity(0.45);
    final headColor = isDark
        ? AppTheme.ink3Dark
        : const Color(0xFFF5F2EC).withOpacity(0.35);
    final linkColor = isDark
        ? AppTheme.ink3Dark
        : const Color(0xFFF5F2EC).withOpacity(0.5);

    final isWide = MediaQuery.of(context).size.width > 700;

    return Container(
      color: bgColor,
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
      child: Column(
        children: [
          isWide
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 2, child: _buildBrand(textColor, subColor)),
                    const SizedBox(width: 40),
                    Expanded(
                        child: _buildLinks('Navigate', headColor, linkColor, [
                      'About',
                      'Skills',
                      'Experience',
                      'Projects',
                      'Education',
                      'Contact'
                    ], onNav)),
                    const SizedBox(width: 40),
                    Expanded(
                        child:
                            _buildLinks('Connect', headColor, linkColor, [], null,
                                socials: true, isDark: isDark)),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildBrand(textColor, subColor),
                    const SizedBox(height: 32),
                    _buildLinks('Navigate', headColor, linkColor, [
                      'About', 'Skills', 'Experience',
                      'Projects', 'Education', 'Contact'
                    ], onNav),
                  ],
                ),
          const SizedBox(height: 32),
          Divider(
            color: isDark
                ? AppTheme.line(isDark)
                : Colors.white.withOpacity(0.08),
            height: 1,
          ),
          const SizedBox(height: 20),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Flexible(
          //       child: Text(
          //         '© 2025 Syed Faireena Abbas Zaidi. All rights reserved.',
          //         style: GoogleFonts.epilogue(
          //           fontSize: 12,
          //           color: isDark
          //               ? AppTheme.ink3Dark
          //               : const Color(0xFFF5F2EC).withOpacity(0.3),
          //         ),
          //       ),
          //     ),
          //     const SizedBox(width: 12),
          //     Flexible(
          //       child: Text(
          //         'Flutter Developer · Lucknow, India',
          //         textAlign: TextAlign.right,
          //         style: GoogleFonts.ibmPlexMono(
          //           fontSize: 11,
          //           color: isDark
          //               ? AppTheme.ink3Dark
          //               : const Color(0xFFF5F2EC).withOpacity(0.3),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          isWide
              ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '© 2025 Syed Faireena Abbas Zaidi. All rights reserved.',
                style: GoogleFonts.epilogue(
                  fontSize: 12,
                  color: isDark
                      ? AppTheme.ink3Dark
                      : const Color(0xFFF5F2EC).withOpacity(0.3),
                ),),
              Text(
                'Flutter Developer · Lucknow, India',
                textAlign: TextAlign.right,
                style: GoogleFonts.ibmPlexMono(
                  fontSize: 11,
                  color: isDark
                      ? AppTheme.ink3Dark
                      : const Color(0xFFF5F2EC).withOpacity(0.3),
                ),
              ),
            ],
          ) : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '© 2025 Syed Faireena Abbas Zaidi. All rights reserved.',
                style: GoogleFonts.epilogue(
                  fontSize: 12,
                  color: isDark
                      ? AppTheme.ink3Dark
                      : const Color(0xFFF5F2EC).withOpacity(0.3),
                ),),
              const SizedBox(height: 6),
              Text(
                'Flutter Developer · Lucknow, India',
                textAlign: TextAlign.right,
                style: GoogleFonts.ibmPlexMono(
                  fontSize: 11,
                  color: isDark
                      ? AppTheme.ink3Dark
                      : const Color(0xFFF5F2EC).withOpacity(0.3),
                ),
              ),
            ],
          )

        ],
      ),
    );
  }

  Widget _buildBrand(Color textColor, Color subColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: GoogleFonts.bebasNeue(
                fontSize: 28, letterSpacing: 2, color: textColor),
            children: [
              const TextSpan(text: 'FA'),
              TextSpan(
                text: '.',
                style: TextStyle(color: AppTheme.acc(isDark)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Flutter Developer at Criterion Tech Pvt Ltd, Lucknow. Building cross-platform mobile apps with clean code and attention to detail.',
          style: GoogleFonts.epilogue(
              fontSize: 13, color: subColor, height: 1.7),
          maxLines: 4,
        ),
      ],
    );
  }

  Widget _buildLinks(
    String heading,
    Color headColor,
    Color linkColor,
    List<String> items,
    Function(String)? onNav, {
    bool socials = false,
    bool isDark = false,
  }) {
    final socialItems = [
      {'label': 'Email', 'url': 'mailto:fairenazaidi@gmail.com'},
      {'label': 'GitHub', 'url': 'https://github.com/'},
      {'label': 'LinkedIn', 'url': 'https://linkedin.com/in/'},
      {'label': 'WhatsApp', 'url': 'https://wa.me/918173822136'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          heading.toUpperCase(),
          style: GoogleFonts.ibmPlexMono(
              fontSize: 10, letterSpacing: 2, color: headColor),
        ),
        const SizedBox(height: 16),
        ...(socials ? socialItems : items.map((i) => {'label': i, 'url': null}).toList())
            .map((item) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _FootLink(
                    label: item['label'] as String,
                    isDark: this.isDark,
                    onTap: socials
                        ? () => launchUrl(Uri.parse(item['url'] as String))
                        : () => onNav?.call(
                            (item['label'] as String).toLowerCase()),
                    linkColor: linkColor,
                  ),
                )),
      ],
    );
  }
}

class _FootLink extends StatefulWidget {
  final String label;
  final bool isDark;
  final VoidCallback? onTap;
  final Color linkColor;

  const _FootLink({
    required this.label,
    required this.isDark,
    this.onTap,
    required this.linkColor,
  });

  @override
  State<_FootLink> createState() => _FootLinkState();
}

class _FootLinkState extends State<_FootLink> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Text(
          widget.label,
          style: GoogleFonts.epilogue(
            fontSize: 13,
            color: _hover ? AppTheme.acc(widget.isDark) : widget.linkColor,
          ),
        ),
      ),
    );
  }
}
