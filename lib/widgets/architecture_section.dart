import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../models/content.dart';
import '../models/portfolio_data.dart';
import 'common_widgets.dart';

class ArchitectureSection extends StatelessWidget {
  final bool isDark;
  const ArchitectureSection({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isWide = w > 900;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 32),
      decoration: BoxDecoration(
        color: AppTheme.bg(isDark),
        border: Border(top: BorderSide(color: AppTheme.line(isDark))),
      ),
      child: MaxContentContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(
              tag: 'Engineering Approach',
              title: 'Clean Architecture\n& Code Standards',
              subtitle:
                  'Building Flutter applications designed for long-term maintainability, strict separation of concerns, and clean data flow.',
              isDark: isDark,
            ),
            const SizedBox(height: 48),

            // Layer Flow Diagram
            _buildFlowDiagram(isWide),

            const SizedBox(height: 56),

            // Engineering Principle Cards Header
            Row(
              children: [
                Container(width: 24, height: 1.5, color: AppTheme.acc(isDark)),
                const SizedBox(width: 10),
                Text(
                  'CORE TECHNICAL PRINCIPLES',
                  style: GoogleFonts.ibmPlexMono(
                    fontSize: 11,
                    letterSpacing: 1.8,
                    color: AppTheme.acc(isDark),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Grid of Principle Cards
            LayoutBuilder(
              builder: (ctx, constraints) {
                final cols = w > 1100 ? 4 : w > 700 ? 2 : 1;
                if (cols == 1) {
                  return Column(
                    children: kEngineeringPrinciples
                        .map(
                          (p) => Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: _PrincipleCard(
                              principle: p,
                              isDark: isDark,
                            ),
                          ),
                        )
                        .toList(),
                  );
                }

                List<Widget> cardRows = [];
                for (int i = 0; i < kEngineeringPrinciples.length; i += cols) {
                  final chunk = kEngineeringPrinciples.sublist(
                    i,
                    (i + cols) < kEngineeringPrinciples.length
                        ? (i + cols)
                        : kEngineeringPrinciples.length,
                  );
                  final cardW =
                      (constraints.maxWidth - (cols - 1) * 16) / cols;

                  cardRows.add(
                    IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          for (int j = 0; j < chunk.length; j++) ...[
                            if (j > 0) const SizedBox(width: 16),
                            SizedBox(
                              width: cardW,
                              child: _PrincipleCard(
                                principle: chunk[j],
                                isDark: isDark,
                                isIntrinsic: true,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                  if (i + cols < kEngineeringPrinciples.length) {
                    cardRows.add(const SizedBox(height: 16));
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

  Widget _buildFlowDiagram(bool isWide) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.bg2(isDark),
        border: Border.all(color: AppTheme.line(isDark)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'DATA & LOGIC FLOW ARCHITECTURE',
            style: GoogleFonts.ibmPlexMono(
              fontSize: 11,
              letterSpacing: 1.8,
              color: AppTheme.acc(isDark),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 18),
          isWide
              ? IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: kArchitectureLayers.asMap().entries.map((e) {
                      final i = e.key;
                      final layer = e.value;
                      final isLast = i == kArchitectureLayers.length - 1;
                      return Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: _LayerNode(
                                layer: layer,
                                isDark: isDark,
                                height: double.infinity,
                              ),
                            ),
                            if (!isLast)
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                child: Text(
                                  '➔',
                                  style: TextStyle(
                                    color: AppTheme.acc(isDark),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                )
              : Column(
                  children: kArchitectureLayers.asMap().entries.map((e) {
                    final i = e.key;
                    final layer = e.value;
                    final isLast = i == kArchitectureLayers.length - 1;
                    return Column(
                      children: [
                        _LayerNode(layer: layer, isDark: isDark),
                        if (!isLast)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              '↓',
                              style: TextStyle(
                                color: AppTheme.acc(isDark),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    );
                  }).toList(),
                ),
        ],
      ),
    );
  }
}

class _LayerNode extends StatelessWidget {
  final ArchitectureLayerItem layer;
  final bool isDark;
  final double? height;

  const _LayerNode({
    required this.layer,
    required this.isDark,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.cardBg(isDark),
        border: Border.all(color: AppTheme.line(isDark)),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            layer.layerName,
            style: GoogleFonts.bebasNeue(
              fontSize: 17,
              letterSpacing: 1,
              color: AppTheme.acc(isDark),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            layer.subtitle,
            style: GoogleFonts.epilogue(
              fontSize: 10.5,
              fontWeight: FontWeight.w600,
              color: AppTheme.ink(isDark),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            layer.description,
            style: GoogleFonts.epilogue(
              fontSize: 10.5,
              color: AppTheme.ink3(isDark),
              height: 1.35,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _PrincipleCard extends StatefulWidget {
  final EngineeringPrincipleItem principle;
  final bool isDark;
  final bool isIntrinsic;

  const _PrincipleCard({
    required this.principle,
    required this.isDark,
    this.isIntrinsic = false,
  });

  @override
  State<_PrincipleCard> createState() => _PrincipleCardState();
}

class _PrincipleCardState extends State<_PrincipleCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final p = widget.principle;
    final isDark = widget.isDark;

    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: widget.isIntrinsic ? double.infinity : null,
        transform: Matrix4.translationValues(0, _hover ? -3 : 0, 0),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.cardBg(isDark),
          border: Border.all(
            color: _hover ? AppTheme.acc(isDark) : AppTheme.line(isDark),
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppTheme.orangeDim(isDark),
                border: Border.all(color: AppTheme.orangeMid(isDark)),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Center(
                child: Icon(
                  p.icon,
                  size: 16,
                  color: AppTheme.acc(isDark),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    p.title,
                    style: GoogleFonts.epilogue(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.ink(isDark),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    p.description,
                    style: GoogleFonts.epilogue(
                      fontSize: 11.5,
                      color: AppTheme.ink2(isDark),
                      fontWeight: FontWeight.w300,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
