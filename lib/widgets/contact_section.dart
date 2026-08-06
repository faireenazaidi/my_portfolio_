import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';
import 'common_widgets.dart';

class ContactSection extends StatelessWidget {
  final bool isDark;
  const ContactSection({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 900;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 32),
      decoration: BoxDecoration(
        color: AppTheme.bg2(isDark),
        border: Border(top: BorderSide(color: AppTheme.line(isDark))),
      ),
      child: MaxContentContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(
              tag: 'Get In Touch',
              title: "Have a Project in Mind?\nLet's Build Together.",
              subtitle:
                  'Open for opportunities at product companies, startups, and engineering teams building applications people love.',
              isDark: isDark,
            ),
            const SizedBox(height: 40),
            isWide
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _buildInfo()),
                      const SizedBox(width: 60),
                      Expanded(child: _ContactForm(isDark: isDark)),
                    ],
                  )
                : Column(
                    children: [
                      _buildInfo(),
                      const SizedBox(height: 40),
                      _ContactForm(isDark: isDark),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _CItem(
          icon: FontAwesomeIcons.envelope,
          label: 'Email Address',
          value: 'fairenazaidi@gmail.com',
          isDark: isDark,
        ),
        _CItem(
          icon: FontAwesomeIcons.phone,
          label: 'Phone / WhatsApp',
          value: '+91 8173822136 / +91 8172800431',
          isDark: isDark,
        ),
        _CItem(
          icon: FontAwesomeIcons.locationDot,
          label: 'Location',
          value: 'Noor Colony, Dubagga, Lucknow — 226003, UP, India',
          isDark: isDark,
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _CSoc(
              label: 'Email Me',
              icon: FontAwesomeIcons.envelope,
              isDark: isDark,
              onTap: () =>
                  launchUrl(Uri.parse('mailto:fairenazaidi@gmail.com')),
            ),
            _CSoc(
              label: 'LinkedIn',
              icon: FontAwesomeIcons.linkedinIn,
              isDark: isDark,
              onTap: () =>
                  launchUrl(Uri.parse('https://linkedin.com/in/')),
            ),
            _CSoc(
              label: 'GitHub',
              icon: FontAwesomeIcons.github,
              isDark: isDark,
              onTap: () => launchUrl(Uri.parse('https://github.com/faireenazaidi')),
            ),
            _CSoc(
              label: 'WhatsApp Chat',
              icon: FontAwesomeIcons.whatsapp,
              isDark: isDark,
              onTap: () =>
                  launchUrl(Uri.parse('https://wa.me/918173822136')),
            ),
          ],
        ),
      ],
    );
  }
}

class _CItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool isDark;

  const _CItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 20),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: AppTheme.line(isDark))),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppTheme.orangeDim(isDark),
              border: Border.all(color: AppTheme.orangeMid(isDark)),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: Icon(
                icon,
                size: 18,
                color: AppTheme.acc(isDark),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label.toUpperCase(),
                  style: GoogleFonts.ibmPlexMono(
                    fontSize: 10,
                    letterSpacing: 1.5,
                    color: AppTheme.ink3(isDark),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  softWrap: true,
                  style: GoogleFonts.epilogue(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.ink(isDark),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CSoc extends StatefulWidget {
  final String label;
  final IconData icon;
  final bool isDark;
  final VoidCallback? onTap;
  const _CSoc({
    required this.label,
    required this.icon,
    required this.isDark,
    this.onTap,
  });

  @override
  State<_CSoc> createState() => _CSocState();
}

class _CSocState extends State<_CSoc> {
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
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: AppTheme.cardBg(widget.isDark),
            border: Border.all(
              color: _hover
                  ? AppTheme.acc(widget.isDark)
                  : AppTheme.line(widget.isDark),
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                size: 14,
                color: _hover
                    ? AppTheme.acc(widget.isDark)
                    : AppTheme.ink2(widget.isDark),
              ),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: GoogleFonts.epilogue(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8,
                  color: _hover
                      ? AppTheme.acc(widget.isDark)
                      : AppTheme.ink2(widget.isDark),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContactForm extends StatefulWidget {
  final bool isDark;
  const _ContactForm({required this.isDark});

  @override
  State<_ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<_ContactForm> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _msg = TextEditingController();

  void _send() {
    if (_name.text.trim().isEmpty ||
        _email.text.trim().isEmpty ||
        _msg.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please fill in all fields.',
            style: GoogleFonts.epilogue(),
          ),
          backgroundColor: AppTheme.acc(widget.isDark),
        ),
      );
      return;
    }
    final nameEncoded = Uri.encodeComponent(_name.text.trim());
    final bodyEncoded = Uri.encodeComponent('${_msg.text.trim()}\n\nFrom: ${_email.text.trim()}');
    launchUrl(Uri.parse(
        'mailto:fairenazaidi@gmail.com?subject=Portfolio Enquiry from $nameEncoded&body=$bodyEncoded'));
  }

  InputDecoration _dec(String placeholder) => InputDecoration(
        hintText: placeholder,
        hintStyle: GoogleFonts.epilogue(
            fontSize: 14, color: AppTheme.ink3(widget.isDark)),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        filled: true,
        fillColor: AppTheme.bg(widget.isDark),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppTheme.line(widget.isDark), width: 1.5),
          borderRadius: BorderRadius.circular(4),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: AppTheme.acc(widget.isDark), width: 1.5),
          borderRadius: BorderRadius.circular(4),
        ),
      );

  TextStyle get _inputStyle => GoogleFonts.epilogue(
      fontSize: 14, color: AppTheme.ink(widget.isDark));

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: AppTheme.cardBg(widget.isDark),
        border: Border.all(color: AppTheme.line(widget.isDark)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _label('YOUR NAME'),
          const SizedBox(height: 8),
          TextField(
              controller: _name,
              style: _inputStyle,
              decoration: _dec('Full Name / Company')),
          const SizedBox(height: 16),
          _label('EMAIL ADDRESS'),
          const SizedBox(height: 8),
          TextField(
              controller: _email,
              style: _inputStyle,
              decoration: _dec('your.email@company.com')),
          const SizedBox(height: 16),
          _label('MESSAGE'),
          const SizedBox(height: 8),
          TextField(
            controller: _msg,
            style: _inputStyle,
            decoration: _dec('Tell me about the role, project, or application...'),
            maxLines: 5,
          ),
          const SizedBox(height: 24),
          OrangeButton(
            label: 'SEND MESSAGE ➔',
            onTap: _send,
            isDark: widget.isDark,
          ),
        ],
      ),
    );
  }

  Widget _label(String text) {
    return Text(
      text,
      style: GoogleFonts.ibmPlexMono(
        fontSize: 10,
        letterSpacing: 1.8,
        fontWeight: FontWeight.bold,
        color: AppTheme.ink3(widget.isDark),
      ),
    );
  }
}
