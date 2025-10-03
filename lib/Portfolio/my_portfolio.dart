import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:math' as math;
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:untitled/Portfolio/skills_and_projects.dart';
import 'package:dio/dio.dart';
import 'package:url_launcher/url_launcher.dart';


class PortfolioHome extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback onThemeToggle;
  const PortfolioHome({super.key, required this.isDarkMode, required this.onThemeToggle});
  @override
  PortfolioHomeState createState() => PortfolioHomeState();
}

class PortfolioHomeState extends State<PortfolioHome> with TickerProviderStateMixin {
  late ScrollController _scrollController;
  late AnimationController _heroController;
  late AnimationController _floatingController;
  late AnimationController _rainbowController;
  late AnimationController _scrollAnimationController;
  late Animation<double> _heroAnimation;
  late Animation<double> _floatingAnimation;
  late Animation<double> _scrollFadeAnimation;
  late Animation<Offset> _scrollSlideAnimation;

  bool _isScrolled = false;
  double _scrollProgress = 0.0;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();



  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _heroController = AnimationController(
      duration: Duration(milliseconds: 1200),
      vsync: this,
    );
    _floatingController = AnimationController(
      duration: Duration(seconds: 6),
      vsync: this,
    );
    _rainbowController = AnimationController(
      duration: Duration(seconds: 4),
      vsync: this,
    );
    _scrollAnimationController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );

    _heroAnimation = CurvedAnimation(
      parent: _heroController,
      curve: Curves.easeOutCubic,
    );

    _floatingAnimation = CurvedAnimation(
      parent: _floatingController,
      curve: Curves.easeInOut,
    );

    _scrollFadeAnimation = CurvedAnimation(
      parent: _scrollAnimationController,
      curve: Curves.easeOut,
    );

    _scrollSlideAnimation = Tween<Offset>(
      begin: Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _scrollAnimationController,
      curve: Curves.easeOutCubic,
    ));

    _scrollController.addListener(_onScroll);
    _heroController.forward();
    _floatingController.repeat();
    _rainbowController.repeat();
  }

  // void _onScroll() {
  //   bool isScrolled = _scrollController.offset > 100;
  //   double progress = (_scrollController.offset / MediaQuery.of(context).size.height).clamp(0.0, 1.0);
  //
  //   if (_isScrolled != isScrolled) {
  //     setState(() => _isScrolled = isScrolled);
  //   }
  //
  //   if (_scrollProgress != progress) {
  //     setState(() => _scrollProgress = progress);
  //
  //     if (_scrollController.offset > 50) {
  //       _scrollAnimationController.forward();
  //     } else {
  //       _scrollAnimationController.reverse();
  //     }
  //   }
  // }

  Timer? _scrollDebounce;

  void _onScroll() {
    if (_scrollDebounce?.isActive ?? false) _scrollDebounce!.cancel();

    _scrollDebounce = Timer(const Duration(milliseconds: 50), () {
      bool isScrolled = _scrollController.offset > 100;
      double progress = (_scrollController.offset / MediaQuery.of(context).size.height).clamp(0.0, 1.0);

      if (_isScrolled != isScrolled) {
        setState(() => _isScrolled = isScrolled);
      }

      if (_scrollController.offset > 50 && !_scrollAnimationController.isCompleted) {
        _scrollAnimationController.forward();
      } else if (_scrollController.offset <= 50 && !_scrollAnimationController.isDismissed) {
        _scrollAnimationController.reverse();
      }
    });
  }


  @override
  void dispose() {
    _scrollController.dispose();
    _heroController.dispose();
    _floatingController.dispose();
    _rainbowController.dispose();
    _scrollAnimationController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            physics: BouncingScrollPhysics(),
            slivers: [
              _buildHeroSection(),
              _buildAboutSection(),
              _buildSkillsSection(),
              _buildProjectsSection(),
              _buildContactSection(),
              _buildFooterSection(),
            ],
          ),
          buildNavBar(),

        ],
      ),
    );
  }

  Widget buildNavBar() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(
              gradient: _isScrolled
                  ? (widget.isDarkMode
                  ? LinearGradient(
                colors: [
                  Color(0xFF0a0a0a).withOpacity(0.95),
                  Color(0xFF1abc9c).withOpacity(0.1),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
                  : LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.95),
                  Color(0xFF1abc9c).withOpacity(0.05),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ))
                  : null,
              color: _isScrolled ? null : Colors.transparent,
              border: _isScrolled
                  ? Border.all(
                color: Color(0xFF1abc9c).withOpacity(0.3),
                width: 1,
              )
                  : null,
              boxShadow: _isScrolled
                  ? [
                BoxShadow(
                  color: Color(0xFF1abc9c).withOpacity(0.2),
                  blurRadius: 20,
                  offset: Offset(0, 2),
                ),
              ]
                  : null,
            ),
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [Color(0xFF1abc9c), Color(0xFF16a085)],
                    ).createShader(bounds),
                    child: Text(
                      'Faireena Zaidi',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(width: 15),
                      _buildThemeToggle(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildThemeToggle() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1abc9c), Color(0xFF16a085)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF1abc9c).withOpacity(0.4),
            blurRadius: 15,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.onThemeToggle,
          borderRadius: BorderRadius.circular(25),
          child: Container(
            width: 50,
            height: 50,
            child: Icon(
              widget.isDarkMode ? Icons.wb_sunny : Icons.dark_mode,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeroSection() {
    return SliverToBoxAdapter(
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: widget.isDarkMode
              ? LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0a0a0a),
              Color(0xFF1a1a1a),
              Color(0xFF1abc9c).withOpacity(0.1),
            ],
          )
              : LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white,
              Color(0xFFf8f9fa),
              Color(0xFF1abc9c).withOpacity(0.05),
            ],
          ),
        ),
        child: Stack(
          children: [
            // Floating Elements
            ..._buildFloatingElements(),

            // Hero Content
            Center(
              child: FadeTransition(
                opacity: _heroAnimation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: Offset(0, 0.3),
                    end: Offset.zero,
                  ).animate(_heroAnimation),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedBuilder(
                        animation: _rainbowController,
                        builder: (context, child) {
                          return ShaderMask(
                            shaderCallback: (bounds) {
                              return LinearGradient(
                                colors: [
                                  Color(0xFF1abc9c),
                                  Color(0xFF16a085),
                                  Color(0xFF2ecc71),
                                  Color(0xFF27ae60),
                                  Color(0xFF1abc9c),
                                ],
                                stops: [0.0, 0.25, 0.5, 0.75, 1.0],
                                transform: GradientRotation(_rainbowController.value * 2 * math.pi),
                              ).createShader(bounds);
                            },
                            child: Text('Flutter Developer',
                              style: TextStyle(fontSize: 64, fontWeight: FontWeight.w800, color: Colors.white, height: 1.1,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 30),
                      Text(
                        'Creating stunning mobile experiences with emerald elegance.',
                        style: TextStyle(
                          fontSize: 20,
                          color: widget.isDarkMode
                              ? Colors.white.withOpacity(0.9)
                              : Colors.black.withOpacity(0.8),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 50),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildAnimatedButton(
                            'View My Work',
                            Icons.rocket_launch,
                            [Color(0xFF1abc9c), Color(0xFF16a085)],
                                () => _scrollTo(5),
                          ),
                          SizedBox(height: 20),
                          _buildAnimatedButton(
                            'Download CV',
                            Icons.download,
                            [Colors.transparent, Colors.transparent],
                                () => _downloadCV(context),
                            isOutlined: true,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildFloatingElements() {
    final elements = <Widget>[];
    final gradients = [
      [Color(0xFF1abc9c), Color(0xFF16a085)],
      [Color(0xFF2ecc71), Color(0xFF27ae60)],
      [Color(0xFF1abc9c).withOpacity(0.5), Color(0xFF16a085).withOpacity(0.5)],
    ];

    final positions = [
      Offset(0.1, 0.2),
      Offset(0.85, 0.6),
      Offset(0.1, 0.8),
    ];

    for (int i = 0; i < 3; i++) {
      elements.add(
        AnimatedBuilder(
          animation: _floatingAnimation,
          builder: (context, child) {
            return Positioned(
              left: MediaQuery.of(context).size.width * positions[i].dx,
              top: MediaQuery.of(context).size.height * positions[i].dy +
                  math.sin(_floatingAnimation.value * 2 * math.pi + i) * 15,
              child: Transform.rotate(
                angle: _floatingAnimation.value * 2 * math.pi + i,
                child: Opacity(
                  opacity: 0.4,
                  child: Container(
                    width: 60 + i * 20,
                    height: 60 + i * 20,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: gradients[i]),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: gradients[i][0].withOpacity(0.6),
                          blurRadius: 25,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    }
    return elements;
  }

  Widget _buildAnimatedButton(String text, IconData icon, List<Color> colors, VoidCallback onPressed, {bool isOutlined = false}) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      decoration: BoxDecoration(
        gradient: isOutlined ? null : LinearGradient(colors: colors),
        borderRadius: BorderRadius.circular(30),
        border: isOutlined
            ? Border.all(
            color: widget.isDarkMode
                ? Color(0xFF1abc9c).withOpacity(0.8)
                : Color(0xFF1abc9c).withOpacity(0.6),
            width: 2
        )
            : Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF1abc9c).withOpacity(0.3),
            blurRadius: 15,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: isOutlined
            ? Color(0xFF1abc9c).withOpacity(0.1)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(30),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(30),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 35, vertical: 18),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                    icon,
                    color: isOutlined
                        ? Color(0xFF1abc9c)
                        : Colors.white,
                    size: 20
                ),
                SizedBox(width: 12),
                Text(
                  text,
                  style: TextStyle(
                    color: isOutlined
                        ? Color(0xFF1abc9c)
                        : Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAboutSection() {
    return SliverToBoxAdapter(
      child: FadeTransition(
        opacity: _scrollFadeAnimation,
        child: SlideTransition(
          position: _scrollSlideAnimation,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 120),
            decoration: BoxDecoration(
              gradient: widget.isDarkMode
                  ? LinearGradient(
                colors: [
                  Color(0xFF0a0a0a),
                  Color(0xFF1a1a1a),
                  Color(0xFF1abc9c).withOpacity(0.05),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )
                  : LinearGradient(
                colors: [
                  Colors.white,
                  Color(0xFFf8f9fa),
                  Color(0xFF1abc9c).withOpacity(0.02),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildSectionTitle('About Me'),
                SizedBox(height: 80),
                Container(
                  width: 212,
                  height: 212,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF1abc9c), Color(0xFF16a085)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF1abc9c).withOpacity(0.5),
                        blurRadius: 40,
                        offset: Offset(0, 20),
                      ),
                    ],
                  ),
                  child: Image.asset("assets/hijab-girl.png", fit: BoxFit.contain, height: 20,
                  ),
                ),
                SizedBox(height: 60),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "I'm a passionate Flutter developer with 1+ years of experience crafting beautiful, performant mobile applications. I specialize in creating smooth animations and intuitive user experiences.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: widget.isDarkMode ? Colors.white.withOpacity(0.8) : Colors.black.withOpacity(0.8),
                      ),
                    ),
                    SizedBox(height: 25),
                    Text(
                      "My expertise includes Flutter/Dart, Firebase integration, RESTful APIs, advanced state management, and creating pixel-perfect UIs with stunning animations that delight users across iOS and Android platforms.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: widget.isDarkMode ? Colors.white.withOpacity(0.8) : Colors.black.withOpacity(0.8),
                      ),
                    ),
                    SizedBox(height: 25),
                    Text(
                      "I'm constantly exploring new technologies, contributing to open-source projects, and sharing knowledge with the Flutter community through blog posts and tutorials.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: widget.isDarkMode ? Colors.white.withOpacity(0.8) : Colors.black.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSkillsSection() {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 120),
        decoration: BoxDecoration(
          gradient: widget.isDarkMode
              ? LinearGradient(
            colors: [
              Color(0xFF1a1a1a),
              Color(0xFF0a0a0a),
              Color(0xFF1abc9c).withOpacity(0.08),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
              : LinearGradient(
            colors: [
              Color(0xFFf8f9fa),
              Colors.white,
              Color(0xFF1abc9c).withOpacity(0.03),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: _buildSectionTitle('Skills & Expertise')),
            const SizedBox(height: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: skillsData.map((skill) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: _buildSkillCard(skill, skillsData.indexOf(skill)),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillCard(Map<String, dynamic> skill, int index) {
    final gradients = [
      [Color(0xFF1abc9c), Color(0xFF16a085)],
      [Color(0xFF2ecc71), Color(0xFF27ae60)],
      [Color(0xFF1abc9c).withOpacity(0.9), Color(0xFF16a085).withOpacity(0.9)],
      [Color(0xFF2ecc71).withOpacity(0.9), Color(0xFF27ae60).withOpacity(0.9)],
    ];

    return Center(
      child: Container(
        width: 300,
        padding: EdgeInsets.all(40),
        decoration: BoxDecoration(
          color: widget.isDarkMode ? Color(0xFF1a1a1a).withOpacity(0.8) : Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: Color(0xFF1abc9c).withOpacity(0.2), width: 1,),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF1abc9c).withOpacity(0.2),
              blurRadius: 30,
              offset: Offset(0, 15),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: gradients[index % gradients.length]),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: gradients[index % gradients.length][0].withOpacity(0.5),
                    blurRadius: 20,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child:
              Icon(skill['icon'], size: 32, color: Colors.white,),
            ),
            SizedBox(height: 25),
            Text(
              skill['title'],
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: widget.isDarkMode ? Colors.white : Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              skill['description'],
              style: TextStyle(
                fontSize: 16,
                color: widget.isDarkMode ? Colors.white.withOpacity(0.8) : Colors.black.withOpacity(0.7),
                height: 1.6,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectsSection() {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 120),
        decoration: BoxDecoration(
          gradient: widget.isDarkMode
              ? LinearGradient(
            colors: [
              Color(0xFF0a0a0a),
              Color(0xFF1a1a1a),
              Color(0xFF1abc9c).withOpacity(0.05),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )
              : LinearGradient(
            colors: [
              Colors.white,
              Color(0xFFf8f9fa),
              Color(0xFF1abc9c).withOpacity(0.02),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: _buildSectionTitle('Featured Projects')),
            SizedBox(height: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: projectsData.map((project) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: _buildProjectCard(project, projectsData.indexOf(project)),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectCard(Map<String, dynamic> project, int index) {
    final gradients = [
      [Color(0xFF1abc9c), Color(0xFF16a085)],
      [Color(0xFF2ecc71), Color(0xFF27ae60)],
      [Color(0xFF1abc9c).withOpacity(0.9), Color(0xFF16a085).withOpacity(0.9)],
    ];
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: widget.isDarkMode
            ? Color(0xFF1a1a1a).withOpacity(0.8)
            : Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: Color(0xFF1abc9c).withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF1abc9c).withOpacity(0.2),
            blurRadius: 30,
            offset: Offset(0, 15),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: gradients[index % gradients.length]),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25)
                ),
                child: Image.asset(project['image'],
                  fit: BoxFit.contain,
                )

            ),
          ),
          Padding(
            padding: EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(project['title'],
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: widget.isDarkMode ? Colors.white : Colors.black,),
                ),
                SizedBox(height: 20),
                Text(project['description'], style: TextStyle(fontSize: 16,
                  color: widget.isDarkMode ? Colors.white.withOpacity(0.8) : Colors.black.withOpacity(0.7),
                  height: 1.7,
                ),
                ),
                SizedBox(height: 25),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: (project['technologies'] as List<String>).map((tech) => Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: gradients[index % gradients.length]),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Text(tech,
                      style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600,),
                    ),
                  )).toList(),
                ),
                SizedBox(height: 20),
                InkWell(
                  onTap: (){

                  },
                  child: Row(
                    children: [
                      Text('View Project',
                        style: TextStyle(
                          color: gradients[index % gradients.length][0],
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward, color: gradients[index % gradients.length][0], size: 18,),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactSection() {
    return SliverToBoxAdapter(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 120),
        decoration: BoxDecoration(
          gradient: widget.isDarkMode
              ? LinearGradient(
            colors: [
              Color(0xFF1a1a1a),
              Color(0xFF0a0a0a),
              Color(0xFF1abc9c).withOpacity(0.08),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
              : LinearGradient(
            colors: [
              Color(0xFFf8f9fa),
              Colors.white,
              Color(0xFF1abc9c).withOpacity(0.03),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildSectionTitle('Open to Opportunities'),
            SizedBox(height: 20),
            Text(
              "I'm currently seeking job opportunities as a Flutter developer. Feel free to reach out if you'd like to connect!",
              style: TextStyle(
                fontSize: 20,
                height: 1.9,
                color: widget.isDarkMode ? Colors.white.withOpacity(0.8) : Colors.black.withOpacity(0.8),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 60),
            Center(
              child: Container(
                width: double.infinity,
                constraints: BoxConstraints(maxWidth: 600),
                padding: EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: widget.isDarkMode
                      ? Color(0xFF1a1a1a).withOpacity(0.8)
                      : Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: Color(0xFF1abc9c).withOpacity(0.3),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF1abc9c).withOpacity(0.2),
                      blurRadius: 30,
                      offset: Offset(0, 15),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: ShaderMask(
                          shaderCallback: (bounds) => LinearGradient(
                            colors: [Color(0xFF1abc9c), Color(0xFF16a085)],
                          ).createShader(bounds),
                          child: Text(
                            "Contact me",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(height: 40),
                      _buildContactField(
                        controller: _nameController,
                        label: 'Your Name',
                        hint: 'Enter your name',
                        validator: (value) =>
                        value?.isEmpty ?? true ? 'Please enter your name' : null,
                      ),
                      SizedBox(height: 25),
                      _buildContactField(
                        controller: _emailController,
                        label: 'Email Address',
                        hint: 'Enter your email',
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value?.isEmpty ?? true) return 'Please enter your email';
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                              .hasMatch(value!)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 25),
                      _buildContactField(
                        controller: _messageController,
                        label: 'Your Message',
                        hint: 'Tell me about the opportunity or how we can connect...',
                        maxLines: 5,
                        validator: (value) =>
                        value?.isEmpty ?? true ? 'Please enter your message' : null,
                      ),
                      SizedBox(height: 40),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFF1abc9c),
                              Color(0xFF16a085),
                              Color(0xFF2ecc71),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFF1abc9c).withOpacity(0.5),
                              blurRadius: 20,
                              offset: Offset(0, 8),
                            ),
                            BoxShadow(
                              color: Color(0xFF16a085).withOpacity(0.3),
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: (){
                              sendEmail(
                                _nameController.text.trim(),
                                _emailController.text.trim(),
                                _messageController.text.trim(),
                              );
                            },
                            borderRadius: BorderRadius.circular(15),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.send, color: Colors.white, size: 20),
                                  SizedBox(width: 12),
                                  Text(
                                    'Send Message',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactField({
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0, left: 4.0),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: widget.isDarkMode
                  ? Colors.white.withOpacity(0.7)
                  : Colors.black.withOpacity(0.7),
            ),
          ),
        ),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          validator: validator,
          style: TextStyle(
            color: widget.isDarkMode ? Colors.white : Colors.black,
            fontSize: 16,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: widget.isDarkMode
                  ? Colors.white.withOpacity(0.4)
                  : Colors.black.withOpacity(0.4),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: Color(0xFF1abc9c).withOpacity(0.3),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: Color(0xFF1abc9c).withOpacity(0.3),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: Color(0xFF1abc9c),
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: Colors.red.shade300,
                width: 2,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: Colors.red.shade300,
                width: 2,
              ),
            ),
            filled: true,
            fillColor: widget.isDarkMode
                ? Color(0xFF1a1a1a).withOpacity(0.6)
                : Color(0xFFf8f9fa).withOpacity(0.8),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            errorStyle: TextStyle(color: Colors.red.shade300),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Column(
      children: [
        ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [Color(0xFF1abc9c), Color(0xFF16a085)],
          ).createShader(bounds),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 15),
        Container(
          width: 80,
          height: 5,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Color(0xFF1abc9c), Color(0xFF16a085)]),
            borderRadius: BorderRadius.circular(3),
            boxShadow: [
              BoxShadow(
                color: Color(0xFF1abc9c).withOpacity(0.5),
                blurRadius: 10,
                offset: Offset(0, 2),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _scrollTo(int section) {
    double offset = 0;
    switch (section) {
      case 0: offset = 0; break;
      case 1: offset = MediaQuery.of(context).size.height; break;
      case 2: offset = MediaQuery.of(context).size.height * 2; break;
      case 3: offset = MediaQuery.of(context).size.height * 3; break;
      case 4: offset = MediaQuery.of(context).size.height * 4; break;
      case 5: offset = MediaQuery.of(context).size.height * 5; break;
      case 6: offset = MediaQuery.of(context).size.height * 6; break;
      case 7: offset = MediaQuery.of(context).size.height * 7; break;
    }

    _scrollController.animateTo(
      offset,
      duration: Duration(milliseconds: 1200),
      curve: Curves.easeInOutCubic,
    );
  }

  // void _downloadCV() {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Container(
  //         padding: EdgeInsets.symmetric(vertical: 8),
  //         child: Row(
  //           children: [
  //             Container(
  //               padding: EdgeInsets.all(8),
  //               decoration: BoxDecoration(
  //                 gradient: LinearGradient(colors: [Color(0xFF1abc9c), Color(0xFF16a085)]),
  //                 borderRadius: BorderRadius.circular(20),
  //               ),
  //               child: Icon(Icons.check_circle, color: Colors.white, size: 20),
  //             ),
  //             SizedBox(width: 16),
  //             Expanded(
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: [
  //                   Text(
  //                     'CV Downloaded Successfully!',
  //                     style: TextStyle(
  //                       fontWeight: FontWeight.w700,
  //                       fontSize: 16,
  //                       color: Colors.white,
  //                     ),
  //                   ),
  //                   Text(
  //                     'Check your downloads folder',
  //                     style: TextStyle(
  //                       fontSize: 14,
  //                       color: Colors.white.withOpacity(0.8),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //       backgroundColor: Color(0xFF1abc9c).withOpacity(0.9),
  //       elevation: 0,
  //       behavior: SnackBarBehavior.floating,
  //       duration: Duration(seconds: 4),
  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
  //       margin: EdgeInsets.all(20),
  //     ),
  //   );
  // }



  Future<void> _downloadCV(BuildContext context) async {
    try {
      if (Platform.isAndroid) {
        if (await Permission.manageExternalStorage.request().isDenied) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Storage permission denied")),
          );
          return;
        }
      } else if (Platform.isIOS) {
        if (await Permission.photos.request().isDenied) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Photos permission denied")),
          );
          return;
        }
      }

      Directory downloadsDir;
      if (Platform.isAndroid) {
        downloadsDir = Directory('/storage/emulated/0/Download');
      } else {
        downloadsDir = await getApplicationDocumentsDirectory();
      }

      final filePath = "${downloadsDir.path}/Faireena_cv.pdf";

      await Dio().download(
        //"https://raw.githubusercontent.com/faireenazaidi/myportfolio/main/Faireena_Resume-1.pdf",
       // "https://github.com/faireenazaidi/my_portfolio_/blob/main/Faireena_Resume-1.pdf",
        "https://raw.githubusercontent.com/faireenazaidi/my_portfolio_/main/Faireena_Resume-1.pdf",

        filePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            debugPrint(
                "Downloading: ${(received / total * 100).toStringAsFixed(0)}%");
          }
        },
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          //content: Text("CV downloaded to: ${downloadsDir.path}"),
          content: Text("CV downloaded successfully!"),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Download failed: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Future<void> _sendMessage() async {
  //   if (_formKey.currentState?.validate() ?? false) {
  //     final name = _nameController.text.trim();
  //     final email = _emailController.text.trim();
  //     final messageText = _messageController.text.trim();
  //
  //     String username = 'faireenazaidi7@gmail.com';
  //     String password = 'frcprakwyztkpshi';
  //
  //     final smtpServer = gmail(username, password);
  //
  //     final message = Message()
  //       ..from = Address(username, 'Faireena Portfolio')
  //       ..recipients.add('faireenazaidi7@gmail.com')
  //       ..subject = 'New Contact from Portfolio: $name'
  //       ..text = '''
  //      New Message from your Portfolio:
  //      Name: $name
  //      Email: $email
  //      Message: $messageText
  //     ''';
  //
  //     try {
  //       final sendReport = await send(message, smtpServer);
  //       print('Message sent: $sendReport');
  //
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Container(
  //             padding: EdgeInsets.symmetric(vertical: 8),
  //             child: Row(
  //               children: [
  //                 Container(
  //                   padding: EdgeInsets.all(8),
  //                   decoration: BoxDecoration(
  //                     gradient: LinearGradient(colors: [Color(0xFF1abc9c), Color(0xFF16a085)]),
  //                     borderRadius: BorderRadius.circular(20),
  //                   ),
  //                   child: Icon(Icons.check_circle, color: Colors.white, size: 20),
  //                 ),
  //                 SizedBox(width: 16),
  //                 Expanded(
  //                   child: Text(
  //                     "Message sent successfully!",
  //                     style: TextStyle(
  //                       fontWeight: FontWeight.w600,
  //                       color: Colors.white,
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //           backgroundColor: Color(0xFF1abc9c).withOpacity(0.9),
  //           behavior: SnackBarBehavior.floating,
  //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
  //           margin: EdgeInsets.all(20),
  //         ),
  //       );
  //
  //       _nameController.clear();
  //       _emailController.clear();
  //       _messageController.clear();
  //
  //     } on MailerException catch (e) {
  //       print('Message not sent.');
  //       for (var p in e.problems) {
  //         print('Problem: ${p.code}: ${p.msg}');
  //       }
  //
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text("Failed to send message."),
  //           backgroundColor: Colors.red.shade400,
  //           behavior: SnackBarBehavior.floating,
  //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
  //           margin: EdgeInsets.all(20),
  //         ),
  //       );
  //     }
  //   }
  // }
  Future<void> sendEmail(String name, String email, String message) async {
    const serviceId = 'service_4qriy3e';
    const templateId = 'template_i2gwxjr';
    const userId = 'kTxK3Gf8mAWpPbxHC';

    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final response = await http.post(
      url,
      headers: {
        'origin': 'http://localhost',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'template_params': {
          'from_name': name,
          'from_email': email,
          'message': message,
        }
      }),
    );

    if (response.statusCode == 200) {
      print('Message sent!');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Container(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [Color(0xFF1abc9c), Color(0xFF16a085)]),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(Icons.check_circle, color: Colors.white, size: 20),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Text(
                    "Message sent successfully!",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          backgroundColor: Color(0xFF1abc9c).withOpacity(0.9),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          margin: EdgeInsets.all(20),
        ),
      );

      _nameController.clear();
      _emailController.clear();
      _messageController.clear();
    }
    else {
      print('Failed to send message: ${response.body}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to send message."),
          backgroundColor: Colors.red.shade400,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          margin: EdgeInsets.all(20),
        ),
      );

    }
  }

  ///---Footer---///

  Widget _buildFooterSection() {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 60),
        decoration: BoxDecoration(
          gradient: widget.isDarkMode
              ? LinearGradient(
            colors: [
              Color(0xFF0a0a0a),
              Color(0xFF1a1a1a),
              Color(0xFF1abc9c).withOpacity(0.1),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )
              : LinearGradient(
            colors: [
              Color(0xFFf8f9fa),
              Colors.white,
              Color(0xFF1abc9c).withOpacity(0.03),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          border: Border(
            top: BorderSide(
              color: Color(0xFF1abc9c).withOpacity(0.2),
              width: 1,
            ),
          ),
        ),
        child: Column(
          children: [
            // Social Links
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSocialButton(
                  icon: Icons.email,
                  label: 'Email',
                  onTap: () => _launchEmail(),
                ),
                SizedBox(width: 20),
                _buildSocialButton(
                  icon: Icons.code,
                  label: 'GitHub',
                  onTap: () => _launchGitHub(),
                ),
                SizedBox(width: 20),
                _buildSocialButton(
                  icon: Icons.work,
                  label: 'LinkedIn',
                  onTap: () => _launchLinkedIn(),
                ),
                SizedBox(width: 20),
                _buildSocialButton(
                  icon: Icons.phone,
                  label: 'WhatsApp',
                  onTap: () => _launchWhatsApp(),
                ),
              ],
            ),
            SizedBox(height: 40),

            // Footer Text
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Color(0xFF1abc9c).withOpacity(0.1),
                    width: 1,
                  ),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    'Built with Flutter & Love',
                    style: TextStyle(
                      fontSize: 16,
                      color: widget.isDarkMode
                          ? Colors.white.withOpacity(0.7)
                          : Colors.black.withOpacity(0.7),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '© 2025 Faireena Zaidi. All rights reserved.',
                        style: TextStyle(
                          fontSize: 14,
                          color: widget.isDarkMode
                              ? Colors.white.withOpacity(0.5)
                              : Colors.black.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [Color(0xFF1abc9c), Color(0xFF16a085)],
                    ).createShader(bounds),
                    child: Text(
                      'Made with Flutter 💚',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1abc9c), Color(0xFF16a085)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: Colors.white.withOpacity(0.2),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF1abc9c).withOpacity(0.3),
              blurRadius: 15,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(50),
            child: Container(
              width: 60,
              height: 60,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    color: Colors.white,
                    size: 24,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _launchEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'faireenazaidi7@gmail.com',
      query: 'subject=Hello from Portfolio',
    );

    try {
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
      } else {
        _showEmailFallback();
      }
    } catch (e) {
      _showEmailFallback();
    }
  }

  void _showEmailFallback() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Color(0xFF1abc9c), Color(0xFF16a085)]),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(Icons.email, color: Colors.white, size: 20),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Email Contact',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'faireenazaidi7@gmail.com',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Color(0xFF1abc9c).withOpacity(0.9),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        margin: EdgeInsets.all(20),
      ),
    );
  }

  void _launchLinkedIn() async {
    const linkedInUrl = "https://www.linkedin.com/in/syed-faireena-zaidi-2b0861325";
    final uri = Uri.parse(linkedInUrl);

    try {
      // Try to launch without checking canLaunchUrl first
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      try {
        await launchUrl(uri, mode: LaunchMode.inAppWebView);
      } catch (e2) {

        try {
          await launchUrl(uri, mode: LaunchMode.platformDefault);
        } catch (e3) {
          _showUrlError("LinkedIn");
        }
      }
    }
  }

  void _launchGitHub() async {
    const gitHubUrl = "https://github.com/faireenazaidi";
    final uri = Uri.parse(gitHubUrl);

    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      try {
        await launchUrl(uri, mode: LaunchMode.inAppWebView);
      } catch (e2) {
        try {
          await launchUrl(uri, mode: LaunchMode.platformDefault);
        } catch (e3) {
          _showUrlError("GitHub");
        }
      }
    }
  }

  void _launchWhatsApp() async {
    const phoneNumber = "8173822136";
    const whatsappUrl = "https://wa.me/$phoneNumber?text=Hello%20from%20your%20portfolio!";
    final uri = Uri.parse(whatsappUrl);

    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      try {
        await launchUrl(uri, mode: LaunchMode.inAppWebView);
      } catch (e2) {
        try {
          await launchUrl(uri, mode: LaunchMode.platformDefault);
        } catch (e3) {
          _showUrlError("WhatsApp");
        }
      }
    }
  }

  void _showUrlError(String platform) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Could not open $platform"),
        backgroundColor: Colors.red.shade400,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        margin: EdgeInsets.all(20),
      ),
    );
  }
}