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
            tag: 'Technical Skills',
            title: 'The Stack',
            subtitle:
                'Every technology I use in production — nothing added just to look good on paper.',
            isDark: widget.isDark,
            alignment: CrossAxisAlignment.center,
          ),
          const SizedBox(height: 48),
          isWide
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: 260, child: _buildNav()),
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
      spacing: 6,
      runSpacing: 6,
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
              : const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          margin: widget.compact
              ? EdgeInsets.zero
              : const EdgeInsets.only(bottom: 2),
          decoration: BoxDecoration(
            color: active
                ? AppTheme.orangeDim(widget.isDark)
                : Colors.transparent,
            border: Border(
              left: BorderSide(
                color: active
                    ? AppTheme.acc(widget.isDark)
                    : Colors.transparent,
                width: 2,
              ),
            ),
            borderRadius: widget.compact ? BorderRadius.circular(4) : null,
          ),
          child: Text(
            widget.label,
            style: GoogleFonts.epilogue(
              fontSize: widget.compact ? 12 : 14,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
              color: active
                  ? AppTheme.acc(widget.isDark)
                  : AppTheme.ink3(widget.isDark),
            ),
          ),
        ),
      ),
    );
  }
}

class _SkillPanel extends StatefulWidget {
  final SkillCategory cat;
  final bool isDark;

  const _SkillPanel({super.key, required this.cat, required this.isDark});

  @override
  State<_SkillPanel> createState() => _SkillPanelState();
}

class _SkillPanelState extends State<_SkillPanel> {
  bool _animated = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) setState(() => _animated = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.cat.groupTitle.toUpperCase(),
          style: GoogleFonts.ibmPlexMono(
            fontSize: 11,
            letterSpacing: 1.5,
            color: AppTheme.ink3(widget.isDark),
          ),
        ),
        Divider(color: AppTheme.line(widget.isDark), height: 24),
        ...widget.cat.items.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: SkillBar(
                name: item.name,
                percent: item.percent,
                isDark: widget.isDark,
                animate: _animated,
              ),
            )),
        const SizedBox(height: 8),
        Divider(color: AppTheme.line(widget.isDark), height: 24),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: widget.cat.tags
              .map((t) => _SkillTag(label: t, isDark: widget.isDark))
              .toList(),
        ),
      ],
    );
  }
}

class _SkillTag extends StatelessWidget {
  final String label;
  final bool isDark;
  const _SkillTag({required this.label, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppTheme.cardBg(isDark),
        border: Border.all(color: AppTheme.line(isDark)),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Text(
        label,
        style: GoogleFonts.ibmPlexMono(
            fontSize: 11, color: AppTheme.ink2(isDark), letterSpacing: 0.5),
      ),
    );
  }
}
