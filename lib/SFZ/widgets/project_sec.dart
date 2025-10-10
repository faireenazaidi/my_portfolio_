import 'package:flutter/material.dart';

import '3d_Container.dart';
import 'Section_header.dart';

Widget buildProjectsSection(BuildContext context) {
  final projects = [
    {
      'title': 'Prayer O Clock',
      'status': 'Live',
      'description': 'Islamic prayer timing application developed and deployed with a 2-member team',
      'tech': ['Flutter', 'Firebase', 'GetX'],
    },
    {
      'title': 'Health Parliament App',
      'status': 'Production',
      'description': 'Fixed critical bugs and enhanced application stability with new features',
      'tech': ['Flutter', 'RESTful APIs', 'Firebase'],
    },
    {
      'title': 'Care Learning - TBL',
      'status': 'Active',
      'description': 'Developed new TBL module from scratch with enhanced educational features',
      'tech': ['Flutter', 'Dart', 'Custom UI'],
    },
  ];

  return Container(
    padding: const EdgeInsets.all(24),
    constraints: const BoxConstraints(maxWidth: 1200),
    child: Column(
      children: [
        buildSectionHeader('03.', 'Featured Projects'),
        const SizedBox(height: 48),
        Wrap(
          spacing: 24,
          runSpacing: 24,
          children: projects.map((project) {
            return SizedBox(
              width: MediaQuery.of(context).size.width > 768
                  ? (MediaQuery.of(context).size.width - 96) / 3
                  : double.infinity,
              child: buildProjectCard(project),
            );
          }).toList(),
        ),
      ],
    ),
  );
}
Widget buildProjectCard(Map<String, dynamic> project) {
  return Container3D(
    child: Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF1e002a).withOpacity(0.6),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(
                Icons.account_tree,
                color: Color(0xFF8b5cf6),
                size: 24,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.2),
                  border: Border.all(
                    color: Colors.green.withOpacity(0.4),
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  project['status'],
                  style: const TextStyle(
                    color: Colors.green,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            project['title'],
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            project['description'],
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 14,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: (project['tech'] as List<String>).map((tech) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  border: Border.all(
                    color: const Color(0xFF8b5cf6).withOpacity(0.4),
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  tech,
                  style: const TextStyle(
                    color: Color(0xFF8b5cf6),
                    fontSize: 10,
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
