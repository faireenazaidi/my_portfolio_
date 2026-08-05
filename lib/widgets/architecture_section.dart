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
              final cardW =
                  (constraints.maxWidth - (cols - 1) * 16) / cols;
              return Wrap(
                spacing: 16,
                runSpacing: 16,
                children: kEngineeringPrinciples
                    .map(
                      (p) => SizedBox(
                        width: cardW,
                        child: _PrincipleCard(
                          principle: p,
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

  Widget _buildFlowDiagram(bool isWide) {
    return Container(
      padding: const EdgeInsets.all(28),
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
          const SizedBox(height: 20),
          isWide
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: kArchitectureLayers.asMap().entries.map((e) {
                    final i = e.key;
                    final layer = e.value;
                    final isLast = i == kArchitectureLayers.length - 1;
                    return Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: _LayerNode(
                              layer: layer,
                              isDark: isDark,
                            ),
                          ),
                          if (!isLast)
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 6),
                              child: Text(
                                '➔',
                                style: TextStyle(
                                  color: AppTheme.acc(isDark),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  }).toList(),
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

  const _LayerNode({required this.layer, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppTheme.cardBg(isDark),
        border: Border.all(color: AppTheme.line(isDark)),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            layer.layerName,
            style: GoogleFonts.bebasNeue(
              fontSize: 18,
              letterSpacing: 1,
              color: AppTheme.acc(isDark),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            layer.subtitle,
            style: GoogleFonts.epilogue(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppTheme.ink(isDark),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            layer.description,
            style: GoogleFonts.epilogue(
              fontSize: 11,
              color: AppTheme.ink3(isDark),
              height: 1.4,
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

  const _PrincipleCard({required this.principle, required this.isDark});

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
        transform: Matrix4.translationValues(0, _hover ? -3 : 0, 0),
        padding: const EdgeInsets.all(18),
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
            Text(p.icon, style: const TextStyle(fontSize: 22)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    p.title,
                    style: GoogleFonts.epilogue(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.ink(isDark),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    p.description,
                    style: GoogleFonts.epilogue(
                      fontSize: 12,
                      color: AppTheme.ink2(isDark),
                      fontWeight: FontWeight.w300,
                      height: 1.5,
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
