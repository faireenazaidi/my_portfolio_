import 'package:flutter/material.dart';
import '3d_Container.dart';
import 'Section_header.dart';

Widget buildSkillsSection(BuildContext context,) {
  final skills = {
    'Mobile Development': ['Flutter', 'Dart', 'Cross-platform', 'Custom Widgets', 'Animations'],
    'Backend & APIs': ['RESTful APIs', 'Firebase', 'Authentication'],
    'State Management': ['GetX'],
    'Design & UI/UX': ['Figma to Flutter', 'Responsive Design', 'UI/UX'],
    'Version Control': ['Git', 'GitHub', 'Unit Testing'],
  };

  return Container(
    padding: const EdgeInsets.all(24),
    constraints: const BoxConstraints(maxWidth: 1200),
    child: Column(
      children: [
        buildSectionHeader(context,'02.', 'Technical Skills'),
        const SizedBox(height: 48),
        Wrap(
          spacing: 24,
          runSpacing: 24,
          children: skills.entries.map((entry) {
            return SizedBox(
              width: MediaQuery.of(context).size.width > 768
                  ? (MediaQuery.of(context).size.width - 96) / 3
                  : double.infinity,
              child: buildSkillCard(entry.key, entry.value),
            );
          }).toList(),
        ),
      ],
    ),
  );
}
Widget buildSkillCard(String title, List<String> skills) {
  return Container3D(
    child: Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
        const Color(0xFF1e002a).withOpacity(0.3),
            Colors.black.withOpacity(0.6),
          ],
        ),
        border: Border.all(
          color: const Color(0xFF8b5cf6).withOpacity(0.3),
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.storage,
                color: Color(0xFF8b5cf6),
                size: 20,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF8b5cf6),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: skills.map((skill) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  border: Border.all(
                    color: const Color(0xFF8b5cf6).withOpacity(0.4),
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  skill,
                  style: TextStyle(
                    color: Colors.grey[300],
                    fontSize: 12,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    ),
  );
}
