import 'dart:ui';

class SkillItem {
  final String name;
  final int percent;
  const SkillItem(this.name, this.percent);
}

class SkillCategory {
  final String id;
  final String label;
  final String emoji;
  final String groupTitle;
  final List<SkillItem> items;
  final List<String> tags;
  const SkillCategory({
    required this.id,
    required this.label,
    required this.emoji,
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
  final String emoji;
  final Color gradientStart;
  final Color gradientEnd;
  final List<String> tags;
  final String title;
  final String desc;
  final List<String> features;
  final String playStoreUrl;
  const ProjectItem({
    required this.num,
    required this.emoji,
    required this.gradientStart,
    required this.gradientEnd,
    required this.tags,
    required this.title,
    required this.desc,
    required this.features,
    required this.playStoreUrl,
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
