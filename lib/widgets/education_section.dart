import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../models/content.dart';
import 'common_widgets.dart';

class EducationSection extends StatelessWidget {
  final bool isDark;
  const EducationSection({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(

      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 32),
      decoration: BoxDecoration(
        color: AppTheme.bg(isDark),
        border: Border(top: BorderSide(color: AppTheme.line(isDark))),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            tag: 'Education',
            title: 'Academic\nBackground',
            subtitle:
                'A consistent academic record across Science, Mathematics, and Computer Applications.',
            isDark: isDark,
          ),
          const SizedBox(height: 40),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppTheme.line(isDark)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: kEducation.asMap().entries.map((e) {
                final i = e.key;
                final item = e.value;
                return _EduRow(
                  item: item,
                  isDark: isDark,
                  isLast: i == kEducation.length - 1,
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _EduRow extends StatefulWidget {
  final dynamic item;
  final bool isDark;
  final bool isLast;
  const _EduRow(
      {required this.item, required this.isDark, required this.isLast});

  @override
  State<_EduRow> createState() => _EduRowState();
}

class _EduRowState extends State<_EduRow> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 700;
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
        decoration: BoxDecoration(
          color: _hover
              ? AppTheme.bg2(widget.isDark)
              : AppTheme.cardBg(widget.isDark),
          border: !widget.isLast
              ? Border(
                  bottom: BorderSide(color: AppTheme.line(widget.isDark)))
              : null,
          borderRadius: widget.isLast
              ? const BorderRadius.vertical(bottom: Radius.circular(8))
              : (kEducation.indexOf(widget.item) == 0
                  ? const BorderRadius.vertical(top: Radius.circular(8))
                  : BorderRadius.zero),
        ),
        child: Row(
          children: [
            if (isWide) ...[
              SizedBox(
                width: 64,
                child: Text(
                  widget.item.year,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.bebasNeue(
                    fontSize: 22,
                    letterSpacing: 1.5,
                    color: AppTheme.acc(widget.isDark),
                    height: 1,
                  ),
                ),
              ),
              const SizedBox(width: 24),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.item.degree,
                    style: GoogleFonts.epilogue(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.ink(widget.isDark)),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.item.institution,
                    style: GoogleFonts.ibmPlexMono(
                        fontSize: 12,
                        color: AppTheme.ink3(widget.isDark),
                        letterSpacing: 0.5),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 24),
            RichText(
              text: TextSpan(
                style: GoogleFonts.bebasNeue(
                    fontSize: 28,
                    letterSpacing: 1.5,
                    color: AppTheme.ink(widget.isDark)),
                children: [
                  TextSpan(
                    text: widget.item.score.replaceAll('%', ''),
                    style: TextStyle(color: AppTheme.acc(widget.isDark)),
                  ),
                  const TextSpan(text: '%'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
