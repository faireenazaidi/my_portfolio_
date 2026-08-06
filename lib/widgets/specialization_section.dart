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
    final isMobile = w <= 600;
    final cols = w > 1000 ? 4 : w > 650 ? 2 : 1;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 48 : 80,
        horizontal: isMobile ? 16 : 32,
      ),
      decoration: BoxDecoration(
        color: AppTheme.bg2(isDark),
        border: Border(top: BorderSide(color: AppTheme.line(isDark))),
      ),
      child: MaxContentContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(
              tag: 'What I Build',
              title: 'Core Specializations',
              subtitle:
                  'Delivering production-grade cross-platform mobile solutions tailored for scalability and performance.',
              isDark: isDark,
            ),
            const SizedBox(height: 36),
            LayoutBuilder(
              builder: (ctx, constraints) {
                if (cols == 1) {
                  return Column(
                    children: kSpecializations
                        .map(
                          (item) => Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: _SpecializationCard(
                              item: item,
                              isDark: isDark,
                              isMobile: isMobile,
                              isIntrinsic: false,
                            ),
                          ),
                        )
                        .toList(),
                  );
                }

                List<Widget> cardRows = [];
                for (int i = 0; i < kSpecializations.length; i += cols) {
                  final chunk = kSpecializations.sublist(
                    i,
                    (i + cols) < kSpecializations.length
                        ? (i + cols)
                        : kSpecializations.length,
                  );
                  final itemW =
                      (constraints.maxWidth - (cols - 1) * 20) / cols;

                  cardRows.add(
                    IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          for (int j = 0; j < chunk.length; j++) ...[
                            if (j > 0) const SizedBox(width: 20),
                            SizedBox(
                              width: itemW,
                              child: _SpecializationCard(
                                item: chunk[j],
                                isDark: isDark,
                                isMobile: isMobile,
                                isIntrinsic: true,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                  if (i + cols < kSpecializations.length) {
                    cardRows.add(const SizedBox(height: 20));
                  }
                }

                return Column(children: cardRows);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _SpecializationCard extends StatelessWidget {
  final SpecializationItem item;
  final bool isDark;
  final bool isMobile;
  final bool isIntrinsic;

  const _SpecializationCard({
    required this.item,
    required this.isDark,
    this.isMobile = false,
    this.isIntrinsic = false,
  });

  @override
  Widget build(BuildContext context) {
    return HoverCard(
      isDark: isDark,
      height: isIntrinsic ? double.infinity : null,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 20,
        vertical: isMobile ? 16 : 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: isIntrinsic
            ? MainAxisAlignment.spaceBetween
            : MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppTheme.orangeDim(isDark),
                  border: Border.all(color: AppTheme.orangeMid(isDark)),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Center(
                  child: Icon(
                    item.icon,
                    size: 18,
                    color: AppTheme.acc(isDark),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                item.title,
                style: GoogleFonts.bebasNeue(
                  fontSize: isMobile ? 20 : 22,
                  letterSpacing: 1.1,
                  color: AppTheme.ink(isDark),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                item.description,
                style: GoogleFonts.epilogue(
                  fontSize: 12.5,
                  color: AppTheme.ink2(isDark),
                  fontWeight: FontWeight.w300,
                  height: 1.45,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Divider(color: AppTheme.line(isDark), height: 1),
              const SizedBox(height: 10),
              ...item.highlights.map(
                (h) => Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '✓ ',
                        style: TextStyle(
                          color: AppTheme.acc(isDark),
                          fontSize: 11.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          h,
                          style: GoogleFonts.epilogue(
                            fontSize: 11.5,
                            color: AppTheme.ink3(isDark),
                            fontWeight: FontWeight.w400,
                            height: 1.35,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
