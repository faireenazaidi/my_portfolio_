import 'package:flutter/material.dart';
import 'portfolio_data.dart';

const List<String> kRoles = [
  'FLUTTER DEVELOPER',
  'CROSS-PLATFORM ENGINEER',
  'MOBILE APP DEVELOPER',
  'UI/UX IMPLEMENTATION EXPERT',
  'DART SPECIALIST',
];

const List<String> kChips = [
  'Flutter & Dart',
  'GetX State Management',
  'REST APIs & JSON',
  'Firebase & FCM',
  'Figma → Flutter UI',
  'Clean Architecture',
  'Git / GitHub',
  'Play Store Deployment',
];

// Specialization / What I Build
const List<SpecializationItem> kSpecializations = [
  SpecializationItem(
    id: 'cross-platform',
    title: 'Cross-Platform Apps',
    description:
        'High-performance Android and iOS mobile applications built with a single, maintainable Flutter codebase.',
    icon: '📱',
    highlights: [
      'iOS & Android pixel-perfect consistency',
      'Native device capability integrations',
      'Responsive web & tablet scaling',
      'Optimized 60fps UI render loop',
    ],
  ),
  SpecializationItem(
    id: 'production-ui',
    title: 'Production-Ready UI',
    description:
        'Translating complex Figma mockups into structured, responsive, and pixel-perfect Flutter widget trees.',
    icon: '🎨',
    highlights: [
      'Strict design token adherence',
      'Custom painter & complex layout math',
      'Adaptive layouts for mobile & desktop',
      'Implicit & explicit micro-animations',
    ],
  ),
  SpecializationItem(
    id: 'backend-api',
    title: 'API & Backend Integration',
    description:
        'Seamless integration with RESTful endpoints, Dio/http networking, JSON serialization, and Firebase ecosystem.',
    icon: '⚡',
    highlights: [
      'Robust Dio/http client & interceptors',
      'Type-safe JSON serialization',
      'Firebase Auth, Firestore & Realtime DB',
      'Firebase Cloud Messaging (FCM) push alerts',
    ],
  ),
  SpecializationItem(
    id: 'architecture',
    title: 'State Management & Architecture',
    description:
        'Clean, scalable codebases structured around GetX, separation of concerns, and robust service layers.',
    icon: '⚙️',
    highlights: [
      'Reactive state management with GetX',
      'Decoupled business & UI logic',
      'Dependency injection & lazy loading',
      'Local caching & persistent storage',
    ],
  ),
];

// Engineering Architecture Flow
const List<ArchitectureLayerItem> kArchitectureLayers = [
  ArchitectureLayerItem(
    layerName: 'UI Layer',
    subtitle: 'Screen Views & Pages',
    description:
        'Stateless/Stateful widgets handling user interaction and responsive layouts across platforms.',
    components: ['Scaffold', 'LayoutBuilder', 'Navigation', 'Theme Tokens'],
  ),
  ArchitectureLayerItem(
    layerName: 'Reusable Widgets',
    subtitle: 'Design System Components',
    description:
        'Atomic, self-contained UI components for buttons, input fields, cards, and custom indicators.',
    components: ['Buttons', 'Modal Dialogs', 'Status Chips', 'Custom Cards'],
  ),
  ArchitectureLayerItem(
    layerName: 'State Management',
    subtitle: 'GetX Controllers & Reactive State',
    description:
        'Centralized state controllers managing reactive variables, view states, and UI updates.',
    components: ['GetxController', 'Rx Variables', 'Obx / GetBuilder', 'Worker Events'],
  ),
  ArchitectureLayerItem(
    layerName: 'Service Layer',
    subtitle: 'Business Logic & Operations',
    description:
        'Abstracted services for network communication, auth logic, local caching, and notifications.',
    components: ['ApiService', 'AuthService', 'StorageService', 'NotificationService'],
  ),
  ArchitectureLayerItem(
    layerName: 'API / Firebase',
    subtitle: 'External Backend & Cloud',
    description:
        'RESTful HTTP endpoints, Dio networking layers, Cloud Firestore, and FCM services.',
    components: ['REST Endpoints', 'Cloud Firestore', 'FCM Push Notifications', 'Dio Client'],
  ),
  ArchitectureLayerItem(
    layerName: 'Models / Data',
    subtitle: 'Type-Safe Data Structs',
    description:
        'Strict Dart data classes with JSON serialization, factory constructors, and local storage keys.',
    components: ['Model Classes', 'fromJson / toJson', 'Shared Preferences', 'Local Cache'],
  ),
];

const List<EngineeringPrincipleItem> kEngineeringPrinciples = [
  EngineeringPrincipleItem(
    title: 'Reusable Widgets',
    description: 'Modular UI design system preventing code duplication and keeping components DRY.',
    icon: '🧱',
  ),
  EngineeringPrincipleItem(
    title: 'Separation of Concerns',
    description: 'UI rendering is completely decoupled from business logic and network communications.',
    icon: '✂️',
  ),
  EngineeringPrincipleItem(
    title: 'API Service Layer',
    description: 'Centralized Dio/http clients with request interceptors, timeout handling, and error mapping.',
    icon: '🌐',
  ),
  EngineeringPrincipleItem(
    title: 'Model-Based Data Handling',
    description: 'Strict type safety with immutable Dart models and explicit serialization.',
    icon: '📦',
  ),
  EngineeringPrincipleItem(
    title: 'GetX State Management',
    description: 'Reactive data bindings ensuring pinpoint screen rebuilds without performance overhead.',
    icon: '🔄',
  ),
  EngineeringPrincipleItem(
    title: 'Local Storage & Caching',
    description: 'Device persistence via Shared Preferences for user settings and offline caching.',
    icon: '💾',
  ),
  EngineeringPrincipleItem(
    title: 'Responsive Layout Math',
    description: 'Dynamic breakpoints and relative sizing ensuring smooth adaptability from mobile to desktop.',
    icon: '📐',
  ),
  EngineeringPrincipleItem(
    title: 'Error & Loading States',
    description: 'Graceful fallback UI handling, skeleton loaders, and user-friendly error dialogs.',
    icon: '🛡️',
  ),
];

// Timeline / Journey
const List<TimelineItem> kTimeline = [
  TimelineItem(
    num: '01',
    date: '2019',
    title: 'SSC — UP Board, Lucknow',
    desc: 'Science stream · 72% — built analytical thinking and mathematical foundations.',
  ),
  TimelineItem(
    num: '02',
    date: '2021',
    title: 'HSC — UP Board, Lucknow',
    desc: 'Math stream · 72% — logical reasoning, problem solving, and first exposure to coding logic.',
  ),
  TimelineItem(
    num: '03',
    date: '2022 – 2024',
    title: 'BCA — ERA University, Lucknow',
    desc: '79% — Bachelor of Computer Applications degree focusing on software engineering, OOP, and mobile development in Flutter.',
  ),
  TimelineItem(
    num: '04',
    date: 'Sep 2024 – Present',
    title: 'Flutter Developer — Criterion Tech Pvt Ltd',
    desc: 'Engineering cross-platform mobile apps for Android & iOS. Shipped 3+ apps to Google Play Store using REST APIs, Firebase, GetX, and custom Flutter widgets.',
  ),
];

// Skill Categories (Clean, non-fake statistics)
final List<SkillCategory> kSkillCategories = [
  SkillCategory(
    id: 'core-mobile',
    label: 'Core Mobile',
    emoji: '📱',
    groupTitle: 'Core Mobile Development',
    items: const [
      SkillItem('Flutter SDK', level: 'Primary Stack', note: 'Cross-platform framework'),
      SkillItem('Dart Language', level: 'Primary Language', note: 'OOP, Async/Await, Generics'),
      SkillItem('Custom Widgets', level: 'Core Expertise', note: 'Pixel-perfect UI implementation'),
      SkillItem('Android & iOS', level: 'Production Deployment', note: 'APK/AAB & App distribution'),
    ],
    tags: const [
      'Material 3 Design',
      'Cupertino Widgets',
      'Custom Painters',
      'Implicit Animations',
      'App Lifecycle',
      'Build Flavors',
    ],
  ),
  SkillCategory(
    id: 'state-management',
    label: 'State Management',
    emoji: '⚙️',
    groupTitle: 'State Management & Architecture',
    items: const [
      SkillItem('GetX', level: 'Primary Architecture', note: 'State, Dependency Injection, Routing'),
      SkillItem('Provider', level: 'Proficient', note: 'State management & InheritedWidgets'),
      SkillItem('Riverpod', level: 'Familiar', note: 'Compile-safe state provider'),
    ],
    tags: const [
      'Reactive Programming',
      'GetX Controllers',
      'Dependency Injection',
      'GetX Navigation',
      'MVC / MVVM Pattern',
    ],
  ),
  SkillCategory(
    id: 'backend-apis',
    label: 'Backend & APIs',
    emoji: '🔥',
    groupTitle: 'Backend Services & REST APIs',
    items: const [
      SkillItem('RESTful APIs', level: 'Production Usage', note: 'HTTP methods, headers, authentication'),
      SkillItem('Firebase Ecosystem', level: 'Production Usage', note: 'Firestore, Auth, Push Notifications'),
      SkillItem('JSON Serialization', level: 'Core Expertise', note: 'Type-safe data modeling'),
    ],
    tags: const [
      'Dio Client',
      'http Package',
      'Firebase Auth',
      'Cloud Firestore',
      'FCM Push Alerts',
      'API Interceptors',
    ],
  ),
  SkillCategory(
    id: 'design-ui',
    label: 'Design & UI/UX',
    emoji: '🎨',
    groupTitle: 'UI/UX Implementation & Responsiveness',
    items: const [
      SkillItem('Figma to Flutter', level: 'Pixel-Perfect', note: 'Direct UI translation'),
      SkillItem('Responsive Layouts', level: 'Production Usage', note: 'Mobile, Tablet, Web scaling'),
      SkillItem('UI Performance', level: 'Production Usage', note: 'Jank-free render loop & const optimization'),
    ],
    tags: const [
      'Design System Tokens',
      'Responsive Breakpoints',
      'Theme System (Light/Dark)',
      'Custom Typography',
    ],
  ),
  SkillCategory(
    id: 'local-storage',
    label: 'Storage & Cache',
    emoji: '💾',
    groupTitle: 'Local Storage & Device Persistence',
    items: const [
      SkillItem('Shared Preferences', level: 'Production Usage', note: 'Key-value persistence'),
      SkillItem('Local Device Caching', level: 'Production Usage', note: 'Offline data support'),
    ],
    tags: const [
      'Persistent User Data',
      'Session Caching',
      'Secure Local Preferences',
    ],
  ),
  SkillCategory(
    id: 'dev-tools',
    label: 'Tools & Workflow',
    emoji: '🛠️',
    groupTitle: 'Developer Tools & Professional Workflow',
    items: const [
      SkillItem('Git & GitHub', level: 'Daily Workflow', note: 'Version control, PRs, branching'),
      SkillItem('Android Studio & VS Code', level: 'Primary IDEs', note: 'Debugging & profiling tools'),
      SkillItem('Postman', level: 'Daily Workflow', note: 'API testing & endpoint inspection'),
    ],
    tags: const [
      'Build Generation (APK/AAB)',
      'Flutter DevTools',
      'Git Branching',
      'Unit & Widget Testing',
    ],
  ),
];

// Live Shipped Projects
final List<ProjectItem> kProjects = [
  ProjectItem(
    num: '01',
    emoji: '🕌',
    gradientStart: const Color(0xFF0D1B2A),
    gradientEnd: const Color(0xFF1B3A5C),
    tags: const ['Flutter', 'Firebase', 'GetX', 'REST API'],
    title: "Prayer O'Clock",
    subtitle: 'Islamic Prayer Timing & Notifications Application',
    desc:
        'Full-featured Islamic prayer timing app with automated location-based calculation, Firebase cloud data synchronization, and push reminders. Live on Google Play Store.',
    problem:
        'Users needed high accuracy prayer calculation algorithm based on geographical coordinates, with reliable push notifications and zero battery drain.',
    myRole: 'Co-lead Flutter Developer (2-member team at Criterion Tech)',
    contributionPoints: const [
      'Developed core location-based prayer timing calculation engine in Dart.',
      'Implemented GetX reactive controllers for time updates, adhan alerts, and tab navigation.',
      'Integrated Firebase Cloud Messaging (FCM) for accurate local and remote notifications.',
      'Designed clean responsive layout adhering strictly to Material 3 guidelines.',
      'Managed release pipeline and successfully published on Google Play Store.',
    ],
    features: const [
      'Accurate Islamic prayer time calculation algorithm',
      'Firebase Cloud Messaging for push notification reminders',
      'GetX state management & clean route handling',
      'Custom theme toggle (Light / Dark mode)',
      'Published live on Google Play Store',
    ],
    playStoreUrl:
        'https://play.google.com/store/apps/details?id=com.criteriontech.prayeroclock',
    githubUrl: 'https://github.com/faireenazaidi',
    caseStudyOverview:
        'Prayer O\'Clock was engineered to provide believers around the world with exact prayer schedules, Qibla directional indicators, and custom adhan audio triggers. Developed collaboratively at Criterion Tech.',
    architectureHighlights: const [
      'GetX Reactive Pattern for real-time countdown timer',
      'Firebase Auth & Firestore sync',
      'Background task execution for audio triggers',
    ],
    previewImages: const [
      'assets/projects/prayer_oclock_1.png',
      'assets/projects/prayer_oclock_2.png',
      'assets/projects/prayer_oclock_3.png',
    ],
  ),
  ProjectItem(
    num: '02',
    emoji: '📖',
    gradientStart: const Color(0xFF0D2B1A),
    gradientEnd: const Color(0xFF145C30),
    tags: const ['Flutter', 'GetX', 'Firebase', 'REST API'],
    title: 'Quran Journal',
    subtitle: 'Quran Reflection, Progress & Journaling Platform',
    desc:
        'A comprehensive Quranic companion app allowing users to read, reflect, record personal study notes, set reading milestones, and sync reflections safely across devices.',
    problem:
        'Creating an elegant, clutter-free reading environment that supports dual script rendering (Arabic typography + translation), offline offline journaling, and real-time cloud synchronization.',
    myRole: 'Lead Flutter Developer',
    contributionPoints: const [
      'Built dual-script typography reader supporting custom Arabic fonts and translations.',
      'Implemented local SQLite/Shared Preferences caching alongside Firebase Firestore data sync.',
      'Engineered customizable journaling system with tagged notes and verse bookmarking.',
      'Integrated RESTful Quran APIs with Dio client and JSON serialization.',
      'Ensured 60fps smooth scrolling performance for high-density textual views.',
    ],
    features: const [
      'Personalized Quranic journaling with notes, tags, and verse linkage',
      'Reading goals, progress tracking analytics, and streak counters',
      'Location-aware prayer time reminders and audio playback',
      'Offline reading support with background cloud data sync',
      'REST API integration with Dio networking layer',
      'Responsive design supporting mobile, tablet, and dark mode',
    ],
    playStoreUrl: 'https://play.google.com/store/apps/details?id=com.dha.hp',
    githubUrl: 'https://github.com/faireenazaidi',
    caseStudyOverview:
        'Quran Journal combines traditional text reading with personal reflective study. It features clean architectural breakdown using GetX controllers, Dio REST API integration, and Firebase authentication.',
    architectureHighlights: const [
      'Dio Client with caching interceptor',
      'Custom Arabic font rendering pipeline',
      'GetX reactive state for reading progress',
    ],
    previewImages: const [
      'assets/projects/quran_1.png',
      'assets/projects/quran_2.png',
      'assets/projects/quran_3.png',
    ],
  ),
  // ProjectItem(
  //   num: '03',
  //   emoji: '🏥',
  //   gradientStart: const Color(0xFF1A1A2E),
  //   gradientEnd: const Color(0xFF16213E),
  //   tags: const ['Flutter', 'Firebase', 'GetX', 'REST API'],
  //   title: 'Health Parliament App',
  //   subtitle: 'Healthcare Platform & Industry Network Application',
  //   desc:
  //       'Professional healthcare ecosystem app connecting medical experts and policy makers. Worked on stability enhancements, bug fixes, and core feature delivery.',
  //   problem:
  //       'Resolving legacy app crashes, optimizing state re-renders, and implementing new features without breaking existing user data or API contracts.',
  //   myRole: 'Flutter Developer at Criterion Tech',
  //   contributionPoints: const [
  //     'Identified and fixed critical production UI bugs and layout overflow errors.',
  //     'Refactored legacy state handlers to GetX reactive architecture for smooth re-rendering.',
  //     'Implemented new feature modules for user profiles and healthcare news feeds.',
  //     'Integrated Firebase Analytics and Crashlytics for real-time monitoring.',
  //     'Tested across 15+ physical Android device configurations for quality assurance.',
  //   ],
  //   features: const [
  //     'Fixed critical production bugs and improved app stability',
  //     'Refactored state management for faster screen load times',
  //     'Delivered new profile and content feed modules end-to-end',
  //     'Firebase backend data sync and push notification support',
  //     'Live on Google Play Store with thousands of active downloads',
  //   ],
  //   playStoreUrl: 'https://play.google.com/store/apps/details?id=com.dha.hp',
  //   githubUrl: 'https://github.com/faireenazaidi',
  //   caseStudyOverview:
  //       'Health Parliament App is a flagship healthcare domain app. Through structured refactoring and feature additions, performance was significantly improved.',
  //   architectureHighlights: const [
  //     'GetX Dependency Injection',
  //     'Firebase Crashlytics monitoring',
  //     'Responsive list builders with lazy loading',
  //   ],
  // ),
  ProjectItem(
    num: '03',
    emoji: '📚',
    gradientStart: const Color(0xFF2B0D1A),
    gradientEnd: const Color(0xFF591438),
    tags: const ['Flutter', 'Dart', 'Custom UI', 'GetX'],
    title: 'Care Learning — TBL',
    subtitle: 'Interactive Team-Based Learning Medical Education Module',
    desc:
        'Built a complete Team-Based Learning (TBL) educational module from scratch for healthcare professionals and medical students. Live on Google Play Store.',
    problem:
        'Designing a complex interactive quiz, team assessment, and instant grading flow that remains responsive on all Android device screen sizes.',
    myRole: 'Flutter Developer at Criterion Tech',
    contributionPoints: const [
      'Architected and coded the TBL learning module entirely from scratch in Flutter.',
      'Created custom quiz widgets, timed countdown progress indicators, and score cards.',
      'Integrated backend evaluation APIs for real-time student result submission.',
      'Implemented smooth step-by-step wizard state with GetX controllers.',
      'Ensured strict compliance with design specs provided by product managers.',
    ],
    features: const [
      'Built entire TBL module end-to-end from scratch',
      'Custom timed quiz UI components and score summary screens',
      'Real-time team evaluation and progress tracking',
      'Clean Dart codebase with reusable widget hierarchy',
      'Published live on Google Play Store',
    ],
    playStoreUrl:
        'https://play.google.com/store/apps/details?id=com.care.criteriontech.android',
    githubUrl: 'https://github.com/faireenazaidi',
    caseStudyOverview:
        'Care Learning TBL is a specialized educational application module used by healthcare trainees. It features interactive quiz sessions, instantaneous scoring, and clean state handling.',
    architectureHighlights: const [
      'Custom State Controllers for quiz wizard',
      'Modular custom timer & progress widgets',
      'REST API submission payload serialization',
    ],
    previewImages: const [
      'assets/projects/care_1.png',
      'assets/projects/care_2.png',
      'assets/projects/care_3.png',
    ],
  ),
];

// Verified Highlight Statistics
const List<StatItem> kStats = [
  StatItem(number: '3', suffix: '', label: 'Play Store Apps Shipped'),
  StatItem(number: '9', suffix: '+', label: 'Months at Criterion Tech'),
  StatItem(number: '10', suffix: '+', label: 'Production Technologies'),
  StatItem(number: '79', suffix: '%', label: 'BCA Score · ERA Univ'),
];

// Education
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

// Experience Bullets for Criterion Tech Pvt Ltd
const List<String> kExpBullets = [
  'Engineered cross-platform mobile applications using Flutter & Dart for Android and iOS, ensuring 60fps UI performance and native device compatibility.',
  'Translated high-fidelity Figma designs into responsive, reusable Flutter widget trees with strict adherence to design system tokens.',
  'Integrated RESTful APIs using Dio and http packages, managing JSON serialization, request interceptors, and error handling.',
  'Implemented reactive state management and route handling using GetX controllers to maintain clean separation between UI and business logic.',
  'Configured Firebase services including Cloud Firestore, Firebase Authentication, and Firebase Cloud Messaging (FCM) for push notifications.',
  'Managed app release cycles, build generation (APK/AAB), and deployment to the Google Play Store.',
  'Collaborated with QA engineers, backend developers, and product managers to debug production issues and deliver features on schedule.',
];

const List<String> kExpStack = [
  'Flutter',
  'Dart',
  'GetX',
  'REST APIs',
  'Firebase',
  'Figma',
  'Shared Preferences',
  'Git / GitHub',
  'Android Studio',
  'VS Code',
  'JSON Serialization',
  'Unit Testing',
];
