import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';



class PortfolioHomePage extends StatefulWidget {
  const PortfolioHomePage({super.key});

  @override
  State<PortfolioHomePage> createState() => _PortfolioHomePageState();
}

class _PortfolioHomePageState extends State<PortfolioHomePage> with TickerProviderStateMixin {
  int activeSection = 0;
  bool isLoading = false;

  late AnimationController _profileAnimationController;
  late AnimationController _counterAnimationController;
  late AnimationController _floatingController;

  late Animation<double> _profileAnimation;
  late Animation<double> _floatingAnimation;

  int experienceYears = 0;
  int projectsCount = 0;
  int appsCount = 0;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _profileAnimationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _counterAnimationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _floatingController = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    );

    _profileAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _profileAnimationController,
      curve: Curves.easeInOut,
    ));

    _floatingAnimation = Tween<double>(
      begin: -20.0,
      end: 20.0,
    ).animate(CurvedAnimation(
      parent: _floatingController,
      curve: Curves.easeInOut,
    ));

    _profileAnimationController.repeat(reverse: true);
    _floatingController.repeat(reverse: true);

    _animateCounters();
  }

  void _animateCounters() {
    _counterAnimationController.addListener(() {
      setState(() {
        experienceYears = (3 * _counterAnimationController.value).round();
        projectsCount = (25 * _counterAnimationController.value).round();
        appsCount = (12 * _counterAnimationController.value).round();
      });
    });
    _counterAnimationController.forward();
  }

  @override
  void dispose() {
    _profileAnimationController.dispose();
    _counterAnimationController.dispose();
    _floatingController.dispose();
    nameController.dispose();
    emailController.dispose();
    subjectController.dispose();
    messageController.dispose();
    super.dispose();
  }

  // Future<void> _handleFormSubmit() async {
  //   if (_formKey.currentState!.validate()) {
  //     setState(() {
  //       isLoading = true;
  //     });
  //
  //     await Future.delayed(const Duration(seconds: 2));
  //
  //     setState(() {
  //       isLoading = false;
  //     });
  //
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text('Message sent successfully!'),
  //         backgroundColor: Colors.green,
  //       ),
  //     );
  //
  //     nameController.clear();
  //     emailController.clear();
  //     subjectController.clear();
  //     messageController.clear();
  //   }
  // }


  Future<void> _handleFormSubmit() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      try {
        final smtpServer = gmail('faireenazaidi7@gmail.com', 'your-app-password');

        final message = Message()
          ..from = Address('faireenazaidi7@gmail.com', 'Portfolio Contact Form')
          ..recipients.add('faireenazaidi7@gmail.com')
          ..subject = subjectController.text.isNotEmpty
              ? subjectController.text
              : 'New message from portfolio form'
          ..text =
              'Name: ${nameController.text}\nEmail: ${emailController.text}\nMessage: ${messageController.text}';

        await send(message, smtpServer);

        setState(() {
          isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Message sent successfully!'),
            backgroundColor: Colors.green,
          ),
        );

        // Clear the form
        nameController.clear();
        emailController.clear();
        subjectController.clear();
        messageController.clear();
      } on MailerException catch (e) {
        setState(() {
          isLoading = false;
        });
        print(e);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to send message. Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF667eea),
              Color(0xFF764ba2),
              Color(0xFF667eea),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(),
              _buildNavigation(),
              _buildContent(),
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      child: Stack(
        children: [
          // Floating elements
          ..._buildFloatingElements(),

          // Main content
          Center(
            child: Column(
              children: [
                // Profile image
                AnimatedBuilder(
                  animation: _profileAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _profileAnimation.value,
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
                            colors: [Color(0xFFff6b6b), Color(0xFF4ecdc4)],
                          ),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                            width: 5,
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            '🚀',
                            style: TextStyle(fontSize: 60),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),

                // Name and title
                TweenAnimationBuilder<double>(
                  duration: const Duration(seconds: 1),
                  tween: Tween(begin: 0.0, end: 1.0),
                  builder: (context, value, child) {
                    return Transform.translate(
                      offset: Offset(0, 30 * (1 - value)),
                      child: Opacity(
                        opacity: value,
                        child: Column(
                          children: [
                            Center(
                              child: Text(
                                'Faireena Flutter Dev',
                                style: TextStyle(
                                  fontSize: MediaQuery
                                      .of(context)
                                      .size
                                      .width > 768 ? 60 : 40,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Center(
                              child: Text(
                                'Crafting Beautiful Mobile Experiences with Flutter & Dart',
                                style: TextStyle(
                                  fontSize: MediaQuery
                                      .of(context)
                                      .size
                                      .width > 768 ? 24 : 18,
                                  color: Colors.white.withOpacity(0.9),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildFloatingElements() {
    return [
      AnimatedBuilder(
        animation: _floatingAnimation,
        builder: (context, child) {
          return Positioned(
            top: 40 + _floatingAnimation.value,
            left: 40,
            child: const Text(
                '🎯', style: TextStyle(fontSize: 60, color: Colors.white10)),
          );
        },
      ),
      AnimatedBuilder(
        animation: _floatingAnimation,
        builder: (context, child) {
          return Positioned(
            top: 80 - _floatingAnimation.value,
            right: 60,
            child: const Text(
                '📱', style: TextStyle(fontSize: 60, color: Colors.white10)),
          );
        },
      ),
      AnimatedBuilder(
        animation: _floatingAnimation,
        builder: (context, child) {
          return Positioned(
            bottom: 80 + _floatingAnimation.value,
            left: 80,
            child: const Text(
                '⚡', style: TextStyle(fontSize: 60, color: Colors.white10)),
          );
        },
      ),
    ];
  }

  Widget _buildNavigation() {
    final sections = ['About', 'Skills', 'Projects', 'Contact'];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 16,
        runSpacing: 16,
        children: sections
            .asMap()
            .entries
            .map((entry) {
          final index = entry.key;
          final section = entry.value;
          final isActive = activeSection == index;

          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  activeSection = index;
                });
                if (index == 0) _animateCounters();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: isActive
                    ? Colors.white.withOpacity(0.2)
                    : Colors.white.withOpacity(0.1),
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                    horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: Text(
                section,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildContent() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 40,
            spreadRadius: 0,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child: _getCurrentSection(),
      ),
    );
  }

  Widget _getCurrentSection() {
    switch (activeSection) {
      case 0:
        return _buildAboutSection();
      case 1:
        return _buildSkillsSection();
      case 2:
        return _buildProjectsSection();
      case 3:
        return _buildContactSection();
      default:
        return _buildAboutSection();
    }
  }

  Widget _buildAboutSection() {
    return Column(
      key: const ValueKey('about'),
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 768;

            if (isWide) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 1, child: _buildStatsGrid()),
                  const SizedBox(width: 40),
                  Expanded(flex: 2, child: _buildAboutText()),
                ],
              );
            } else {
              return Column(
                children: [
                  _buildStatsGrid(),
                  const SizedBox(height: 40),
                  _buildAboutText(),
                ],
              );
            }
          },
        ),
      ],
    );
  }

  Widget _buildStatsGrid() {
    final stats = [
      {
        'number': '$experienceYears+',
        'label': 'Years Experience',
        'colors': [Color(0xFF667eea), Color(0xFF764ba2)]
      },
      {
        'number': '$projectsCount+',
        'label': 'Projects Completed',
        'colors': [Color(0xFF764ba2), Color(0xFFf093fb)]
      },
      {
        'number': '$appsCount+',
        'label': 'Apps Published',
        'colors': [Color(0xFFf093fb), Color(0xFFf5576c)]
      },
      {
        'number': '4.9',
        'label': 'Client Rating',
        'colors': [Color(0xFF4ecdc4), Color(0xFF44a08d)]
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: stats.length,
      itemBuilder: (context, index) {
        final stat = stats[index];
        return AnimatedContainer(
          duration: Duration(milliseconds: 500 + index * 100),
          curve: Curves.easeOutBack,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: stat['colors'] as List<Color>,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        stat['number'] as String,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        stat['label'] as String,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.9),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAboutText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'About Me',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333),
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          "I'm a passionate Flutter developer with over 3 years of experience in creating stunning cross-platform mobile applications. My journey began with native Android development, but I fell in love with Flutter's ability to create beautiful, performant apps for both iOS and Android from a single codebase.",
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF666666),
            height: 1.6,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          "I specialize in building user-centric applications with clean architecture, smooth animations, and pixel-perfect UI implementations. My expertise spans from complex state management solutions to integrating third-party APIs and creating custom widgets.",
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF666666),
            height: 1.6,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          "When I'm not coding, you can find me contributing to open-source Flutter projects, writing technical blogs, or exploring the latest developments in mobile technology.",
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF666666),
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildSkillsSection() {
    final skills = [
      {
        'icon': '🎯',
        'title': 'Flutter & Dart',
        'description': 'Expert in Flutter framework, Dart language, custom widgets, and advanced animations'
      },
      {
        'icon': '🏗️',
        'title': 'State Management',
        'description': 'Proficient in BLoC, Provider, Riverpod, GetX, and MobX for scalable app architecture'
      },
      {
        'icon': '🔥',
        'title': 'Firebase',
        'description': 'Integration with Firestore, Authentication, Cloud Functions, and Push Notifications'
      },
      {
        'icon': '📡',
        'title': 'API Integration',
        'description': 'REST APIs, GraphQL, WebSocket connections, and efficient data caching strategies'
      },
      {
        'icon': '🧪',
        'title': 'Testing',
        'description': 'Unit testing, widget testing, integration testing, and test-driven development'
      },
      {
        'icon': '🚀',
        'title': 'DevOps',
        'description': 'CI/CD pipelines, automated deployments, and app store publishing workflows'
      },
    ];

    return Column(
      key: const ValueKey('skills'),
      children: [
        const Text(
          'Technical Skills',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333),
          ),
        ),
        const SizedBox(height: 48),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery
                .of(context)
                .size
                .width > 1200 ? 3 :
            MediaQuery
                .of(context)
                .size
                .width > 768 ? 2 : 1,
            childAspectRatio: 1.1,
            crossAxisSpacing: 24,
            mainAxisSpacing: 24,
          ),
          itemCount: skills.length,
          itemBuilder: (context, index) {
            final skill = skills[index];
            return TweenAnimationBuilder<double>(
              duration: Duration(milliseconds: 500 + index * 100),
              tween: Tween(begin: 0.0, end: 1.0),
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(0, 50 * (1 - value)),
                  child: Opacity(
                    opacity: value,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF667eea).withOpacity(0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.all(32),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  skill['icon'] as String,
                                  style: const TextStyle(fontSize: 48),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  skill['title'] as String,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  skill['description'] as String,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white.withOpacity(0.9),
                                    height: 1.4,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildProjectsSection() {
    final projects = [
      {
        'icon': '🛍️',
        'title': 'E-Commerce Flutter App',
        'description': 'A full-featured e-commerce application with shopping cart, payment integration, order tracking, and admin panel.',
        'tags': ['Flutter', 'Firebase', 'Stripe', 'BLoC'],
        'gradient': [Color(0xFF667eea), Color(0xFF764ba2)],
      },
      {
        'icon': '💬',
        'title': 'Real-time Chat App',
        'description': 'Secure messaging app with end-to-end encryption, group chats, file sharing, and voice messages.',
        'tags': ['Flutter', 'WebSocket', 'Encryption', 'Provider'],
        'gradient': [Color(0xFFf093fb), Color(0xFFf5576c)],
      },
      {
        'icon': '📊',
        'title': 'Analytics Dashboard',
        'description': 'Beautiful data visualization app with interactive charts, real-time updates, and custom widgets.',
        'tags': ['Flutter', 'Charts', 'REST API', 'Riverpod'],
        'gradient': [Color(0xFF4ecdc4), Color(0xFF44a08d)],
      },
      {
        'icon': '🎵',
        'title': 'Music Streaming App',
        'description': 'Spotify-like music streaming app with playlists, offline mode, and beautiful audio visualizations.',
        'tags': ['Flutter', 'Audio', 'SQLite', 'GetX'],
        'gradient': [Color(0xFFa8edea), Color(0xFFfed6e3)],
      },
    ];

    return Column(
      key: const ValueKey('projects'),
      children: [
        const Text(
          'Featured Projects',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333),
          ),
        ),
        const SizedBox(height: 48),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery
                .of(context)
                .size
                .width > 768 ? 2 : 1,
            childAspectRatio: 0.85,
            crossAxisSpacing: 24,
            mainAxisSpacing: 24,
          ),
          itemCount: projects.length,
          itemBuilder: (context, index) {
            final project = projects[index];
            return TweenAnimationBuilder<double>(
              duration: Duration(milliseconds: 500 + index * 100),
              tween: Tween(begin: 0.0, end: 1.0),
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(0, 50 * (1 - value)),
                  child: Opacity(
                    opacity: value,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {},
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Project image/icon
                              Container(
                                height: 180,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: project['gradient'] as List<Color>,
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    project['icon'] as String,
                                    style: const TextStyle(fontSize: 64),
                                  ),
                                ),
                              ),

                              // Project content
                              Padding(
                                padding: const EdgeInsets.all(24),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      project['title'] as String,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF333333),
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      project['description'] as String,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF666666),
                                        height: 1.5,
                                      ),
                                    ),
                                    const SizedBox(height: 16),

                                    // Tech tags
                                    Wrap(
                                      spacing: 8,
                                      runSpacing: 8,
                                      children: (project['tags'] as List<
                                          String>).map((tag) {
                                        return Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 6,
                                          ),
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: project['gradient'] as List<
                                                  Color>,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                                15),
                                          ),
                                          child: Text(
                                            tag,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                    const SizedBox(height: 20),

                                    // Action buttons
                                    Row(
                                      children: [
                                        Expanded(
                                          child: OutlinedButton(
                                            onPressed: () {},
                                            style: OutlinedButton.styleFrom(
                                              foregroundColor: (project['gradient'] as List<
                                                  Color>)[0],
                                              side: BorderSide(
                                                color: (project['gradient'] as List<
                                                    Color>)[0],
                                                width: 2,
                                              ),
                                              padding: const EdgeInsets
                                                  .symmetric(vertical: 12),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius
                                                    .circular(8),
                                              ),
                                            ),
                                            child: const Text(
                                              'Live Demo',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: OutlinedButton(
                                            onPressed: () {},
                                            style: OutlinedButton.styleFrom(
                                              foregroundColor: (project['gradient'] as List<
                                                  Color>)[1],
                                              side: BorderSide(
                                                color: (project['gradient'] as List<
                                                    Color>)[1],
                                                width: 2,
                                              ),
                                              padding: const EdgeInsets
                                                  .symmetric(vertical: 12),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius
                                                    .circular(8),
                                              ),
                                            ),
                                            child: const Text(
                                              'Source Code',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildContactSection() {
    return Column(
      key: const ValueKey('contact'),
      children: [
        const Text(
          "Open to Opportunities",
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333),
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          "I’m currently seeking job opportunities as a Flutter developer. "
              "Feel free to reach out if you'd like to connect!",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF666666),
          ),
        ),
        const SizedBox(height: 48),
        Container(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildTextField(
                  controller: nameController,
                  label: 'Your Name',
                  hint: 'Enter your full name',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                _buildTextField(
                  controller: emailController,
                  label: 'Email Address',
                  hint: 'Enter your email',
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                _buildTextField(
                  controller: messageController,
                  label: 'Your Message',
                  hint: 'Tell me about the opportunity or how we can connect...',
                  maxLines: 6,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your message';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),

                // Submit button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : _handleFormSubmit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF667eea),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: isLoading
                        ? const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.white),
                            strokeWidth: 2,
                          ),
                        ),
                        SizedBox(width: 12),
                        Text(
                          'Sending Message...',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    )
                        : const Text(
                      'Send Message',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    int maxLines = 1,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF333333),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey[400]),
            filled: true,
            fillColor: Colors.grey[50],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!, width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!, width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF667eea), width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
            contentPadding: const EdgeInsets.all(16),
          ),
        ),
      ],
    );
  }

  Widget _buildFooter() {
    final socialLinks = [
      {'icon': '📧', 'label': 'Email'},
      {'icon': '💼', 'label': 'LinkedIn'},
      {'icon': '🐙', 'label': 'GitHub'},
      {'icon': '🐦', 'label': 'Twitter'},
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 20),
      child: Column(
        children: [
          // Social links
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: socialLinks.map((social) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                child: Material(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(25),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(25),
                    onTap: () {
                      HapticFeedback.lightImpact();
                      // Handle social link tap
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          social['icon'] as String,
                          style: const TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),

          // Copyright
          Text(
            '© 2024 Alex Flutter Dev. Crafted with Flutter & ❤️',
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
class HoverEffect extends StatefulWidget {
  final Widget child;
  final double scale;
  final Duration duration;

  const HoverEffect({
    super.key,
    required this.child,
    this.scale = 1.05,
    this.duration = const Duration(milliseconds: 200),
  });

  @override
  State<HoverEffect> createState() => _HoverEffectState();
}

class _HoverEffectState extends State<HoverEffect> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _isHovered ? widget.scale : 1.0,
        duration: widget.duration,
        child: widget.child,
      ),
    );
  }
}

class GradientText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Gradient gradient;

  const GradientText({
    super.key,
    required this.text,
    required this.style,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}

class AnimatedCounter extends StatefulWidget {
  final int value;
  final Duration duration;
  final TextStyle? style;
  final String suffix;

  const AnimatedCounter({
    super.key,
    required this.value,
    this.duration = const Duration(seconds: 2),
    this.style,
    this.suffix = '',
  });

  @override
  State<AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);
    _animation = Tween<double>(begin: 0, end: widget.value.toDouble())
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Text(
          '${_animation.value.round()}${widget.suffix}',
          style: widget.style,
        );
      },
    );
  }
}

class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, bool isMobile, bool isTablet, bool isDesktop) builder;

  const ResponsiveBuilder({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;
    final isTablet = width >= 600 && width < 1024;
    final isDesktop = width >= 1024;

    return builder(context, isMobile, isTablet, isDesktop);
  }
}

// Custom page route for smooth transitions
class FadePageRoute<T> extends PageRoute<T> {
  final WidgetBuilder builder;

  FadePageRoute({required this.builder});

  @override
  Color get barrierColor => Colors.transparent;

  @override
  String get barrierLabel => '';

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return FadeTransition(
      opacity: animation,
      child: builder(context),
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(opacity: animation, child: child);
  }

  @override
  bool get barrierDismissible => false;
}



