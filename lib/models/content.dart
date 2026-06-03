import 'package:flutter/material.dart';
import 'portfolio_data.dart';

const List<String> kRoles = [
  'Flutter Developer',
  'Mobile App Developer',
  'Cross Platform Engineer',
  'Dart Developer',
  'UI/UX Developer',
];

const List<String> kChips = [
  'Flutter & Dart',
  'REST APIs',
  'Firebase',
  'GetX',
  'Clean Architecture',
  'Figma → Flutter',
  'Git / GitHub',
  'Unit Testing',
];

const List<TimelineItem> kTimeline = [
  TimelineItem(
    num: '01',
    date: '2019',
    title: 'SSC — UP Board, Lucknow',
    desc: 'Science stream · 72% — built analytical and mathematical foundations.',
  ),
  TimelineItem(
    num: '02',
    date: '2021',
    title: 'HSC — UP Board, Lucknow',
    desc:
        'Math stream · 72% — logical reasoning, problem solving; first exposure to programming concepts.',
  ),
  TimelineItem(
    num: '03',
    date: '2022 – 2024',
    title: 'BCA — ERA University, Lucknow',
    desc:
        '79% — Computer Applications degree with focus on mobile development. Discovered Flutter and spent most of the time building apps.',
  ),
  TimelineItem(
    num: '04',
    date: 'Sep 2024 – Present',
    title: 'Flutter Developer — Criterion Tech Pvt Ltd',
    desc:
        'Building production cross-platform apps. REST APIs, Firebase, GetX, responsive UI, deployment — the full cycle.',
  ),
];

final List<SkillCategory> kSkillCategories = [
  SkillCategory(
    id: 'mobile',
    label: 'Mobile Dev',
    emoji: '📱',
    groupTitle: 'Mobile Development',
    items: const [
      SkillItem('Flutter', 92),
      SkillItem('Dart', 88),
      SkillItem('Custom Widgets', 85),
      SkillItem('Cross Platform (Android & iOS)', 90),
    ],
    tags: const [
      'Material 3', 'Cupertino', 'Animations',
      'Custom Paint', 'Build Flavours', 'APK / AAB'
    ],
  ),
  SkillCategory(
    id: 'state',
    label: 'State Mgmt',
    emoji: '⚙️',
    groupTitle: 'State Management',
    items: const [
      SkillItem('GetX', 88),
      SkillItem('Provider', 75),
      SkillItem('Riverpod', 68),
    ],
    tags: const [
      'Reactive Programming', 'Navigation (GetX)',
      'Dependency Injection', 'MVC / MVVM'
    ],
  ),
  SkillCategory(
    id: 'backend',
    label: 'Backend & APIs',
    emoji: '🔥',
    groupTitle: 'Backend & APIs',
    items: const [
      SkillItem('RESTful APIs', 87),
      SkillItem('Firebase (Firestore, Auth, FCM)', 82),
      SkillItem('JSON Data Models', 85),
    ],
    tags: const [
      'Dio / http', 'Firebase Authentication', 'Cloud Firestore',
      'Push Notifications (FCM)', 'Third-party SDKs'
    ],
  ),
  SkillCategory(
    id: 'design',
    label: 'Design & UI',
    emoji: '🎨',
    groupTitle: 'Design & UI/UX',
    items: const [
      SkillItem('Figma → Flutter', 85),
      SkillItem('Responsive Design', 90),
      SkillItem('UI Performance Optimisation', 80),
    ],
    tags: const [
      'Pixel-perfect UI', 'Responsive Layout',
      'Implicit Animations', 'User Experience'
    ],
  ),
  SkillCategory(
    id: 'storage',
    label: 'Local Storage',
    emoji: '💾',
    groupTitle: 'Local Storage',
    items: const [
      SkillItem('Shared Preferences', 88),
      SkillItem('Local Storage (Device)', 82),
    ],
    tags: const ['Persistent Storage', 'Cache Management', 'Secure Storage'],
  ),
  SkillCategory(
    id: 'tools',
    label: 'Dev Tools',
    emoji: '🛠️',
    groupTitle: 'Dev Tools & Workflow',
    items: const [
      SkillItem('Git & GitHub', 83),
      SkillItem('Android Studio', 88),
      SkillItem('VS Code', 85),
    ],
    tags: const [
      'Unit Testing', 'Debugging', 'Build Generation',
      'Version Management', 'Deployment'
    ],
  ),
];

final List<ProjectItem> kProjects = [
  ProjectItem(
    num: '01',
    emoji: '🕌',
    gradientStart: const Color(0xFF0D1B2A),
    gradientEnd: const Color(0xFF1B3A5C),
    tags: const ['Flutter', 'Firebase', 'GetX'],
    title: "Prayer O'Clock",
    desc:
        'Islamic prayer timing application developed & deployed with a 2-member team at Criterion Tech. Live on the Google Play Store.',
    features: const [
      'Accurate Islamic prayer time calculations',
      'Developed & deployed with a 2-member team',
      'Firebase integration for data & notifications',
      'GetX for state management & navigation',
      'Published live on Google Play Store',
    ],
    playStoreUrl:
        'https://play.google.com/store/apps/details?id=com.criteriontech.prayeroclock',
  ),
  ProjectItem(
    num: '02',
    emoji: '🏥',
    gradientStart: const Color(0xFF0D2B1A),
    gradientEnd: const Color(0xFF145C30),
    tags: const ['Flutter', 'Firebase', 'GetX'],
    title: 'Health Parliament App',
    desc:
        'Fixed critical bugs and enhanced application stability with new features. A healthcare platform live on Google Play Store.',
    features: const [
      'Identified and fixed critical production bugs',
      'Enhanced app stability across Android devices',
      'Delivered new feature modules end-to-end',
      'Firebase backend integration & data sync',
      'Live on Google Play Store',
    ],
    playStoreUrl:
        'https://play.google.com/store/apps/details?id=com.dha.hp',
  ),
  ProjectItem(
    num: '03',
    emoji: '📚',
    gradientStart: const Color(0xFF1A0D2B),
    gradientEnd: const Color(0xFF3A1459),
    tags: const ['Flutter', 'Dart', 'Custom UI'],
    title: 'Care Learning — TBL',
    desc:
        'Built a new TBL (Team-Based Learning) module from scratch with enhanced educational features. Live on Google Play Store.',
    features: const [
      'Built the TBL module entirely from scratch',
      'Custom UI components designed in Dart/Flutter',
      'Enhanced educational features for learners',
      'Clean Dart code with custom widget architecture',
      'Live on Google Play Store',
    ],
    playStoreUrl:
        'https://play.google.com/store/apps/details?id=com.care.criteriontech.android',
  ),
];

const List<StatItem> kStats = [
  StatItem(number: '3', label: 'Live Play Store Apps'),
  StatItem(number: '9', suffix: '+', label: 'Months at Criterion Tech'),
  StatItem(number: '10', suffix: '+', label: 'Technologies Used'),
  StatItem(number: '79', suffix: '%', label: 'BCA · ERA University'),
];

const List<EducationItem> kEducation = [
  EducationItem(
    year: '2024',
    degree: 'Bachelor of Computer Application (BCA)',
    institution: 'ERA University, Lucknow · 2022–2024',
    score: '79%',
  ),
  EducationItem(
    year: '2021',
    degree: 'HSC — Mathematics Stream',
    institution: 'UP Board, Lucknow · 2021',
    score: '72%',
  ),
  EducationItem(
    year: '2019',
    degree: 'SSC — Science Stream',
    institution: 'UP Board, Lucknow · 2019',
    score: '72%',
  ),
];

const List<String> kExpBullets = [
  'Developed and maintained cross-platform mobile applications using Flutter for Android and iOS, ensuring consistent UI and performance across devices.',
  'Built responsive, reusable, and performance-optimised UI components from Figma designs — pixel-perfect implementation with attention to spacing, typography, and edge cases.',
  'Collaborated closely with designers and QA teams to implement features, resolve UI issues, and continuously improve the user experience.',
  'Integrated RESTful APIs, handled JSON data models (serialisation/deserialisation), and managed app state and navigation flows using GetX.',
  'Implemented device features including local storage via Shared Preferences, Firebase services (Firestore, Auth, FCM), and third-party SDK integrations.',
  'Ensured app stability through debugging, testing, and performance optimisation across multiple Android and iOS device configurations.',
  'Assisted in build generation, version management, and deployment for both Android (APK/AAB) and iOS platforms.',
  'Participated in sprint planning, task breakdown, team discussions, and ongoing application feature enhancements.',
];

const List<String> kExpStack = [
  'Flutter', 'Dart', 'GetX', 'REST APIs', 'Firebase',
  'Figma', 'Shared Preferences', 'Git / GitHub',
  'Android Studio', 'VS Code', 'JSON', 'Unit Testing',
];
