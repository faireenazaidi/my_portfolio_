import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../models/content.dart';
import '../models/portfolio_data.dart';
import 'common_widgets.dart';

class SkillsSection extends StatefulWidget {
  final bool isDark;
  const SkillsSection({super.key, required this.isDark});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 900;
    final cat = kSkillCategories[_selected];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 32),
      decoration: BoxDecoration(
        color: AppTheme.bg2(widget.isDark),
        border: Border(top: BorderSide(color: AppTheme.line(widget.isDark))),
      ),
      child: Column(
        children: [
          SectionHeader(
            tag: 'Technical Capabilities',
            title: 'Skills & Tech Stack',
            subtitle:
                'Technologies, frameworks, and workflow tools used in production applications — zero fluff or artificial percentages.',
            isDark: widget.isDark,
            alignment: CrossAxisAlignment.center,
          ),
          const SizedBox(height: 48),
          isWide
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: 280, child: _buildNav()),
                    const SizedBox(width: 48),
                    Expanded(child: _buildPanel(cat)),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildNavWrap(),
                    const SizedBox(height: 24),
                    _buildPanel(cat),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildNav() {
    return Column(
      children: kSkillCategories.asMap().entries.map((e) {
        final i = e.key;
        final cat = e.value;
        return _SkillTab(
          label: '${cat.emoji}  ${cat.label}',
          isActive: _selected == i,
          isDark: widget.isDark,
          onTap: () => setState(() => _selected = i),
        );
      }).toList(),
    );
  }

  Widget _buildNavWrap() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: kSkillCategories.asMap().entries.map((e) {
        final i = e.key;
        final cat = e.value;
        return _SkillTab(
          label: '${cat.emoji} ${cat.label}',
          isActive: _selected == i,
          isDark: widget.isDark,
          onTap: () => setState(() => _selected = i),
          compact: true,
        );
      }).toList(),
    );
  }

  Widget _buildPanel(SkillCategory cat) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: _SkillPanel(
        key: ValueKey(cat.id),
        cat: cat,
        isDark: widget.isDark,
      ),
    );
  }
}

class _SkillTab extends StatefulWidget {
  final String label;
  final bool isActive;
  final bool isDark;
  final VoidCallback onTap;
  final bool compact;

  const _SkillTab({
    required this.label,
    required this.isActive,
    required this.isDark,
    required this.onTap,
    this.compact = false,
  });

  @override
  State<_SkillTab> createState() => _SkillTabState();
}

class _SkillTabState extends State<_SkillTab> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final active = widget.isActive || _hover;
    final isDark = widget.isDark;

    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: widget.compact ? null : double.infinity,
          padding: widget.compact
              ? const EdgeInsets.symmetric(horizontal: 14, vertical: 8)
              : const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          margin: widget.compact ? EdgeInsets.zero : const EdgeInsets.only(bottom: 4),
          decoration: BoxDecoration(
            color: active
                ? AppTheme.orangeDim(isDark)
                : AppTheme.cardBg(isDark),
            border: Border.all(
              color: active ? AppTheme.acc(isDark) : AppTheme.line(isDark),
            ),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            widget.label,
            style: GoogleFonts.epilogue(
              fontSize: widget.compact ? 12 : 14,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
              color: active ? AppTheme.acc(isDark) : AppTheme.ink3(isDark),
            ),
          ),
        ),
      ),
    );
  }
}

class _SkillPanel extends StatelessWidget {
  final SkillCategory cat;
  final bool isDark;

  const _SkillPanel({super.key, required this.cat, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: AppTheme.cardBg(isDark),
        border: Border.all(color: AppTheme.line(isDark)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(cat.emoji, style: const TextStyle(fontSize: 24)),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  cat.groupTitle.toUpperCase(),
                  style: GoogleFonts.bebasNeue(
                    fontSize: 24,
                    letterSpacing: 1.5,
                    color: AppTheme.ink(isDark),
                  ),
                ),
              ),
            ],
          ),
          Divider(color: AppTheme.line(isDark), height: 28),

          // Skill Cards Grid (No fake percentages)
          ...cat.items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppTheme.bg(isDark),
                  border: Border.all(color: AppTheme.line(isDark)),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.name,
                            style: GoogleFonts.epilogue(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.ink(isDark),
                            ),
                          ),
                          if (item.note != null) ...[
                            const SizedBox(height: 2),
                            Text(
                              item.note!,
                              style: GoogleFonts.epilogue(
                                fontSize: 12,
                                color: AppTheme.ink3(isDark),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppTheme.orangeDim(isDark),
                        border: Border.all(color: AppTheme.orangeMid(isDark)),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        item.level,
                        style: GoogleFonts.ibmPlexMono(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.acc(isDark),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),
          Divider(color: AppTheme.line(isDark), height: 28),

          // Skill Pills
          Text(
            'KEY CONCEPTS & LIBRARIES',
            style: GoogleFonts.ibmPlexMono(
              fontSize: 10,
              letterSpacing: 1.5,
              fontWeight: FontWeight.bold,
              color: AppTheme.acc(isDark),
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: cat.tags
                .map((t) => PortfolioChip(
                      label: t,
                      isDark: isDark,
                      filled: true,
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
