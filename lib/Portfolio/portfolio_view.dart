import 'dart:math';
import 'package:flutter/material.dart';


class PortfolioHome extends StatefulWidget {
  const PortfolioHome({super.key});

  @override
  State<PortfolioHome> createState() => _PortfolioHomeState();
}

class _PortfolioHomeState extends State<PortfolioHome>
    with TickerProviderStateMixin {
  late AnimationController _rocketController;
  late AnimationController _rotateController;
  late AnimationController _arrowController;

  @override
  void initState() {
    super.initState();

    // Rocket scale animation
    _rocketController =
    AnimationController(vsync: this, duration: const Duration(seconds: 2))
      ..repeat(reverse: true);

    // Thunder rotation
    _rotateController =
    AnimationController(vsync: this, duration: const Duration(seconds: 6))
      ..repeat();

    // Arrow up-down animation
    _arrowController =
    AnimationController(vsync: this, duration: const Duration(seconds: 1))
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _rocketController.dispose();
    _rotateController.dispose();
    _arrowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.pink],
              begin: Alignment.centerLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 25,),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Align(
                  //     alignment: Alignment.bottomLeft,
                  //     child: AnimatedBuilder(
                  //       animation: _arrowController,
                  //       builder: (context, child) {
                  //         return Transform.translate(
                  //           offset: Offset(0, -10 + (_arrowController.value * 20)),
                  //           child: Opacity(
                  //               opacity: 0.2,
                  //               child: const Text("🎯", style: TextStyle(fontSize: 32,))),
                  //         );
                  //       },
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: AnimatedBuilder(
                        animation: _arrowController,
                        builder: (context, child) {
                          double t = _arrowController.value;
                          double bounce = 40 * (4 * t * (1 - t)) - 5;
                          return Transform.translate(
                            offset: Offset(0, -bounce),
                            child: Opacity(
                              opacity: 0.1,
                              child: const Text(
                                "🎯",
                                style: TextStyle(fontSize: 32),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),



                  ScaleTransition(
                    scale: Tween(begin: 0.9, end: 1.1).animate(CurvedAnimation(
                      parent: _rocketController,
                      curve: Curves.easeInOut,
                    )),
                    child: Container(
                      height: 150,
                      width: 150,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [Colors.pinkAccent, Colors.grey,Colors.lightBlueAccent],
                        ),
                      ),
                      child: const Center(
                        child: Text("🚀", style: TextStyle(fontSize: 50)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Name
                  const Text(
                    " Flutter ",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  AnimatedBuilder(
                    animation: _rotateController,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: _rotateController.value * 2 * pi,
                        child: Opacity(
                          opacity: 0.2,
                          child: const Text(
                            "⚡",
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Crafting Beautiful Mobile Experiences\nwith Flutter & Dart",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70),
                  ),

                  const SizedBox(height: 30),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}
