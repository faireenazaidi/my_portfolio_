import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../models/content.dart';
import '../models/portfolio_data.dart';

class StatsSection extends StatelessWidget {
  final bool isDark;
  const StatsSection({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final bgColor = isDark ? AppTheme.bg3Dark : AppTheme.inkLight;
    final w = MediaQuery.of(context).size.width;
    final cols = w > 700 ? 4 : 2;

    return Container(
      color: bgColor,
      child: LayoutBuilder(builder: (ctx, constraints) {
        final itemW = constraints.maxWidth / cols;
        return Wrap(
          children: kStats.asMap().entries.map((e) {
            final i = e.key;
            final s = e.value;
            return _StatItem(
              stat: s,
              isDark: isDark,
              width: itemW,
              showRightBorder: (i + 1) % cols != 0,
            );
          }).toList(),
        );
      }),
    );
  }
}

class _StatItem extends StatefulWidget {
  final StatItem stat;
  final bool isDark;
  final double width;
  final bool showRightBorder;

  const _StatItem({
    required this.stat,
    required this.isDark,
    required this.width,
    required this.showRightBorder,
  });

  @override
  State<_StatItem> createState() => _StatItemState();
}

class _StatItemState extends State<_StatItem> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final textColor = widget.isDark
        ? AppTheme.inkDark
        : const Color(0xFFF5F2EC);
    final labelColor = widget.isDark
        ? AppTheme.ink3Dark
        : const Color(0xFFF5F2EC).withOpacity(0.5);

    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: widget.width,
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
        decoration: BoxDecoration(
          color: _hover
              ? AppTheme.acc(widget.isDark).withOpacity(0.08)
              : Colors.transparent,
          border: Border(
            right: widget.showRightBorder
                ? BorderSide(
                    color: widget.isDark
                        ? AppTheme.line(widget.isDark)
                        : Colors.white.withOpacity(0.1))
                : BorderSide.none,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RichText(
              text: TextSpan(
                style: GoogleFonts.bebasNeue(
                  fontSize: 64,
                  letterSpacing: 1.5,
                  height: 1,
                  color: textColor,
                ),
                children: [
                  TextSpan(
                    text: widget.stat.number,
                    style: TextStyle(color: AppTheme.acc(widget.isDark)),
                  ),
                  TextSpan(text: widget.stat.suffix),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.stat.label.toUpperCase(),
              textAlign: TextAlign.center,
              style: GoogleFonts.epilogue(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.5,
                color: labelColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
