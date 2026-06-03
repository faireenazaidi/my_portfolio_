import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

// ── Blinking dot widget ──
class BlinkingDot extends StatefulWidget {
  final Color color;
  final double size;
  const BlinkingDot({super.key, required this.color, this.size = 6});

  @override
  State<BlinkingDot> createState() => _BlinkingDotState();
}

class _BlinkingDotState extends State<BlinkingDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));
    _anim = Tween<double>(begin: 1.0, end: 0.3)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
    _ctrl.repeat(reverse: true);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (_, __) => Opacity(
        opacity: _anim.value,
        child: Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(widget.size / 2),
          ),
        ),
      ),
    );
  }
}

// ── Section Header ──
class SectionHeader extends StatelessWidget {
  final String tag;
  final String title;
  final String? subtitle;
  final bool isDark;
  final CrossAxisAlignment alignment;

  const SectionHeader({
    super.key,
    required this.tag,
    required this.title,
    this.subtitle,
    required this.isDark,
    this.alignment = CrossAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alignment,
      children: [
        Row(
          mainAxisAlignment: alignment == CrossAxisAlignment.center
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          children: [
            Container(width: 24, height: 1.5, color: AppTheme.acc(isDark)),
            const SizedBox(width: 10),
            Text(
              tag.toUpperCase(),
              style: GoogleFonts.ibmPlexMono(
                fontSize: 11,
                letterSpacing: 1.8,
                color: AppTheme.acc(isDark),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Text(
          title,
          style: GoogleFonts.bebasNeue(
            fontSize: 56,
            letterSpacing: 1.2,
            color: AppTheme.ink(isDark),
            height: 0.95,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 14),
          Text(
            subtitle!,
            style: GoogleFonts.epilogue(
              fontSize: 15,
              color: AppTheme.ink2(isDark),
              fontWeight: FontWeight.w300,
              height: 1.75,
            ),
          ),
        ],
      ],
    );
  }
}

// ── Skill bar ──
class SkillBar extends StatefulWidget {
  final String name;
  final int percent;
  final bool isDark;
  final bool animate;

  const SkillBar({
    super.key,
    required this.name,
    required this.percent,
    required this.isDark,
    this.animate = false,
  });

  @override
  State<SkillBar> createState() => _SkillBarState();
}

class _SkillBarState extends State<SkillBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );
    _anim = Tween<double>(begin: 0, end: widget.percent / 100)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));
    if (widget.animate) {
      Future.delayed(const Duration(milliseconds: 200), () {
        if (mounted) _ctrl.forward();
      });
    } else {
      _ctrl.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(SkillBar old) {
    super.didUpdateWidget(old);
    if (widget.animate && !old.animate) {
      _ctrl.reset();
      Future.delayed(const Duration(milliseconds: 200), () {
        if (mounted) _ctrl.forward();
      });
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.name,
              style: GoogleFonts.epilogue(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppTheme.ink(widget.isDark),
              ),
            ),
            Text(
              '${widget.percent}%',
              style: GoogleFonts.ibmPlexMono(
                fontSize: 12,
                color: AppTheme.acc(widget.isDark),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Container(
          height: 4,
          decoration: BoxDecoration(
            color: AppTheme.bg3(widget.isDark),
            borderRadius: BorderRadius.circular(2),
          ),
          child: AnimatedBuilder(
            animation: _anim,
            builder: (_, __) => FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: _anim.value,
              child: Container(
                decoration: BoxDecoration(
                  color: AppTheme.acc(widget.isDark),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ── Chip ──
class PortfolioChip extends StatefulWidget {
  final String label;
  final bool isDark;
  final bool filled;

  const PortfolioChip({
    super.key,
    required this.label,
    required this.isDark,
    this.filled = false,
  });

  @override
  State<PortfolioChip> createState() => _PortfolioChipState();
}

class _PortfolioChipState extends State<PortfolioChip> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: widget.filled
              ? AppTheme.orangeDim(widget.isDark)
              : Colors.transparent,
          border: Border.all(
            color: _hover || widget.filled
                ? AppTheme.acc(widget.isDark)
                : AppTheme.lineStrong(widget.isDark),
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(3),
        ),
        child: Text(
          widget.label,
          style: GoogleFonts.ibmPlexMono(
            fontSize: 11,
            letterSpacing: 0.8,
            color: _hover || widget.filled
                ? AppTheme.acc(widget.isDark)
                : AppTheme.ink2(widget.isDark),
          ),
        ),
      ),
    );
  }
}

// ── Reveal Animation Wrapper ──
class RevealOnScroll extends StatefulWidget {
  final Widget child;
  final Duration delay;

  const RevealOnScroll({
    super.key,
    required this.child,
    this.delay = Duration.zero,
  });

  @override
  State<RevealOnScroll> createState() => _RevealOnScrollState();
}

class _RevealOnScrollState extends State<RevealOnScroll>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _opacity;
  late Animation<Offset> _slide;
  bool _triggered = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    _opacity = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));
    _slide = Tween<Offset>(
            begin: const Offset(0, 0.06), end: Offset.zero)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));
  }

  void trigger() {
    if (!_triggered) {
      _triggered = true;
      Future.delayed(widget.delay, () {
        if (mounted) _ctrl.forward();
      });
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      child: LayoutBuilder(builder: (ctx, _) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final renderBox = ctx.findRenderObject() as RenderBox?;
          if (renderBox != null && renderBox.hasSize) {
            final pos = renderBox.localToGlobal(Offset.zero);
            final screenH = MediaQuery.of(context).size.height;
            if (pos.dy < screenH * 0.92) trigger();
          }
        });
        return AnimatedBuilder(
          animation: _ctrl,
          builder: (_, child) => FadeTransition(
            opacity: _opacity,
            child: SlideTransition(position: _slide, child: child),
          ),
          child: widget.child,
        );
      }),
    );
  }
}

// ── Hover Button — Orange filled ──
class OrangeButton extends StatefulWidget {
  final String label;
  final VoidCallback? onTap;
  final bool isDark;

  const OrangeButton({
    super.key,
    required this.label,
    this.onTap,
    required this.isDark,
  });

  @override
  State<OrangeButton> createState() => _OrangeButtonState();
}

class _OrangeButtonState extends State<OrangeButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.translationValues(0, _hover ? -2 : 0, 0),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          decoration: BoxDecoration(
            color: AppTheme.acc(widget.isDark),
            borderRadius: BorderRadius.circular(4),
            boxShadow: _hover
                ? [
                    BoxShadow(
                      color: AppTheme.acc(widget.isDark).withOpacity(0.3),
                      blurRadius: 28,
                      offset: const Offset(0, 10),
                    )
                  ]
                : [],
          ),
          child: Text(widget.label,
            style: GoogleFonts.epilogue(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

// ── Outline Button ──
class OutlineButton2 extends StatefulWidget {
  final String label;
  final VoidCallback? onTap;
  final bool isDark;

  const OutlineButton2({
    super.key,
    required this.label,
    this.onTap,
    required this.isDark,
  });

  @override
  State<OutlineButton2> createState() => _OutlineButton2State();
}

class _OutlineButton2State extends State<OutlineButton2> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          decoration: BoxDecoration(
            border: Border.all(
              color: _hover
                  ? AppTheme.acc(widget.isDark)
                  : AppTheme.lineStrong(widget.isDark),
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            widget.label,
            style: GoogleFonts.epilogue(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
              color: _hover
                  ? AppTheme.acc(widget.isDark)
                  : AppTheme.ink(widget.isDark),
            ),
          ),
        ),
      ),
    );
  }
}

// ── Social icon button ──
class SocialBtn extends StatefulWidget {
  final Widget icon;
  final String tooltip;
  final VoidCallback? onTap;
  final bool isDark;

  const SocialBtn({
    super.key,
    required this.icon,
    required this.tooltip,
    this.onTap,
    required this.isDark,
  });

  @override
  State<SocialBtn> createState() => _SocialBtnState();
}

class _SocialBtnState extends State<SocialBtn> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tooltip,
      child: MouseRegion(
        onEnter: (_) => setState(() => _hover = true),
        onExit: (_) => setState(() => _hover = false),
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 40,
            height: 40,
            transform:
                Matrix4.translationValues(0, _hover ? -2 : 0, 0),
            decoration: BoxDecoration(
              border: Border.all(
                color: _hover
                    ? AppTheme.acc(widget.isDark)
                    : AppTheme.lineStrong(widget.isDark),
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(
              child: IconTheme(
                data: IconThemeData(
                  color: _hover
                      ? AppTheme.acc(widget.isDark)
                      : AppTheme.ink3(widget.isDark),
                  size: 16,
                ),
                child: widget.icon,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
