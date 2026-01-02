import 'package:flutter/material.dart';
import 'package:untitled/SFZ/widgets/about_sec.dart';
import 'dart:async';
import 'package:untitled/SFZ/widgets/animated_bg.dart';
import 'package:untitled/SFZ/widgets/contact.dart';
import 'package:untitled/SFZ/widgets/footer.dart';
import 'package:untitled/SFZ/widgets/hero_section.dart';
import 'package:untitled/SFZ/widgets/navigation.dart';
import 'package:untitled/SFZ/widgets/project_sec.dart';
import 'package:untitled/SFZ/widgets/skills.dart';

class PortfolioHome extends StatefulWidget {
  const PortfolioHome({super.key});

  @override
  State<PortfolioHome> createState() => PortfolioHomeState();
}

class PortfolioHomeState extends State<PortfolioHome> with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey contactSectionKey = GlobalKey();
  final GlobalKey aboutSectionKey = GlobalKey();
  final GlobalKey homeSectionKey = GlobalKey();
  final GlobalKey skillsSectionKey = GlobalKey();
  final GlobalKey projectSectionKey = GlobalKey();

  bool _isScrolled = false;
  String typedText = '';
  final String _fullText = 'Flutter Developer';
  int _currentIndex = 0;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _startTypingAnimation();
  }

  void _onScroll() {
    if (_scrollController.offset > 50 && !_isScrolled) {
      setState(() => _isScrolled = true);
    } else if (_scrollController.offset <= 50 && _isScrolled) {
      setState(() => _isScrolled = false);
    }
  }
  void scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }
  void _startTypingAnimation() {
    const typingSpeed = Duration(milliseconds: 120);
    const pauseDuration = Duration(seconds: 2);

    Timer.periodic(typingSpeed, (timer) {
      if (_currentIndex < _fullText.length) {
        setState(() {
          typedText = _fullText.substring(0, _currentIndex + 1);
          _currentIndex++;
        });
      } else {
        timer.cancel();

        Future.delayed(pauseDuration, () {
          setState(() {
            _currentIndex = 0;
            typedText = "";
          });
          _startTypingAnimation();
        });
      }
    });
  }



  @override
  void dispose() {
    _scrollController.dispose();
    nameController.dispose();
    emailController.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: buildMobileDrawer(
        context,
        scrollToSection,
        aboutSectionKey,
        contactSectionKey,
        skillsSectionKey,
        homeSectionKey,
        projectSectionKey,

      ),

      body: Stack(
        children: [
          buildAnimatedBackground(context),
          SingleChildScrollView(
            controller: _scrollController,
            child:
            // Column(
            //   children: [
            //     const SizedBox(height: 80),
            //    buildHeroSection(context,typedText,contactSectionKey, ),
            //     Container(
            //       key: aboutSectionKey,
            //       child: buildAboutSection(context),
            //     ),
            //     Container(
            //         key: skillsSectionKey,
            //         child: buildSkillsSection(context)
            //     ),
            //     buildProjectsSection(context),
            //     Container(
            //       key: contactSectionKey,
            //       child: buildContactSection(
            //          context,
            //         nameController: nameController,
            //         emailController: emailController,
            //         messageController: messageController,
            //       ),
            //     ),
            //     buildFooter(),
            //   ],
            // ),
            Column(
              children: [
                const SizedBox(height: 80),

                // HOME / HERO SECTION
                Container(
                  key: homeSectionKey,
                  child: buildHeroSection(context, typedText, contactSectionKey),
                ),

                // ABOUT SECTION
                Container(
                  key: aboutSectionKey,
                  child: buildAboutSection(context),
                ),

                // SKILLS SECTION
                Container(
                  key: skillsSectionKey,
                  child: buildSkillsSection(context, ),
                ),

                // PROJECTS SECTION
                Container(
                  key: projectSectionKey,
                  child: buildProjectsSection(context),
                ),

                // CONTACT SECTION
                Container(
                  key: contactSectionKey,
                  child: buildContactSection(
                    context,
                    nameController: nameController,
                    emailController: emailController,
                    messageController: messageController,
                  ),
                ),

                buildFooter(),
              ],
            )


          ),
          buildNavigationBar(
            context,
            _isScrolled,
            scrollToSection,
            homeSectionKey,
            aboutSectionKey,
            skillsSectionKey,
            projectSectionKey,
            contactSectionKey,
          ),


       //   buildNavigationBar(context, _isScrolled),
        ],
      ),
    );
  }
}
