// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:mailer/mailer.dart';
// import 'package:mailer/smtp_server/gmail.dart';
//
//
//
// class PortfolioHomePage extends StatefulWidget {
//   const PortfolioHomePage({super.key});
//
//   @override
//   State<PortfolioHomePage> createState() => _PortfolioHomePageState();
// }
//
// class _PortfolioHomePageState extends State<PortfolioHomePage> with TickerProviderStateMixin {
//   int activeSection = 0;
//   bool isLoading = false;
//
//   late AnimationController _profileAnimationController;
//   late AnimationController _counterAnimationController;
//   late AnimationController _floatingController;
//
//   late Animation<double> _profileAnimation;
//   late Animation<double> _floatingAnimation;
//
//   int experienceYears = 0;
//   int projectsCount = 0;
//   int appsCount = 0;
//
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController subjectController = TextEditingController();
//   final TextEditingController messageController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//
//     _profileAnimationController = AnimationController(
//       duration: const Duration(seconds: 3),
//       vsync: this,
//     );
//
//     _counterAnimationController = AnimationController(
//       duration: const Duration(seconds: 2),
//       vsync: this,
//     );
//
//     _floatingController = AnimationController(
//       duration: const Duration(seconds: 6),
//       vsync: this,
//     );
//
//     _profileAnimation = Tween<double>(
//       begin: 1.0,
//       end: 1.05,
//     ).animate(CurvedAnimation(
//       parent: _profileAnimationController,
//       curve: Curves.easeInOut,
//     ));
//
//     _floatingAnimation = Tween<double>(
//       begin: -20.0,
//       end: 20.0,
//     ).animate(CurvedAnimation(
//       parent: _floatingController,
//       curve: Curves.easeInOut,
//     ));
//
//     _profileAnimationController.repeat(reverse: true);
//     _floatingController.repeat(reverse: true);
//
//     _animateCounters();
//   }
//
//   void _animateCounters() {
//     _counterAnimationController.addListener(() {
//       setState(() {
//         experienceYears = (3 * _counterAnimationController.value).round();
//         projectsCount = (25 * _counterAnimationController.value).round();
//         appsCount = (12 * _counterAnimationController.value).round();
//       });
//     });
//     _counterAnimationController.forward();
//   }
//
//   @override
//   void dispose() {
//     _profileAnimationController.dispose();
//     _counterAnimationController.dispose();
//     _floatingController.dispose();
//     nameController.dispose();
//     emailController.dispose();
//     subjectController.dispose();
//     messageController.dispose();
//     super.dispose();
//   }
//
//   // Future<void> _handleFormSubmit() async {
//   //   if (_formKey.currentState!.validate()) {
//   //     setState(() {
//   //       isLoading = true;
//   //     });
//   //
//   //     await Future.delayed(const Duration(seconds: 2));
//   //
//   //     setState(() {
//   //       isLoading = false;
//   //     });
//   //
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       const SnackBar(
//   //         content: Text('Message sent successfully!'),
//   //         backgroundColor: Colors.green,
//   //       ),
//   //     );
//   //
//   //     nameController.clear();
//   //     emailController.clear();
//   //     subjectController.clear();
//   //     messageController.clear();
//   //   }
//   // }
//
//
//   Future<void> _handleFormSubmit() async {
//     if (_formKey.currentState!.validate()) {
//       setState(() {
//         isLoading = true;
//       });
//
//       try {
//         final smtpServer = gmail('faireenazaidi7@gmail.com', 'frcprakwyztkpshi');
//
//         final message = Message()
//           ..from = Address('faireenazaidi7@gmail.com', 'Portfolio Contact Form')
//           ..recipients.add('faireenazaidi7@gmail.com')
//           ..subject = subjectController.text.isNotEmpty
//               ? subjectController.text
//               : 'New message from portfolio form'
//           ..text =
//               'Name: ${nameController.text}\nEmail: ${emailController.text}\nMessage: ${messageController.text}';
//
//         await send(message, smtpServer);
//
//         setState(() {
//           isLoading = false;
//         });
//
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Message sent successfully!'),
//             backgroundColor: Colors.green,
//           ),
//         );
//
//         // Clear the form
//         nameController.clear();
//         emailController.clear();
//         subjectController.clear();
//         messageController.clear();
//       } on MailerException catch (e) {
//         setState(() {
//           isLoading = false;
//         });
//         print(e);
//
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Failed to send message. Error: $e'),
//             backgroundColor: Colors.red,
//           ),
//         );
//       }
//     }
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               Color(0xFF667eea),
//               Color(0xFF764ba2),
//               Color(0xFF667eea),
//             ],
//           ),
//         ),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               _buildHeader(),
//               _buildNavigation(),
//               _buildContent(),
//               _buildFooter(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildHeader() {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
//       child: Stack(
//         children: [
//           // Floating elements
//           ..._buildFloatingElements(),
//
//           // Main content
//           Center(
//             child: Column(
//               children: [
//                 // Profile image
//                 AnimatedBuilder(
//                   animation: _profileAnimation,
//                   builder: (context, child) {
//                     return Transform.scale(
//                       scale: _profileAnimation.value,
//                       child: Container(
//                         width: 150,
//                         height: 150,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           gradient: const LinearGradient(
//                             colors: [Color(0xFFff6b6b), Color(0xFF4ecdc4)],
//                           ),
//                           border: Border.all(
//                             color: Colors.white.withOpacity(0.3),
//                             width: 5,
//                           ),
//                         ),
//                         child: const Center(
//                           child: Text(
//                             '🚀',
//                             style: TextStyle(fontSize: 60),
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//                 const SizedBox(height: 20),
//
//                 // Name and title
//                 TweenAnimationBuilder<double>(
//                   duration: const Duration(seconds: 1),
//                   tween: Tween(begin: 0.0, end: 1.0),
//                   builder: (context, value, child) {
//                     return Transform.translate(
//                       offset: Offset(0, 30 * (1 - value)),
//                       child: Opacity(
//                         opacity: value,
//                         child: Column(
//                           children: [
//                             Center(
//                               child: Text(
//                                 'Faireena Flutter Dev',
//                                 style: TextStyle(
//                                   fontSize: MediaQuery
//                                       .of(context)
//                                       .size
//                                       .width > 768 ? 60 : 40,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(height: 10),
//                             Center(
//                               child: Text(
//                                 'Crafting Beautiful Mobile Experiences with Flutter & Dart',
//                                 style: TextStyle(
//                                   fontSize: MediaQuery
//                                       .of(context)
//                                       .size
//                                       .width > 768 ? 24 : 18,
//                                   color: Colors.white.withOpacity(0.9),
//                                 ),
//                                 textAlign: TextAlign.center,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   List<Widget> _buildFloatingElements() {
//     return [
//       AnimatedBuilder(
//         animation: _floatingAnimation,
//         builder: (context, child) {
//           return Positioned(
//             top: 40 + _floatingAnimation.value,
//             left: 40,
//             child: const Text(
//                 '🎯', style: TextStyle(fontSize: 60, color: Colors.white10)),
//           );
//         },
//       ),
//       AnimatedBuilder(
//         animation: _floatingAnimation,
//         builder: (context, child) {
//           return Positioned(
//             top: 80 - _floatingAnimation.value,
//             right: 60,
//             child: const Text(
//                 '📱', style: TextStyle(fontSize: 60, color: Colors.white10)),
//           );
//         },
//       ),
//       AnimatedBuilder(
//         animation: _floatingAnimation,
//         builder: (context, child) {
//           return Positioned(
//             bottom: 80 + _floatingAnimation.value,
//             left: 80,
//             child: const Text(
//                 '⚡', style: TextStyle(fontSize: 60, color: Colors.white10)),
//           );
//         },
//       ),
//     ];
//   }
//
//   Widget _buildNavigation() {
//     final sections = ['About', 'Skills', 'Projects', 'Contact'];
//
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//       child: Wrap(
//         alignment: WrapAlignment.center,
//         spacing: 16,
//         runSpacing: 16,
//         children: sections
//             .asMap()
//             .entries
//             .map((entry) {
//           final index = entry.key;
//           final section = entry.value;
//           final isActive = activeSection == index;
//
//           return AnimatedContainer(
//             duration: const Duration(milliseconds: 300),
//             child: ElevatedButton(
//               onPressed: () {
//                 setState(() {
//                   activeSection = index;
//                 });
//                 if (index == 0) _animateCounters();
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: isActive
//                     ? Colors.white.withOpacity(0.2)
//                     : Colors.white.withOpacity(0.1),
//                 foregroundColor: Colors.white,
//                 elevation: 0,
//                 padding: const EdgeInsets.symmetric(
//                     horizontal: 24, vertical: 12),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(25),
//                 ),
//               ),
//               child: Text(
//                 section,
//                 style: const TextStyle(
//                   fontWeight: FontWeight.w600,
//                   fontSize: 16,
//                 ),
//               ),
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }
//
//   Widget _buildContent() {
//     return Container(
//       margin: const EdgeInsets.all(20),
//       padding: const EdgeInsets.all(40),
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.95),
//         borderRadius: BorderRadius.circular(30),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 40,
//             spreadRadius: 0,
//             offset: const Offset(0, 20),
//           ),
//         ],
//       ),
//       child: AnimatedSwitcher(
//         duration: const Duration(milliseconds: 500),
//         child: _getCurrentSection(),
//       ),
//     );
//   }
//
//   Widget _getCurrentSection() {
//     switch (activeSection) {
//       case 0:
//         return _buildAboutSection();
//       case 1:
//         return _buildSkillsSection();
//       case 2:
//         return _buildProjectsSection();
//       case 3:
//         return _buildContactSection();
//       default:
//         return _buildAboutSection();
//     }
//   }
//
//   Widget _buildAboutSection() {
//     return Column(
//       key: const ValueKey('about'),
//       children: [
//         LayoutBuilder(
//           builder: (context, constraints) {
//             final isWide = constraints.maxWidth > 768;
//
//             if (isWide) {
//               return Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Expanded(flex: 1, child: _buildStatsGrid()),
//                   const SizedBox(width: 40),
//                   Expanded(flex: 2, child: _buildAboutText()),
//                 ],
//               );
//             } else {
//               return Column(
//                 children: [
//                   _buildStatsGrid(),
//                   const SizedBox(height: 40),
//                   _buildAboutText(),
//                 ],
//               );
//             }
//           },
//         ),
//       ],
//     );
//   }
//
//   Widget _buildStatsGrid() {
//     final stats = [
//       {
//         'number': '$experienceYears+',
//         'label': 'Years Experience',
//         'colors': [Color(0xFF667eea), Color(0xFF764ba2)]
//       },
//       {
//         'number': '$projectsCount+',
//         'label': 'Projects Completed',
//         'colors': [Color(0xFF764ba2), Color(0xFFf093fb)]
//       },
//       {
//         'number': '$appsCount+',
//         'label': 'Apps Published',
//         'colors': [Color(0xFFf093fb), Color(0xFFf5576c)]
//       },
//       {
//         'number': '4.9',
//         'label': 'Client Rating',
//         'colors': [Color(0xFF4ecdc4), Color(0xFF44a08d)]
//       },
//     ];
//
//     return GridView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         childAspectRatio: 1.2,
//         crossAxisSpacing: 16,
//         mainAxisSpacing: 16,
//       ),
//       itemCount: stats.length,
//       itemBuilder: (context, index) {
//         final stat = stats[index];
//         return AnimatedContainer(
//           duration: Duration(milliseconds: 500 + index * 100),
//           curve: Curves.easeOutBack,
//           child: Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: stat['colors'] as List<Color>,
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Material(
//               color: Colors.transparent,
//               child: InkWell(
//                 borderRadius: BorderRadius.circular(20),
//                 onTap: () {},
//                 child: Container(
//                   padding: const EdgeInsets.all(20),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         stat['number'] as String,
//                         style: const TextStyle(
//                           fontSize: 32,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         stat['label'] as String,
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: Colors.white.withOpacity(0.9),
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _buildAboutText() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'About Me',
//           style: TextStyle(
//             fontSize: 40,
//             fontWeight: FontWeight.bold,
//             color: Color(0xFF333333),
//           ),
//         ),
//         const SizedBox(height: 24),
//         const Text(
//           "I'm a passionate Flutter developer with over 3 years of experience in creating stunning cross-platform mobile applications. My journey began with native Android development, but I fell in love with Flutter's ability to create beautiful, performant apps for both iOS and Android from a single codebase.",
//           style: TextStyle(
//             fontSize: 16,
//             color: Color(0xFF666666),
//             height: 1.6,
//           ),
//         ),
//         const SizedBox(height: 16),
//         const Text(
//           "I specialize in building user-centric applications with clean architecture, smooth animations, and pixel-perfect UI implementations. My expertise spans from complex state management solutions to integrating third-party APIs and creating custom widgets.",
//           style: TextStyle(
//             fontSize: 16,
//             color: Color(0xFF666666),
//             height: 1.6,
//           ),
//         ),
//         const SizedBox(height: 16),
//         const Text(
//           "When I'm not coding, you can find me contributing to open-source Flutter projects, writing technical blogs, or exploring the latest developments in mobile technology.",
//           style: TextStyle(
//             fontSize: 16,
//             color: Color(0xFF666666),
//             height: 1.6,
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildSkillsSection() {
//     final skills = [
//       {
//         'icon': '🎯',
//         'title': 'Flutter & Dart',
//         'description': 'Expert in Flutter framework, Dart language, custom widgets, and advanced animations'
//       },
//       {
//         'icon': '🏗️',
//         'title': 'State Management',
//         'description': 'Proficient in BLoC, Provider, Riverpod, GetX, and MobX for scalable app architecture'
//       },
//       {
//         'icon': '🔥',
//         'title': 'Firebase',
//         'description': 'Integration with Firestore, Authentication, Cloud Functions, and Push Notifications'
//       },
//       {
//         'icon': '📡',
//         'title': 'API Integration',
//         'description': 'REST APIs, GraphQL, WebSocket connections, and efficient data caching strategies'
//       },
//       {
//         'icon': '🧪',
//         'title': 'Testing',
//         'description': 'Unit testing, widget testing, integration testing, and test-driven development'
//       },
//       {
//         'icon': '🚀',
//         'title': 'DevOps',
//         'description': 'CI/CD pipelines, automated deployments, and app store publishing workflows'
//       },
//     ];
//
//     return Column(
//       key: const ValueKey('skills'),
//       children: [
//         const Text(
//           'Technical Skills',
//           style: TextStyle(
//             fontSize: 40,
//             fontWeight: FontWeight.bold,
//             color: Color(0xFF333333),
//           ),
//         ),
//         const SizedBox(height: 48),
//         GridView.builder(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: MediaQuery
//                 .of(context)
//                 .size
//                 .width > 1200 ? 3 :
//             MediaQuery
//                 .of(context)
//                 .size
//                 .width > 768 ? 2 : 1,
//             childAspectRatio: 1.1,
//             crossAxisSpacing: 24,
//             mainAxisSpacing: 24,
//           ),
//           itemCount: skills.length,
//           itemBuilder: (context, index) {
//             final skill = skills[index];
//             return TweenAnimationBuilder<double>(
//               duration: Duration(milliseconds: 500 + index * 100),
//               tween: Tween(begin: 0.0, end: 1.0),
//               builder: (context, value, child) {
//                 return Transform.translate(
//                   offset: Offset(0, 50 * (1 - value)),
//                   child: Opacity(
//                     opacity: value,
//                     child: Container(
//                       decoration: BoxDecoration(
//                         gradient: const LinearGradient(
//                           colors: [Color(0xFF667eea), Color(0xFF764ba2)],
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                         ),
//                         borderRadius: BorderRadius.circular(20),
//                         boxShadow: [
//                           BoxShadow(
//                             color: const Color(0xFF667eea).withOpacity(0.3),
//                             blurRadius: 20,
//                             offset: const Offset(0, 10),
//                           ),
//                         ],
//                       ),
//                       child: Material(
//                         color: Colors.transparent,
//                         child: InkWell(
//                           borderRadius: BorderRadius.circular(20),
//                           onTap: () {},
//                           child: Container(
//                             padding: const EdgeInsets.all(32),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   skill['icon'] as String,
//                                   style: const TextStyle(fontSize: 48),
//                                 ),
//                                 const SizedBox(height: 16),
//                                 Text(
//                                   skill['title'] as String,
//                                   style: const TextStyle(
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.white,
//                                   ),
//                                   textAlign: TextAlign.center,
//                                 ),
//                                 const SizedBox(height: 12),
//                                 Text(
//                                   skill['description'] as String,
//                                   style: TextStyle(
//                                     fontSize: 14,
//                                     color: Colors.white.withOpacity(0.9),
//                                     height: 1.4,
//                                   ),
//                                   textAlign: TextAlign.center,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             );
//           },
//         ),
//       ],
//     );
//   }
//
//   Widget _buildProjectsSection() {
//     final projects = [
//       {
//         'icon': '🛍️',
//         'title': 'E-Commerce Flutter App',
//         'description': 'A full-featured e-commerce application with shopping cart, payment integration, order tracking, and admin panel.',
//         'tags': ['Flutter', 'Firebase', 'Stripe', 'BLoC'],
//         'gradient': [Color(0xFF667eea), Color(0xFF764ba2)],
//       },
//       {
//         'icon': '💬',
//         'title': 'Real-time Chat App',
//         'description': 'Secure messaging app with end-to-end encryption, group chats, file sharing, and voice messages.',
//         'tags': ['Flutter', 'WebSocket', 'Encryption', 'Provider'],
//         'gradient': [Color(0xFFf093fb), Color(0xFFf5576c)],
//       },
//       {
//         'icon': '📊',
//         'title': 'Analytics Dashboard',
//         'description': 'Beautiful data visualization app with interactive charts, real-time updates, and custom widgets.',
//         'tags': ['Flutter', 'Charts', 'REST API', 'Riverpod'],
//         'gradient': [Color(0xFF4ecdc4), Color(0xFF44a08d)],
//       },
//       {
//         'icon': '🎵',
//         'title': 'Music Streaming App',
//         'description': 'Spotify-like music streaming app with playlists, offline mode, and beautiful audio visualizations.',
//         'tags': ['Flutter', 'Audio', 'SQLite', 'GetX'],
//         'gradient': [Color(0xFFa8edea), Color(0xFFfed6e3)],
//       },
//     ];
//
//     return Column(
//       key: const ValueKey('projects'),
//       children: [
//         const Text(
//           'Featured Projects',
//           style: TextStyle(
//             fontSize: 40,
//             fontWeight: FontWeight.bold,
//             color: Color(0xFF333333),
//           ),
//         ),
//         const SizedBox(height: 48),
//         GridView.builder(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: MediaQuery
//                 .of(context)
//                 .size
//                 .width > 768 ? 2 : 1,
//             childAspectRatio: 0.85,
//             crossAxisSpacing: 24,
//             mainAxisSpacing: 24,
//           ),
//           itemCount: projects.length,
//           itemBuilder: (context, index) {
//             final project = projects[index];
//             return TweenAnimationBuilder<double>(
//               duration: Duration(milliseconds: 500 + index * 100),
//               tween: Tween(begin: 0.0, end: 1.0),
//               builder: (context, value, child) {
//                 return Transform.translate(
//                   offset: Offset(0, 50 * (1 - value)),
//                   child: Opacity(
//                     opacity: value,
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(20),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.1),
//                             blurRadius: 20,
//                             offset: const Offset(0, 10),
//                           ),
//                         ],
//                       ),
//                       child: Material(
//                         color: Colors.transparent,
//                         child: InkWell(
//                           borderRadius: BorderRadius.circular(20),
//                           onTap: () {},
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               // Project image/icon
//                               Container(
//                                 height: 180,
//                                 decoration: BoxDecoration(
//                                   gradient: LinearGradient(
//                                     colors: project['gradient'] as List<Color>,
//                                     begin: Alignment.topLeft,
//                                     end: Alignment.bottomRight,
//                                   ),
//                                   borderRadius: const BorderRadius.only(
//                                     topLeft: Radius.circular(20),
//                                     topRight: Radius.circular(20),
//                                   ),
//                                 ),
//                                 child: Center(
//                                   child: Text(
//                                     project['icon'] as String,
//                                     style: const TextStyle(fontSize: 64),
//                                   ),
//                                 ),
//                               ),
//
//                               // Project content
//                               Padding(
//                                 padding: const EdgeInsets.all(24),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       project['title'] as String,
//                                       style: const TextStyle(
//                                         fontSize: 20,
//                                         fontWeight: FontWeight.bold,
//                                         color: Color(0xFF333333),
//                                       ),
//                                     ),
//                                     const SizedBox(height: 12),
//                                     Text(
//                                       project['description'] as String,
//                                       style: const TextStyle(
//                                         fontSize: 14,
//                                         color: Color(0xFF666666),
//                                         height: 1.5,
//                                       ),
//                                     ),
//                                     const SizedBox(height: 16),
//
//                                     // Tech tags
//                                     Wrap(
//                                       spacing: 8,
//                                       runSpacing: 8,
//                                       children: (project['tags'] as List<
//                                           String>).map((tag) {
//                                         return Container(
//                                           padding: const EdgeInsets.symmetric(
//                                             horizontal: 12,
//                                             vertical: 6,
//                                           ),
//                                           decoration: BoxDecoration(
//                                             gradient: LinearGradient(
//                                               colors: project['gradient'] as List<
//                                                   Color>,
//                                             ),
//                                             borderRadius: BorderRadius.circular(
//                                                 15),
//                                           ),
//                                           child: Text(
//                                             tag,
//                                             style: const TextStyle(
//                                               color: Colors.white,
//                                               fontSize: 12,
//                                               fontWeight: FontWeight.w500,
//                                             ),
//                                           ),
//                                         );
//                                       }).toList(),
//                                     ),
//                                     const SizedBox(height: 20),
//
//                                     // Action buttons
//                                     Row(
//                                       children: [
//                                         Expanded(
//                                           child: OutlinedButton(
//                                             onPressed: () {},
//                                             style: OutlinedButton.styleFrom(
//                                               foregroundColor: (project['gradient'] as List<
//                                                   Color>)[0],
//                                               side: BorderSide(
//                                                 color: (project['gradient'] as List<
//                                                     Color>)[0],
//                                                 width: 2,
//                                               ),
//                                               padding: const EdgeInsets
//                                                   .symmetric(vertical: 12),
//                                               shape: RoundedRectangleBorder(
//                                                 borderRadius: BorderRadius
//                                                     .circular(8),
//                                               ),
//                                             ),
//                                             child: const Text(
//                                               'Live Demo',
//                                               style: TextStyle(
//                                                   fontWeight: FontWeight.w600),
//                                             ),
//                                           ),
//                                         ),
//                                         const SizedBox(width: 12),
//                                         Expanded(
//                                           child: OutlinedButton(
//                                             onPressed: () {},
//                                             style: OutlinedButton.styleFrom(
//                                               foregroundColor: (project['gradient'] as List<
//                                                   Color>)[1],
//                                               side: BorderSide(
//                                                 color: (project['gradient'] as List<
//                                                     Color>)[1],
//                                                 width: 2,
//                                               ),
//                                               padding: const EdgeInsets
//                                                   .symmetric(vertical: 12),
//                                               shape: RoundedRectangleBorder(
//                                                 borderRadius: BorderRadius
//                                                     .circular(8),
//                                               ),
//                                             ),
//                                             child: const Text(
//                                               'Source Code',
//                                               style: TextStyle(
//                                                   fontWeight: FontWeight.w600),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             );
//           },
//         ),
//       ],
//     );
//   }
//
//   Widget _buildContactSection() {
//     return Column(
//       key: const ValueKey('contact'),
//       children: [
//         const Text(
//           "Open to Opportunities",
//           style: TextStyle(
//             fontSize: 40,
//             fontWeight: FontWeight.bold,
//             color: Color(0xFF333333),
//           ),
//         ),
//         const SizedBox(height: 12),
//         const Text(
//           "I’m currently seeking job opportunities as a Flutter developer. "
//               "Feel free to reach out if you'd like to connect!",
//           textAlign: TextAlign.center,
//           style: TextStyle(
//             fontSize: 16,
//             color: Color(0xFF666666),
//           ),
//         ),
//         const SizedBox(height: 48),
//         Container(
//           constraints: const BoxConstraints(maxWidth: 600),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: [
//                 _buildTextField(
//                   controller: nameController,
//                   label: 'Your Name',
//                   hint: 'Enter your full name',
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter your name';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 24),
//                 _buildTextField(
//                   controller: emailController,
//                   label: 'Email Address',
//                   hint: 'Enter your email',
//                   keyboardType: TextInputType.emailAddress,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter your email';
//                     }
//                     if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
//                         .hasMatch(value)) {
//                       return 'Please enter a valid email';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 24),
//                 _buildTextField(
//                   controller: messageController,
//                   label: 'Your Message',
//                   hint: 'Tell me about the opportunity or how we can connect...',
//                   maxLines: 6,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter your message';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 32),
//
//                 // Submit button
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: isLoading ? null : _handleFormSubmit,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF667eea),
//                       foregroundColor: Colors.white,
//                       padding: const EdgeInsets.symmetric(vertical: 16),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       elevation: 0,
//                     ),
//                     child: isLoading
//                         ? const Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         SizedBox(
//                           width: 20,
//                           height: 20,
//                           child: CircularProgressIndicator(
//                             valueColor:
//                             AlwaysStoppedAnimation<Color>(Colors.white),
//                             strokeWidth: 2,
//                           ),
//                         ),
//                         SizedBox(width: 12),
//                         Text(
//                           'Sending Message...',
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ],
//                     )
//                         : const Text(
//                       'Send Message',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String label,
//     required String hint,
//     int maxLines = 1,
//     TextInputType? keyboardType,
//     String? Function(String?)? validator,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: const TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.w600,
//             color: Color(0xFF333333),
//           ),
//         ),
//         const SizedBox(height: 8),
//         TextFormField(
//           controller: controller,
//           maxLines: maxLines,
//           keyboardType: keyboardType,
//           validator: validator,
//           decoration: InputDecoration(
//             hintText: hint,
//             hintStyle: TextStyle(color: Colors.grey[400]),
//             filled: true,
//             fillColor: Colors.grey[50],
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: BorderSide(color: Colors.grey[300]!, width: 2),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: BorderSide(color: Colors.grey[300]!, width: 2),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: const BorderSide(color: Color(0xFF667eea), width: 2),
//             ),
//             errorBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: const BorderSide(color: Colors.red, width: 2),
//             ),
//             focusedErrorBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: const BorderSide(color: Colors.red, width: 2),
//             ),
//             contentPadding: const EdgeInsets.all(16),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildFooter() {
//     final socialLinks = [
//       {'icon': '📧', 'label': 'Email'},
//       {'icon': '💼', 'label': 'LinkedIn'},
//       {'icon': '🐙', 'label': 'GitHub'},
//       {'icon': '🐦', 'label': 'Twitter'},
//     ];
//
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 20),
//       child: Column(
//         children: [
//           // Social links
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: socialLinks.map((social) {
//               return Container(
//                 margin: const EdgeInsets.symmetric(horizontal: 12),
//                 child: Material(
//                   color: Colors.white.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(25),
//                   child: InkWell(
//                     borderRadius: BorderRadius.circular(25),
//                     onTap: () {
//                       HapticFeedback.lightImpact();
//                       // Handle social link tap
//                     },
//                     child: Container(
//                       width: 50,
//                       height: 50,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(25),
//                         border: Border.all(
//                           color: Colors.white.withOpacity(0.2),
//                           width: 1,
//                         ),
//                       ),
//                       child: Center(
//                         child: Text(
//                           social['icon'] as String,
//                           style: const TextStyle(fontSize: 24),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             }).toList(),
//           ),
//           const SizedBox(height: 24),
//
//           // Copyright
//           Text(
//             '© 2024 Alex Flutter Dev. Crafted with Flutter & ❤️',
//             style: TextStyle(
//               color: Colors.white.withOpacity(0.8),
//               fontSize: 16,
//             ),
//             textAlign: TextAlign.center,
//           ),
//         ],
//       ),
//     );
//   }
// }
// class HoverEffect extends StatefulWidget {
//   final Widget child;
//   final double scale;
//   final Duration duration;
//
//   const HoverEffect({
//     super.key,
//     required this.child,
//     this.scale = 1.05,
//     this.duration = const Duration(milliseconds: 200),
//   });
//
//   @override
//   State<HoverEffect> createState() => _HoverEffectState();
// }
//
// class _HoverEffectState extends State<HoverEffect> {
//   bool _isHovered = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return MouseRegion(
//       onEnter: (_) => setState(() => _isHovered = true),
//       onExit: (_) => setState(() => _isHovered = false),
//       child: AnimatedScale(
//         scale: _isHovered ? widget.scale : 1.0,
//         duration: widget.duration,
//         child: widget.child,
//       ),
//     );
//   }
// }
//
// class GradientText extends StatelessWidget {
//   final String text;
//   final TextStyle style;
//   final Gradient gradient;
//
//   const GradientText({
//     super.key,
//     required this.text,
//     required this.style,
//     required this.gradient,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return ShaderMask(
//       blendMode: BlendMode.srcIn,
//       shaderCallback: (bounds) => gradient.createShader(
//         Rect.fromLTWH(0, 0, bounds.width, bounds.height),
//       ),
//       child: Text(text, style: style),
//     );
//   }
// }
//
// class AnimatedCounter extends StatefulWidget {
//   final int value;
//   final Duration duration;
//   final TextStyle? style;
//   final String suffix;
//
//   const AnimatedCounter({
//     super.key,
//     required this.value,
//     this.duration = const Duration(seconds: 2),
//     this.style,
//     this.suffix = '',
//   });
//
//   @override
//   State<AnimatedCounter> createState() => _AnimatedCounterState();
// }
//
// class _AnimatedCounterState extends State<AnimatedCounter>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(duration: widget.duration, vsync: this);
//     _animation = Tween<double>(begin: 0, end: widget.value.toDouble())
//         .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
//     _controller.forward();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _animation,
//       builder: (context, child) {
//         return Text(
//           '${_animation.value.round()}${widget.suffix}',
//           style: widget.style,
//         );
//       },
//     );
//   }
// }
//
// class ResponsiveBuilder extends StatelessWidget {
//   final Widget Function(BuildContext context, bool isMobile, bool isTablet, bool isDesktop) builder;
//
//   const ResponsiveBuilder({super.key, required this.builder});
//
//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     final isMobile = width < 600;
//     final isTablet = width >= 600 && width < 1024;
//     final isDesktop = width >= 1024;
//
//     return builder(context, isMobile, isTablet, isDesktop);
//   }
// }
//
// // Custom page route for smooth transitions
// class FadePageRoute<T> extends PageRoute<T> {
//   final WidgetBuilder builder;
//
//   FadePageRoute({required this.builder});
//
//   @override
//   Color get barrierColor => Colors.transparent;
//
//   @override
//   String get barrierLabel => '';
//
//   @override
//   bool get maintainState => true;
//
//   @override
//   Duration get transitionDuration => const Duration(milliseconds: 300);
//
//   @override
//   Widget buildPage(BuildContext context, Animation<double> animation,
//       Animation<double> secondaryAnimation) {
//     return FadeTransition(
//       opacity: animation,
//       child: builder(context),
//     );
//   }
//
//   @override
//   Widget buildTransitions(BuildContext context, Animation<double> animation,
//       Animation<double> secondaryAnimation, Widget child) {
//     return FadeTransition(opacity: animation, child: child);
//   }
//
//   @override
//   bool get barrierDismissible => false;
// }
//
//
//
// //////////////
// class PortfolioHome extends StatefulWidget {
//   final bool isDarkMode;
//   final VoidCallback onThemeToggle;
//
//   const PortfolioHome({super.key, required this.isDarkMode, required this.onThemeToggle});
//
//   @override
//   PortfolioHomeState createState() => PortfolioHomeState();
// }
//
// class PortfolioHomeState extends State<PortfolioHome> with TickerProviderStateMixin {
//   late ScrollController _scrollController;
//   late AnimationController _heroController;
//   late AnimationController _floatingController;
//   late AnimationController _rainbowController;
//
//   late Animation<double> _heroAnimation;
//   late Animation<double> _floatingAnimation;
//
//   bool _isScrolled = false;
//   final _formKey = GlobalKey<FormState>();
//   final _nameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _messageController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     _scrollController = ScrollController();
//     _heroController = AnimationController(
//       duration: Duration(milliseconds: 1200),
//       vsync: this,
//     );
//     _floatingController = AnimationController(
//       duration: Duration(seconds: 6),
//       vsync: this,
//     );
//     _rainbowController = AnimationController(
//       duration: Duration(seconds: 4),
//       vsync: this,
//     );
//
//     _heroAnimation = CurvedAnimation(
//       parent: _heroController,
//       curve: Curves.easeOutCubic,
//     );
//
//     _floatingAnimation = CurvedAnimation(
//       parent: _floatingController,
//       curve: Curves.easeInOut,
//     );
//
//     _scrollController.addListener(_onScroll);
//     _heroController.forward();
//     _floatingController.repeat();
//     _rainbowController.repeat();
//   }
//
//   void _onScroll() {
//     bool isScrolled = _scrollController.offset > 100;
//     if (_isScrolled != isScrolled) {
//       setState(() => _isScrolled = isScrolled);
//     }
//   }
//
//   @override
//   void dispose() {
//     _scrollController.dispose();
//     _heroController.dispose();
//     _floatingController.dispose();
//     _rainbowController.dispose();
//     _nameController.dispose();
//     _emailController.dispose();
//     _messageController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           CustomScrollView(
//             controller: _scrollController,
//             slivers: [
//               _buildHeroSection(),
//               _buildAboutSection(),
//               _buildSkillsSection(),
//               _buildProjectsSection(),
//               _buildContactSection(),
//             ],
//           ),
//           buildNavBar(),
//         ],
//       ),
//     );
//   }
//
//   Widget buildNavBar() {
//     return Positioned(
//       top: 0,
//       left: 0,
//       right: 0,
//       child: ClipRRect(
//         child: BackdropFilter(
//           filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
//           child: AnimatedContainer(
//             duration: Duration(milliseconds: 300),
//             padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//             decoration: BoxDecoration(
//               color: _isScrolled
//                   ? (widget.isDarkMode
//                   ? Color(0xFF0f0f23).withOpacity(0.95)
//                   : Colors.white.withOpacity(0.95))
//                   : Colors.transparent,
//               boxShadow: _isScrolled
//                   ? [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.1),
//                   blurRadius: 20,
//                   offset: Offset(0, 2),
//                 ),
//               ]
//                   : null,
//             ),
//             child: SafeArea(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   ShaderMask(
//                     shaderCallback: (bounds) => LinearGradient(
//                       colors: [Color(0xFF667eea), Color(0xFF764ba2)],
//                     ).createShader(bounds),
//                     child: Text(
//                       'Faireena Zaidi',
//                       style: TextStyle(
//                         fontSize: 28,
//                         fontWeight: FontWeight.w800,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                   Row(
//                     children: [
//                       // _buildNavItem('Home', () => _scrollTo(0)),
//                       // _buildNavItem('About', () => _scrollTo(1)),
//                       // _buildNavItem('Skills', () => _scrollTo(2)),
//                       // _buildNavItem('Projects', () => _scrollTo(3)),
//                       // _buildNavItem('Contact', () => _scrollTo(4)),
//                       SizedBox(width: 15),
//                       _buildThemeToggle(),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//
//   }
//
//   Widget _buildNavItem(String text, VoidCallback onTap) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 15),
//       child: InkWell(
//         onTap: onTap,
//         child: Padding(
//           padding: EdgeInsets.symmetric(vertical: 8),
//           child: Text(
//             text,
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.w600,
//               color: widget.isDarkMode ? Colors.white : Colors.black87,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildThemeToggle() {
//     return Container(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(colors: [Color(0xFF667eea), Color(0xFF764ba2)]),
//         borderRadius: BorderRadius.circular(25),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.2),
//             blurRadius: 10,
//             offset: Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           onTap: widget.onThemeToggle,
//           borderRadius: BorderRadius.circular(25),
//           child: Container(
//             width: 50,
//             height: 50,
//             child: Icon(
//               widget.isDarkMode ? Icons.wb_sunny : Icons.dark_mode,
//               color: Colors.white,
//               size: 20,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildHeroSection() {
//     return SliverToBoxAdapter(
//       child: Container(
//         height: MediaQuery.of(context).size.height,
//         decoration: BoxDecoration(
//           gradient: widget.isDarkMode
//               ? LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [Color(0xFF0f0f23), Color(0xFF1a1a2e), Color(0xFF16213e)],
//           )
//               : LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [Color(0xFF667eea), Color(0xFF764ba2)],
//           ),
//         ),
//         child: Stack(
//           children: [
//             // Floating Elements
//             ..._buildFloatingElements(),
//
//             // Hero Content
//             Center(
//               child: FadeTransition(
//                 opacity: _heroAnimation,
//                 child: SlideTransition(
//                   position: Tween<Offset>(
//                     begin: Offset(0, 0.3),
//                     end: Offset.zero,
//                   ).animate(_heroAnimation),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       // Animated Rainbow Text
//                       AnimatedBuilder(
//                         animation: _rainbowController,
//                         builder: (context, child) {
//                           return ShaderMask(
//                             shaderCallback: (bounds) {
//                               return LinearGradient(
//                                 colors: [
//                                   Color(0xFFff6b6b),
//                                   Color(0xFF4ecdc4),
//                                   Color(0xFF45b7d1),
//                                   Color(0xFF96ceb4),
//                                   Color(0xFFffeaa7),
//                                 ],
//                                 stops: [0.0, 0.25, 0.5, 0.75, 1.0],
//                                 transform: GradientRotation(_rainbowController.value * 2 * math.pi),
//                               ).createShader(bounds);
//                             },
//                             child: Text(
//                               'Flutter Developer',
//                               style: TextStyle(
//                                 fontSize: 64,
//                                 fontWeight: FontWeight.w800,
//                                 color: Colors.white,
//                                 height: 1.1,
//                               ),
//                               textAlign: TextAlign.center,
//                             ),
//                           );
//                         },
//                       ),
//                       SizedBox(height: 30),
//                       Text(
//                         'Creating stunning mobile experiences with beautiful animations',
//                         style: TextStyle(
//                           fontSize: 22,
//                           color: Colors.white.withOpacity(0.9),
//                          // height: 1.4,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                       SizedBox(height: 50),
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           _buildAnimatedButton(
//                             'View My Work',
//                             Icons.rocket_launch,
//                             [Color(0xFFf093fb), Color(0xFFf5576c)],
//                                 () => _scrollTo(6),
//                           ),
//                           SizedBox(height: 20),
//                           _buildAnimatedButton(
//                             'Download CV',
//                             Icons.download,
//                             [Colors.transparent, Colors.transparent],
//                             _downloadCV,
//                             isOutlined: true,
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   List<Widget> _buildFloatingElements() {
//     final elements = <Widget>[];
//     final gradients = [
//       [Color(0xFF4facfe), Color(0xFF00f2fe)],
//       [Color(0xFF43e97b), Color(0xFF38f9d7)],
//       [Color(0xFFf093fb), Color(0xFFf5576c)],
//     ];
//
//     final positions = [
//       Offset(0.1, 0.2),
//       Offset(0.85, 0.6),
//       Offset(0.2, 0.7),
//     ];
//
//     for (int i = 0; i < 2; i++) {
//       elements.add(
//         AnimatedBuilder(
//           animation: _floatingAnimation,
//           builder: (context, child) {
//             return Positioned(
//               left: MediaQuery.of(context).size.width * positions[i].dx,
//               top: MediaQuery.of(context).size.height * positions[i].dy + math.sin(_floatingAnimation.value * 2 * math.pi + i) * 10,
//               child: Transform.rotate(
//                 angle: _floatingAnimation.value * 2 * math.pi,
//                 child: Opacity(
//                   opacity: 0.3,
//                   child: Container(
//                     width: 70 + i * 20,
//                     height: 70 + i * 20,
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(colors: gradients[i]),
//                       shape: BoxShape.circle,
//                       boxShadow: [
//                         BoxShadow(
//                           color: gradients[i][0].withOpacity(0.5),
//                           blurRadius: 25,
//                           offset: Offset(0, 10),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       );
//     }
//     return elements;
//   }
//
//   Widget _buildAnimatedButton(String text, IconData icon, List<Color> colors, VoidCallback onPressed, {bool isOutlined = false}) {
//     return AnimatedContainer(
//       duration: Duration(milliseconds: 200),
//       decoration: BoxDecoration(
//         gradient: isOutlined ? null : LinearGradient(colors: colors),
//         borderRadius: BorderRadius.circular(30),
//         border: isOutlined ? Border.all(color: Colors.white.withOpacity(0.3), width: 2) : null,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.3),
//             blurRadius: 15,
//             offset: Offset(0, 8),
//           ),
//         ],
//       ),
//       child: Material(
//         color: isOutlined ? Colors.white.withOpacity(0.1) : Colors.transparent,
//         borderRadius: BorderRadius.circular(30),
//         child: InkWell(
//           onTap: onPressed,
//           borderRadius: BorderRadius.circular(30),
//           child: Container(
//             padding: EdgeInsets.symmetric(horizontal: 35, vertical: 18),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Icon(icon, color: Colors.white, size: 20),
//                 SizedBox(width: 12),
//                 Text(text, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildAboutSection() {
//     return SliverToBoxAdapter(
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 50, vertical: 120),
//         color: widget.isDarkMode ? Color(0xFF0f0f23) : Colors.white,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             _buildSectionTitle('About Me'),
//             SizedBox(height: 80),
//             Container(
//               width: 280,
//               height: 280,
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(colors: [Color(0xFF667eea), Color(0xFF764ba2)]),
//                 shape: BoxShape.circle,
//                 boxShadow: [
//                   BoxShadow(
//                     color: Color(0xFF667eea).withOpacity(0.4),
//                     blurRadius: 40,
//                     offset: Offset(0, 20),
//                   ),
//                 ],
//               ),
//               child: Center(
//                 child: Text(
//                   '👨‍💻',
//                   style: TextStyle(fontSize: 90),
//                 ),
//               ),
//             ),
//
//             SizedBox(height: 60),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Text(
//                   "I'm a passionate Flutter developer with 1+ years of experience crafting beautiful, performant mobile applications. I specialize in creating smooth animations and intuitive user experiences.",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 18,
//                    // height: 1.9,
//                     color: widget.isDarkMode ? Colors.white.withOpacity(0.8) : Colors.black.withOpacity(0.8),
//                   ),
//                 ),
//                 SizedBox(height: 25),
//                 Text(
//                   "My expertise includes Flutter/Dart, Firebase integration, RESTful APIs, advanced state management, and creating pixel-perfect UIs with stunning animations that delight users across iOS and Android platforms.",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 18,
//                     // height: 1.9,
//                     color: widget.isDarkMode ? Colors.white.withOpacity(0.8) : Colors.black.withOpacity(0.8),
//                   ),
//                 ),
//                 SizedBox(height: 25),
//                 Text(
//                   "I'm constantly exploring new technologies, contributing to open-source projects, and sharing knowledge with the Flutter community through blog posts and tutorials.",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 18,
//                     //height: 1.9,
//                     color: widget.isDarkMode ? Colors.white.withOpacity(0.8) : Colors.black.withOpacity(0.8),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//
//   }
//
//
//   Widget _buildSkillsSection() {
//     return SliverToBoxAdapter(
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 120),
//         decoration: BoxDecoration(
//           gradient: widget.isDarkMode
//               ? const LinearGradient(colors: [Color(0xFF1a1a2e), Color(0xFF16213e)])
//               : const LinearGradient(colors: [Color(0xFFf5f7fa), Color(0xFFc3cfe2)]),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildSectionTitle('Skills & Expertise'),
//             const SizedBox(height: 30),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: _skillsData.map((skill) {
//                 return Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 8.0),
//                   child: _buildSkillCard(skill, _skillsData.indexOf(skill)),
//                 );
//               }).toList(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//   Widget _buildSkillCard(Map<String, dynamic> skill, int index) {
//     final gradients = [
//       [Color(0xFF667eea), Color(0xFF764ba2)],
//       [Color(0xFFf093fb), Color(0xFFf5576c)],
//       [Color(0xFF4facfe), Color(0xFF00f2fe)],
//       [Color(0xFF43e97b), Color(0xFF38f9d7)],
//       [Color(0xFFfa709a), Color(0xFFfee140)],
//       [Color(0xFFa8edea), Color(0xFFfed6e3)],
//     ];
//
//     return Container(
//       padding: EdgeInsets.all(40),
//       decoration: BoxDecoration(
//         color: widget.isDarkMode ? Color(0xFF1a1a2e) : Colors.white,
//         borderRadius: BorderRadius.circular(25),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(widget.isDarkMode ? 0.3 : 0.1),
//             blurRadius: 30,
//             offset: Offset(0, 15),
//           ),
//         ],
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             width: 80,
//             height: 80,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(colors: gradients[index % gradients.length]),
//               borderRadius: BorderRadius.circular(20),
//               boxShadow: [
//                 BoxShadow(
//                   color: gradients[index % gradients.length][0].withOpacity(0.4),
//                   blurRadius: 20,
//                   offset: Offset(0, 8),
//                 ),
//               ],
//             ),
//             child: Icon(
//               skill['icon'],
//               size: 32,
//               color: Colors.white,
//             ),
//           ),
//           SizedBox(height: 25),
//           Text(
//             skill['title'],
//             style: TextStyle(
//               fontSize: 22,
//               fontWeight: FontWeight.w700,
//               color: widget.isDarkMode ? Colors.white : Colors.black,
//             ),
//             textAlign: TextAlign.center,
//           ),
//           SizedBox(height: 20),
//           Text(
//             skill['description'],
//             style: TextStyle(
//               fontSize: 16,
//               color: widget.isDarkMode ? Colors.white.withOpacity(0.8) : Colors.black.withOpacity(0.7),
//               height: 1.6,
//             ),
//             textAlign: TextAlign.center,
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildProjectsSection() {
//     return SliverToBoxAdapter(
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 50, vertical: 120),
//         color: widget.isDarkMode ? Color(0xFF0f0f23) : Colors.white,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildSectionTitle('Featured Projects'),
//             SizedBox(height: 30),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: _projectsData.map((project) {
//                 return Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 8.0),
//                   child: _buildProjectCard(project, _projectsData.indexOf(project)),
//                 );
//               }).toList(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildProjectCard(Map<String, dynamic> project, int index) {
//     final gradients = [
//       [Color(0xFFf093fb), Color(0xFFf5576c)],
//       [Color(0xFF4facfe), Color(0xFF00f2fe)],
//       [Color(0xFF43e97b), Color(0xFF38f9d7)],
//     ];
//
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 20), // spacing between cards
//       decoration: BoxDecoration(
//         color: widget.isDarkMode ? Color(0xFF1a1a2e) : Colors.white,
//         borderRadius: BorderRadius.circular(25),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(widget.isDarkMode ? 0.3 : 0.1),
//             blurRadius: 30,
//             offset: Offset(0, 15),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             height: 220,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(colors: gradients[index % gradients.length]),
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(25),
//                 topRight: Radius.circular(25),
//               ),
//             ),
//             child: Center(
//               child: Text(
//                 project['icon'],
//                 style: TextStyle(fontSize: 60),
//               ),
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.all(30),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   project['title'],
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.w700,
//                     color: widget.isDarkMode ? Colors.white : Colors.black,
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 Text(
//                   project['description'],
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: widget.isDarkMode
//                         ? Colors.white.withOpacity(0.8)
//                         : Colors.black.withOpacity(0.7),
//                     height: 1.7,
//                   ),
//                 ),
//                 SizedBox(height: 25),
//                 Wrap(
//                   spacing: 12,
//                   runSpacing: 12,
//                   children: (project['technologies'] as List<String>)
//                       .map((tech) => Container(
//                     padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                     decoration: BoxDecoration(
//                       gradient:
//                       LinearGradient(colors: gradients[index % gradients.length]),
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Text(
//                       tech,
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 14,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ))
//                       .toList(),
//                 ),
//                 SizedBox(height: 20),
//                 Row(
//                   children: [
//                     Text(
//                       'View Project',
//                       style: TextStyle(
//                         color: gradients[index % gradients.length][0],
//                         fontWeight: FontWeight.w700,
//                         fontSize: 16,
//                       ),
//                     ),
//                     SizedBox(width: 8),
//                     Icon(
//                       Icons.arrow_forward,
//                       color: gradients[index % gradients.length][0],
//                       size: 18,
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildContactSection() {
//     return SliverToBoxAdapter(
//       child: Container(
//         width: double.infinity,
//         padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 120),
//         decoration: BoxDecoration(
//           gradient: widget.isDarkMode
//               ? const LinearGradient(colors: [Color(0xFF1a1a2e), Color(0xFF16213e)])
//               : const LinearGradient(colors: [Color(0xFFf5f7fa), Color(0xFFc3cfe2)]),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center, // Center the column
//           children: [
//             _buildSectionTitle('Open to Opportunities'),
//             SizedBox(height: 20),
//             Text(
//               "I'm currently seeking job opportunities as a Flutter developer. Feel free to reach out if you'd like to connect!",
//               style: TextStyle(
//                 fontSize: 20,
//                 height: 1.9,
//                 color: widget.isDarkMode ? Colors.white.withOpacity(0.8) : Colors.black.withOpacity(0.8),
//               ),
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: 60),
//             // Center the form container
//             Center(
//               child: Container(
//                 width: double.infinity,
//                 constraints: BoxConstraints(maxWidth: 600), // Reduced max width
//                 padding: EdgeInsets.all(30),
//                 decoration: BoxDecoration(
//                   color: widget.isDarkMode ? Color(0xFF1a1a2e) : Colors.white,
//                   borderRadius: BorderRadius.circular(25),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(widget.isDarkMode ? 0.3 : 0.1),
//                       blurRadius: 30,
//                       offset: Offset(0, 15),
//                     ),
//                   ],
//                 ),
//                 child: Form(
//                   key: _formKey,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch to full width
//                     children: [
//                       // Centered title
//                       Center(
//                         child: ShaderMask(
//                           shaderCallback: (bounds) => LinearGradient(
//                             colors: [Color(0xFF667eea), Color(0xFF764ba2)],
//                           ).createShader(bounds),
//                           child: Text(
//                             "Contact me",
//                             style: TextStyle(
//                               fontSize: 30,
//                               fontWeight: FontWeight.w800,
//                               color: Colors.white,
//                             ),
//                             textAlign: TextAlign.center,
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 40),
//                       _buildContactField(
//                         controller: _nameController,
//                         label: 'Your Name',
//                         hint: 'Enter your name',
//                         validator: (value) =>
//                         value?.isEmpty ?? true ? 'Please enter your name' : null,
//                       ),
//                       SizedBox(height: 25),
//                       _buildContactField(
//                         controller: _emailController,
//                         label: 'Email Address',
//                         hint: 'Enter your email',
//                         keyboardType: TextInputType.emailAddress,
//                         validator: (value) {
//                           if (value?.isEmpty ?? true) return 'Please enter your email';
//                           if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
//                               .hasMatch(value!)) {
//                             return 'Please enter a valid email';
//                           }
//                           return null;
//                         },
//                       ),
//                       SizedBox(height: 25),
//                       _buildContactField(
//                         controller: _messageController,
//                         label: 'Your Message',
//                         hint: 'Tell me about the opportunity or how we can connect...',
//                         maxLines: 5,
//                         validator: (value) =>
//                         value?.isEmpty ?? true ? 'Please enter your message' : null,
//                       ),
//                       SizedBox(height: 40),
//                       Container(
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                             colors: [
//                               Color(0xFF0f3460), // Deep blackish blue
//                               Color(0xFF16a085), // Emerald teal
//                               Color(0xFF1abc9c), // Brighter emerald
//                             ],
//                             begin: Alignment.topLeft,
//                             end: Alignment.bottomRight,
//                           ),
//                           borderRadius: BorderRadius.circular(15),
//                           border: Border.all(
//                             color: Colors.white.withOpacity(0.2), // Glass border effect
//                             width: 1,
//                           ),
//                           boxShadow: [
//                             // Main emerald shadow
//                             BoxShadow(
//                               color: Color(0xFF16a085).withOpacity(0.4),
//                               blurRadius: 20,
//                               offset: Offset(0, 8),
//                             ),
//                             // Inner glass glow
//                             BoxShadow(
//                               color: Color(0xFF1abc9c).withOpacity(0.2),
//                               blurRadius: 10,
//                               offset: Offset(0, 4),
//                             ),
//                             // Dark depth shadow
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.3),
//                               blurRadius: 15,
//                               offset: Offset(0, 12),
//                             ),
//                           ],
//                         ),
//                         child: Material(
//                           color: Colors.transparent,
//                           child: InkWell(
//                             onTap: _sendMessage,
//                             borderRadius: BorderRadius.circular(15),
//                             child: Padding(
//                               padding: EdgeInsets.symmetric(vertical: 20),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Icon(Icons.send, color: Colors.white, size: 20),
//                                   SizedBox(width: 12),
//                                   Text(
//                                     'Send Message',
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.w700,
//                                       fontSize: 18,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//   Widget _buildContactField({
//     required TextEditingController controller,
//     required String label,
//     required String hint,
//     TextInputType? keyboardType,
//     int maxLines = 1,
//     String? Function(String?)? validator,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(bottom: 8.0, left: 4.0),
//           child: Text(
//             label,
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.w500,
//               color: widget.isDarkMode ? Colors.white.withOpacity(0.5) : Colors.black.withOpacity(0.5),
//             ),
//           ),
//         ),
//         TextFormField(
//           controller: controller,
//           keyboardType: keyboardType,
//           maxLines: maxLines,
//           validator: validator,
//           style: TextStyle(
//             color: widget.isDarkMode ? Colors.white : Colors.black,
//             fontSize: 16,
//           ),
//           decoration: InputDecoration(
//             hintText: hint,
//             hintStyle: TextStyle(
//               color: widget.isDarkMode ? Colors.white.withOpacity(0.3) : Colors.black.withOpacity(0.3),
//             ),
//             // Normal border
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(15),
//               borderSide: BorderSide(
//                 color: widget.isDarkMode ? Colors.white.withOpacity(0.3) : Colors.black.withOpacity(0.3),
//               ),
//             ),
//             // Enabled border
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(15),
//               borderSide: BorderSide(
//                 color: widget.isDarkMode ? Colors.white.withOpacity(0.3) : Colors.black.withOpacity(0.3),
//               ),
//             ),
//             // Focused border
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(15),
//               borderSide: BorderSide(
//                 color: widget.isDarkMode ? Colors.white.withOpacity(0.5) : Colors.black.withOpacity(0.5),
//                 width: 2,
//               ),
//             ),
//             // Error border (when validation fails)
//             errorBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(15),
//               borderSide: BorderSide(
//                 color: Colors.red.shade300,
//                 width: 2,
//               ),
//             ),
//             // Focused error border (when focused and has error)
//             focusedErrorBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(15),
//               borderSide: BorderSide(
//                 color: Colors.red.shade300,
//                 width: 2,
//               ),
//             ),
//             filled: true,
//             fillColor: widget.isDarkMode
//                 ? Color(0xFF1a1a2e).withOpacity(0.8)
//                 : Color(0xFFf5f7fa).withOpacity(0.8),
//             contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
//             errorStyle: TextStyle(color: Colors.red.shade300),
//           ),
//         ),
//       ],
//     );
//   }
//   Widget _buildSectionTitle(String title) {
//     return Column(
//       children: [
//         ShaderMask(
//           shaderCallback: (bounds) => LinearGradient(
//             colors: [Color(0xFF667eea), Color(0xFF764ba2)],).createShader(bounds),
//           child: Text(title, style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800, color: Colors.white,),
//             textAlign: TextAlign.center,
//           ),
//         ),
//         SizedBox(height: 15),
//         Container(
//           width: 80,
//           height: 5,
//           decoration: BoxDecoration(
//             gradient: LinearGradient(colors: [Color(0xFF4facfe), Color(0xFF00f2fe)]),
//             borderRadius: BorderRadius.circular(3),
//           ),
//         ),
//       ],
//     );
//   }
//
//   void _scrollTo(int section) {
//     double offset = 0;
//     switch (section) {
//       case 0: offset = 0; break;
//       case 1: offset = MediaQuery.of(context).size.height; break;
//       case 2: offset = MediaQuery.of(context).size.height * 2; break;
//       case 3: offset = MediaQuery.of(context).size.height * 3; break;
//       case 4: offset = MediaQuery.of(context).size.height * 4; break;
//       case 5: offset = MediaQuery.of(context).size.height * 5; break;
//       case 6: offset = MediaQuery.of(context).size.height * 6; break;
//       case 7: offset = MediaQuery.of(context).size.height * 7; break;
//     }
//
//     _scrollController.animateTo(
//       offset,
//       duration: Duration(milliseconds: 800),
//       curve: Curves.easeInOut,
//     );
//   }
//
//   void _downloadCV() {
//     // Simulate CV download
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Container(
//           padding: EdgeInsets.symmetric(vertical: 8),
//           child: Row(
//             children: [
//               Container(
//                 padding: EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(colors: [Color(0xFF43e97b), Color(0xFF38f9d7)]),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Icon(Icons.check_circle, color: Colors.white, size: 20),
//               ),
//               SizedBox(width: 16),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(
//                       'CV Downloaded Successfully!',
//                       style: TextStyle(
//                         fontWeight: FontWeight.w700,
//                         fontSize: 16,
//                         color: Colors.white,
//                       ),
//                     ),
//                     Text(
//                       'Check your downloads folder',
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: Colors.white.withOpacity(0.8),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         behavior: SnackBarBehavior.floating,
//         duration: Duration(seconds: 4),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//         margin: EdgeInsets.all(20),
//       ),
//     );
//
//
//   }
//
//   Future<void> _sendMessage() async {
//     if (_formKey.currentState?.validate() ?? false) {
//       final name = _nameController.text.trim();
//       final email = _emailController.text.trim();
//       final messageText = _messageController.text.trim();
//
//       String username = 'faireenazaidi7@gmail.com';
//       String password = 'frcprakwyztkpshi';
//
//       final smtpServer = gmail(username, password);
//
//       final message = Message()
//         ..from = Address(username, 'Faireena Portfolio')
//         ..recipients.add('faireenazaidi7@gmail.com')
//         ..subject = 'New Contact from Portfolio: $name'
//         ..text = '''
//        New Message from your Portfolio:
//        Name: $name
//        Email: $email
//        Message:$messageText
//       ''';
//
//       try {
//         final sendReport = await send(message, smtpServer);
//         print('Message sent: $sendReport');
//
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text("Message sent successfully!"),
//             backgroundColor: Colors.green,
//           ),
//         );
//
//         // Clear fields
//         _nameController.clear();
//         _emailController.clear();
//         _messageController.clear();
//
//       } on MailerException catch (e) {
//         print('Message not sent.');
//         for (var p in e.problems) {
//           print('Problem: ${p.code}: ${p.msg}');
//         }
//
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text("Failed to send message."),
//             backgroundColor: Colors.red,
//           ),
//         );
//       }
//     }
//   }
//
// }
//
// const List<Map<String, dynamic>> _skillsData = [
//   {
//     'title': 'Flutter Development',
//     'description': 'Expert in Flutter framework with advanced widget composition, custom animations, and performance optimization techniques.',
//     'icon': Icons.phone_android,
//   },
//   {
//     'title': 'UI/UX Animation',
//     'description': 'Creating fluid animations, micro-interactions, and delightful user experiences using Flutter\'s animation framework.',
//     'icon': Icons.animation,
//   },
//   {
//     'title': 'Firebase & Backend',
//     'description': 'Full-stack mobile development with Firebase, authentication, real-time databases, and cloud functions integration.',
//     'icon': Icons.cloud,
//   },
//   {
//     'title': 'State Management',
//     'description': 'Advanced state management using BLoC, Provider, Riverpod, and GetX for scalable app architecture.',
//     'icon': Icons.architecture,
//   },
//   {
//     'title': 'API Integration',
//     'description': 'RESTful APIs, GraphQL, real-time data synchronization, and efficient caching strategies for optimal performance.',
//     'icon': Icons.api,
//   },
//   {
//     'title': 'DevOps & Deployment',
//     'description': 'CI/CD pipelines, automated testing, app store deployment, and performance monitoring solutions.',
//     'icon': Icons.rocket_launch,
//   },
// ];
//
// const List<Map<String, dynamic>> _projectsData = [
//   {
//     'title': 'E-Commerce App',
//     'description': 'A feature-rich e-commerce application with smooth animations, advanced search, AR product preview, and seamless payment integration.',
//     'icon': '🛒',
//     'technologies': ['Flutter', 'Firebase', 'Stripe', 'BLoC', 'AR Core'],
//   },
//   {
//     'title': 'Social Chat App',
//     'description': 'Real-time messaging platform with voice messages, video calls, story features, and end-to-end encryption for secure communication.',
//     'icon': '💬',
//     'technologies': ['Flutter', 'WebRTC', 'Socket.IO', 'Provider', 'FFmpeg'],
//   },
//   {
//     'title': 'AI Fitness Tracker',
//     'description': 'Smart fitness app with AI-powered form correction, personalized workout plans, nutrition tracking, and social challenges.',
//     'icon': '🏋️',
//     'technologies': ['Flutter', 'TensorFlow', 'HealthKit', 'Riverpod', 'Charts'],
//   },
// ];
