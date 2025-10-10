import 'package:flutter/material.dart';

Widget buildNavigationBar(BuildContext context,bool isScrolled) {
  return Positioned(
    top: 0,
    left: 0,
    right: 0,
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: isScrolled ? Colors.black.withOpacity(0.95) : Colors.transparent,
        border: isScrolled
            ? Border(
          bottom: BorderSide(
            color: const Color(0xFF8b5cf6).withOpacity(0.5),
          ),
        )
            : null,
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            children: [
              const Icon(Icons.terminal, color: Color(0xFF8b5cf6)),
              const SizedBox(width: 8),
              const Text(
                '<SFZ/>',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              // Desktop Navigation
              if (MediaQuery.of(context).size.width > 768)
                Row(
                  children: [
                    _navItem('01.', 'Home'),
                    _navItem('02.', 'About'),
                    _navItem('03.', 'Skills'),
                    _navItem('04.', 'Projects'),
                    _navItem('05.', 'Contact'),
                  ],
                ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget _navItem(String number, String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12),
    child: InkWell(
      onTap: () {},
      child: Row(
        children: [
          Text(
            number,
            style: const TextStyle(
              color: Color(0xFF8b5cf6),
              fontSize: 12,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            text,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
        ],
      ),
    ),
  );
}