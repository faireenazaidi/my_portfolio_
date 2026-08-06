import 'package:flutter/widgets.dart';

class SkillItem {
  final String name;
  final String level; // e.g. 'Core Focus', 'Advanced', 'Production'
  final String? note;
  const SkillItem(this.name, {this.level = 'Core Focus', this.note});
}

class SkillCategory {
  final String id;
  final String label;
  final IconData icon;
  final String groupTitle;
  final List<SkillItem> items;
  final List<String> tags;
  const SkillCategory({
    required this.id,
    required this.label,
    required this.icon,
    required this.groupTitle,
    required this.items,
    required this.tags,
  });
}

class TimelineItem {
  final String num;
  final String date;
  final String title;
  final String desc;
  const TimelineItem({
    required this.num,
    required this.date,
    required this.title,
    required this.desc,
  });
}

class ProjectItem {
  final String num;
  final IconData icon;
  final Color gradientStart;
  final Color gradientEnd;
  final List<String> tags;
  final String title;
  final String subtitle;
  final String desc;
  final String problem;
  final String myRole;
  final List<String> contributionPoints;
  final List<String> features;
  final String playStoreUrl;
  final String? githubUrl;
  final String caseStudyOverview;
  final List<String> architectureHighlights;
  final List<String> previewImages;

  const ProjectItem({
    required this.num,
    required this.icon,
    required this.gradientStart,
    required this.gradientEnd,
    required this.tags,
    required this.title,
    this.subtitle = '',
    required this.desc,
    this.problem = '',
    this.myRole = 'Flutter Developer',
    this.contributionPoints = const [],
    required this.features,
    required this.playStoreUrl,
    this.githubUrl,
    this.caseStudyOverview = '',
    this.architectureHighlights = const [],
    this.previewImages = const [],
  });
}

class SpecializationItem {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final List<String> highlights;

  const SpecializationItem({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.highlights,
  });
}

class ArchitectureLayerItem {
  final String layerName;
  final String subtitle;
  final String description;
  final List<String> components;

  const ArchitectureLayerItem({
    required this.layerName,
    required this.subtitle,
    required this.description,
    required this.components,
  });
}

class EngineeringPrincipleItem {
  final String title;
  final String description;
  final IconData icon;

  const EngineeringPrincipleItem({
    required this.title,
    required this.description,
    required this.icon,
  });
}

class EducationItem {
  final String year;
  final String degree;
  final String institution;
  final String score;
  const EducationItem({
    required this.year,
    required this.degree,
    required this.institution,
    required this.score,
  });
}

class StatItem {
  final String number;
  final String suffix;
  final String label;
  const StatItem({required this.number, this.suffix = '', required this.label});
}
