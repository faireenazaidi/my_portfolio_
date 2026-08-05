import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../models/content.dart';
import '../models/portfolio_data.dart';
import 'common_widgets.dart';

class SpecializationSection extends StatelessWidget {
  final bool isDark;
  const SpecializationSection({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final cols = w > 1000 ? 4 : w > 650 ? 2 : 1;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 32),
      decoration: BoxDecoration(
        color: AppTheme.bg2(isDark),
        border: Border(top: BorderSide(color: AppTheme.line(isDark))),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            tag: 'What I Build',
            title: 'Core Specializations',
            subtitle:
                'Delivering production-grade cross-platform mobile solutions tailored for scalability, performance, and user engagement.',
            isDark: isDark,
          ),
          const SizedBox(height: 40),
          LayoutBuilder(
            builder: (ctx, constraints) {
              final itemW =
                  (constraints.maxWidth - (cols - 1) * 20) / cols;
              return Wrap(
                spacing: 20,
                runSpacing: 20,
                children: kSpecializations
                    .map(
                      (item) => SizedBox(
                        width: itemW,
                        child: _SpecializationCard(
                          item: item,
                          isDark: isDark,
                        ),
                      ),
                    )
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _SpecializationCard extends StatefulWidget {
  final SpecializationItem item;
  final bool isDark;

  const _SpecializationCard({
    required this.item,
    required this.isDark,
  });

  @override
  State<_SpecializationCard> createState() => _SpecializationCardState();
}

class _SpecializationCardState extends State<_SpecializationCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    final isDark = widget.isDark;

    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        transform: Matrix4.translationValues(0, _hover ? -4 : 0, 0),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppTheme.cardBg(isDark),
          border: Border.all(
            color: _hover ? AppTheme.acc(isDark) : AppTheme.line(isDark),
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(8),
          boxShadow: _hover
              ? [
                  BoxShadow(
                    color: AppTheme.acc(isDark).withOpacity(0.1),
                    blurRadius: 30,
                    offset: const Offset(0, 10),
                  )
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppTheme.orangeDim(isDark),
                border: Border.all(color: AppTheme.orangeMid(isDark)),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Center(
                child: Text(
                  item.icon,
                  style: const TextStyle(fontSize: 22),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              item.title,
              style: GoogleFonts.bebasNeue(
                fontSize: 24,
                letterSpacing: 1.2,
                color: AppTheme.ink(isDark),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              item.description,
              style: GoogleFonts.epilogue(
                fontSize: 13,
                color: AppTheme.ink2(isDark),
                fontWeight: FontWeight.w300,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 16),
            Divider(color: AppTheme.line(isDark), height: 1),
            const SizedBox(height: 14),
            ...item.highlights.map(
              (h) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '✓ ',
                      style: TextStyle(
                        color: AppTheme.acc(isDark),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        h,
                        style: GoogleFonts.epilogue(
                          fontSize: 12,
                          color: AppTheme.ink3(isDark),
                          fontWeight: FontWeight.w400,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
