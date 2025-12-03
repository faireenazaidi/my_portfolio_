import 'package:flutter/material.dart';
import '3d_Container.dart';
import 'Section_header.dart';

Widget buildAboutSection() {
  return Container(
    padding: const EdgeInsets.all(24),
    constraints: const BoxConstraints(maxWidth: 1200),
    child: Column(
      children: [
        buildSectionHeader('01.', 'About Me'),
        const SizedBox(height: 48),
        LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 768) {
              return Row(
                children: [
                  Expanded(
                    child: build3DCard(
                      icon: Icons.code,
                      title: 'Professional Journey',
                      content:
                      'Flutter Developer at Criterion Tech, Lucknow with 1 year of hands-on experience. Specialized in developing cross-platform mobile applications with clean code architecture and best practices.',
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: build3DCard(
                      icon: Icons.school,
                      title: 'Education',
                      content: 'BCA — 82% (2024)\nIntermediate — 72% (2021)\nHigh School — 72% (2019)',
                    ),
                  ),
                ],
              );
            }
            return Column(
              children: [
                build3DCard(
                  icon: Icons.code,
                  title: 'Professional Journey',
                  content:
                  'Flutter Developer at Criterion Tech, Lucknow with 1 year of hands-on experience.',
                ),
                const SizedBox(height: 24),
                build3DCard(
                  icon: Icons.school,
                  title: 'Education',
                  content: 'BCA — 82% (2024)\nIntermediate — 72% (2021)',
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 24),
        LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 768) {
              return Row(
                children: [
                  Expanded(
                    child: build3DCard(
                      icon: Icons.work,
                      title: 'Expertise',
                      content:
                      'Proficient in state management using GetX, integrating RESTful APIs, implementing Firebase authentication, and transforming Figma designs into pixel-perfect Flutter applications.',
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: build3DCard(
                      icon: Icons.language,
                      title: 'Languages',
                      content:
                      'Languages: English, Hindi, Urdu\n\nPassionate about learning emerging technologies and delivering user-centric mobile solutions',
                    ),
                  ),
                ],
              );
            }
            return Column(
              children: [
                build3DCard(
                  icon: Icons.work,
                  title: 'Expertise',
                  content: 'Proficient in GetX, RESTful APIs, Firebase authentication.',
                ),
                const SizedBox(height: 24),
                build3DCard(
                  icon: Icons.language,
                  title: 'Languages',
                  content: 'English, Hindi, Urdu',
                ),
              ],
            );
          },
        ),
      ],
    ),
  );
}
