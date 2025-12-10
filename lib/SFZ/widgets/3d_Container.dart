// import 'dart:math' as math;
//
// import 'package:flutter/material.dart';
//
//
// Widget build3DCard({
//   required IconData icon,
//   required String title,
//   required String content,
// }) {
//   return Container3D(
//     child: Container(
//       padding: const EdgeInsets.all(24),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//           colors: [
//             const Color(0xFF1e002a).withOpacity(0.6),
//             Colors.black.withOpacity(0.6),
//           ],
//         ),
//         border: Border.all(
//           color: const Color(0xFF8b5cf6).withOpacity(0.3),
//         ),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                     color: const Color(0xFF8b5cf6).withOpacity(0.5),
//                   ),
//                   borderRadius: BorderRadius.circular(8),
//                   color: Colors.black.withOpacity(0.3),
//                 ),
//                 child: Icon(
//                   icon,
//                   color: const Color(0xFF8b5cf6),
//                   size: 28,
//                 ),
//               ),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: Text(
//                   title,
//                   style: const TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 16),
//           Text(
//             content,
//             style: TextStyle(
//               color: Colors.grey[400],
//               fontSize: 14,
//               height: 1.5,
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }
//
// class Container3D extends StatefulWidget {
//   final Widget child;
//   final double depth;
//   final bool enableHoverEffect;
//
//   const Container3D({
//     Key? key,
//     required this.child,
//     this.depth = 10,
//     this.enableHoverEffect = true,
//   }) : super(key: key);
//
//   @override
//   State<Container3D> createState() => _Container3DState();
// }
//
// class _Container3DState extends State<Container3D>
//     with SingleTickerProviderStateMixin {
//   double _rotateX = 0.0;
//   double _rotateY = 0.0;
//   late AnimationController _controller;
//   late Animation<double> _animationX;
//   late Animation<double> _animationY;
//   bool _isHovering = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 200),
//       vsync: this,
//     );
//
//     _animationX = Tween<double>(begin: 0, end: 0).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeOut),
//     )..addListener(() {
//       setState(() {
//         _rotateX = _animationX.value;
//       });
//     });
//
//     _animationY = Tween<double>(begin: 0, end: 0).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeOut),
//     )..addListener(() {
//       setState(() {
//         _rotateY = _animationY.value;
//       });
//     });
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   void _updateRotation(Offset localPosition, Size size) {
//     if (!widget.enableHoverEffect) return;
//
//     final double centerX = size.width / 2;
//     final double centerY = size.height / 2;
//
//     // Calculate rotation based on position
//     final double deltaX = (localPosition.dx - centerX) / centerX;
//     final double deltaY = (localPosition.dy - centerY) / centerY;
//
//     // Clamp values to prevent extreme rotation
//     final double targetRotateY = (deltaX * widget.depth).clamp(-widget.depth, widget.depth);
//     final double targetRotateX = (-deltaY * widget.depth).clamp(-widget.depth, widget.depth);
//
//     _animationX = Tween<double>(
//       begin: _rotateX,
//       end: targetRotateX,
//     ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
//
//     _animationY = Tween<double>(
//       begin: _rotateY,
//       end: targetRotateY,
//     ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
//
//     _controller.reset();
//     _controller.forward();
//   }
//
//   void _resetRotation() {
//     _animationX = Tween<double>(
//       begin: _rotateX,
//       end: 0,
//     ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
//
//     _animationY = Tween<double>(
//       begin: _rotateY,
//       end: 0,
//     ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
//
//     _controller.reset();
//     _controller.forward();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         return GestureDetector(
//           // Handle touch events for mobile
//           onPanUpdate: (details) {
//             if (_isHovering) {
//               _updateRotation(
//                 details.localPosition,
//                 Size(constraints.maxWidth, constraints.maxHeight),
//               );
//             }
//           },
//           onPanStart: (details) {
//             setState(() => _isHovering = true);
//             _updateRotation(
//               details.localPosition,
//               Size(constraints.maxWidth, constraints.maxHeight),
//             );
//           },
//           onPanEnd: (details) {
//             setState(() => _isHovering = false);
//             _resetRotation();
//           },
//           // Handle mouse events for desktop
//           child: MouseRegion(
//             onEnter: (_) => setState(() => _isHovering = true),
//             onExit: (_) {
//               setState(() => _isHovering = false);
//               _resetRotation();
//             },
//             onHover: (event) {
//               _updateRotation(
//                 event.localPosition,
//                 Size(constraints.maxWidth, constraints.maxHeight),
//               );
//             },
//             child: AnimatedContainer(
//               duration: const Duration(milliseconds: 200),
//               transform: Matrix4.identity()
//                 ..setEntry(3, 2, 0.001) // perspective
//                 ..rotateX(_rotateX * math.pi / 180)
//                 ..rotateY(_rotateY * math.pi / 180),
//               transformAlignment: Alignment.center,
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(12),
//                   boxShadow: _isHovering
//                       ? [
//                     BoxShadow(
//                       color: const Color(0xFF8b5cf6).withOpacity(0.3),
//                       blurRadius: 20,
//                       spreadRadius: 2,
//                       offset: Offset(_rotateY / 2, _rotateX / 2),
//                     ),
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.3),
//                       blurRadius: 30,
//                       spreadRadius: 5,
//                       offset: const Offset(0, 10),
//                     ),
//                   ]
//                       : [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.2),
//                       blurRadius: 15,
//                       spreadRadius: 1,
//                       offset: const Offset(0, 5),
//                     ),
//                   ],
//                 ),
//                 child: widget.child,
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
// import 'dart:math' as math;
// import 'package:flutter/material.dart';
//
// Widget build3DCard({
//   required IconData icon,
//   required String title,
//   required String content,
// }) {
//   return Container3D(
//     child: Container(
//       padding: const EdgeInsets.all(24),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//           colors: [
//             const Color(0xFF1e002a).withOpacity(0.6),
//             Colors.black.withOpacity(0.6),
//           ],
//         ),
//         border: Border.all(
//           color: const Color(0xFF8b5cf6).withOpacity(0.3),
//         ),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                     color: const Color(0xFF8b5cf6).withOpacity(0.5),
//                   ),
//                   borderRadius: BorderRadius.circular(8),
//                   color: Colors.black.withOpacity(0.3),
//                 ),
//                 child: Icon(
//                   icon,
//                   color: const Color(0xFF8b5cf6),
//                   size: 28,
//                 ),
//               ),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: Text(
//                   title,
//                   style: const TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 16),
//           Text(
//             content,
//             style: TextStyle(
//               color: Colors.grey[400],
//               fontSize: 14,
//               height: 1.5,
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }
//
// class Container3D extends StatefulWidget {
//   final Widget child;
//   final double depth;
//   final bool enableHoverEffect;
//
//   const Container3D({
//     Key? key,
//     required this.child,
//     this.depth = 10,
//     this.enableHoverEffect = true,
//   }) : super(key: key);
//
//   @override
//   State<Container3D> createState() => _Container3DState();
// }
//
// class _Container3DState extends State<Container3D>
//     with TickerProviderStateMixin {
//   double _rotateX = 0.0;
//   double _rotateY = 0.0;
//   late AnimationController _controller;
//   late Animation<double> _animationX;
//   late Animation<double> _animationY;
//   late AnimationController _pulseController;
//   late Animation<double> _pulseAnimation;
//   bool _isHovering = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 150),
//       vsync: this,
//     );
//
//     _animationX = Tween<double>(begin: 0, end: 0).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeOut),
//     )..addListener(() {
//       setState(() {
//         _rotateX = _animationX.value;
//       });
//     });
//
//     _animationY = Tween<double>(begin: 0, end: 0).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeOut),
//     )..addListener(() {
//       setState(() {
//         _rotateY = _animationY.value;
//       });
//     });
//
//     // Pulse animation for enhanced mobile effect
//     _pulseController = AnimationController(
//       duration: const Duration(milliseconds: 1500),
//       vsync: this,
//     );
//     _pulseAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
//       CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
//     );
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     _pulseController.dispose();
//     super.dispose();
//   }
//
//   void _updateRotation(Offset localPosition, Size size) {
//     if (!widget.enableHoverEffect) return;
//
//     final double centerX = size.width / 2;
//     final double centerY = size.height / 2;
//
//     // Enhanced rotation for better mobile visibility
//     final double deltaX = (localPosition.dx - centerX) / centerX;
//     final double deltaY = (localPosition.dy - centerY) / centerY;
//
//     // Increased depth multiplier for more dramatic effect
//     final double enhancedDepth = widget.depth * 2.5;
//     final double targetRotateY =
//     (deltaX * enhancedDepth).clamp(-enhancedDepth, enhancedDepth);
//     final double targetRotateX =
//     (-deltaY * enhancedDepth).clamp(-enhancedDepth, enhancedDepth);
//
//     _animationX = Tween<double>(
//       begin: _rotateX,
//       end: targetRotateX,
//     ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
//
//     _animationY = Tween<double>(
//       begin: _rotateY,
//       end: targetRotateY,
//     ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
//
//     _controller.reset();
//     _controller.forward();
//   }
//
//   void _resetRotation() {
//     _animationX = Tween<double>(
//       begin: _rotateX,
//       end: 0,
//     ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
//
//     _animationY = Tween<double>(
//       begin: _rotateY,
//       end: 0,
//     ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
//
//     _controller.reset();
//     _controller.forward();
//     _pulseController.reverse();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         return GestureDetector(
//           // Enhanced touch events for mobile
//           onPanUpdate: (details) {
//             if (_isHovering) {
//               _updateRotation(
//                 details.localPosition,
//                 Size(constraints.maxWidth, constraints.maxHeight),
//               );
//             }
//           },
//           onPanStart: (details) {
//             setState(() => _isHovering = true);
//             _pulseController.forward();
//             _updateRotation(
//               details.localPosition,
//               Size(constraints.maxWidth, constraints.maxHeight),
//             );
//           },
//           onPanEnd: (details) {
//             setState(() => _isHovering = false);
//             _resetRotation();
//           },
//           // Tap detection for quick touch
//           onTapDown: (details) {
//             setState(() => _isHovering = true);
//             _pulseController.forward();
//             _updateRotation(
//               details.localPosition,
//               Size(constraints.maxWidth, constraints.maxHeight),
//             );
//           },
//           onTapUp: (details) {
//             Future.delayed(const Duration(milliseconds: 200), () {
//               if (mounted) {
//                 setState(() => _isHovering = false);
//                 _resetRotation();
//               }
//             });
//           },
//           onTapCancel: () {
//             setState(() => _isHovering = false);
//             _resetRotation();
//           },
//           // Handle mouse events for desktop
//           child: MouseRegion(
//             onEnter: (_) {
//               setState(() => _isHovering = true);
//               _pulseController.forward();
//             },
//             onExit: (_) {
//               setState(() => _isHovering = false);
//               _resetRotation();
//             },
//             onHover: (event) {
//               _updateRotation(
//                 event.localPosition,
//                 Size(constraints.maxWidth, constraints.maxHeight),
//               );
//             },
//             child: AnimatedBuilder(
//               animation: _pulseAnimation,
//               builder: (context, child) {
//                 return Transform.scale(
//                   scale: _isHovering ? _pulseAnimation.value : 1.0,
//                   child: AnimatedContainer(
//                     duration: const Duration(milliseconds: 150),
//                     curve: Curves.easeOut,
//                     transform: Matrix4.identity()
//                       ..setEntry(3, 2, 0.002) // Enhanced perspective
//                       ..rotateX(_rotateX * math.pi / 180)
//                       ..rotateY(_rotateY * math.pi / 180),
//                     transformAlignment: Alignment.center,
//                     child: Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(12),
//                         border: _isHovering
//                             ? Border.all(
//                           color: const Color(0xFF8b5cf6).withOpacity(0.6),
//                           width: 2,
//                         )
//                             : null,
//                         boxShadow: _isHovering
//                             ? [
//                           // Animated purple glow
//                           BoxShadow(
//                             color: const Color(0xFF8b5cf6).withOpacity(
//                                 0.5 * _pulseAnimation.value),
//                             blurRadius: 30,
//                             spreadRadius: 5,
//                             offset: Offset(_rotateY / 2, _rotateX / 2),
//                           ),
//                           // Enhanced shadow depth
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.4),
//                             blurRadius: 40,
//                             spreadRadius: 8,
//                             offset: const Offset(0, 15),
//                           ),
//                           // Inner glow effect
//                           BoxShadow(
//                             color:
//                             const Color(0xFF8b5cf6).withOpacity(0.2),
//                             blurRadius: 15,
//                             spreadRadius: -5,
//                             offset: const Offset(0, 0),
//                           ),
//                         ]
//                             : [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.2),
//                             blurRadius: 15,
//                             spreadRadius: 1,
//                             offset: const Offset(0, 5),
//                           ),
//                         ],
//                       ),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(12),
//                         child: widget.child,
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

Widget build3DCard({
  required IconData icon,
  required String title,
  required String content,
}) {
  return Container3D(
    child: Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF1e002a).withOpacity(0.6),
            Colors.black.withOpacity(0.6),
          ],
        ),
        border: Border.all(
          color: const Color(0xFF8b5cf6).withOpacity(0.3),
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xFF8b5cf6).withOpacity(0.5),
                  ),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.black.withOpacity(0.3),
                ),
                child: Icon(
                  icon,
                  color: const Color(0xFF8b5cf6),
                  size: 28,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            content,
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ],
      ),
    ),
  );
}

class Container3D extends StatefulWidget {
  final Widget child;
  final double depth;
  final bool enableHoverEffect;

  const Container3D({
    Key? key,
    required this.child,
    this.depth = 20,
    this.enableHoverEffect = true,
  }) : super(key: key);

  @override
  State<Container3D> createState() => _Container3DState();
}

class _Container3DState extends State<Container3D>
    with TickerProviderStateMixin {
  double _rotateX = 0.0;
  double _rotateY = 0.0;
  late AnimationController _controller;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  bool _isVisible = false;
  ScrollDirection _lastScrollDirection = ScrollDirection.idle;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.02).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  void _checkVisibility() {
    if (!mounted) return;

    final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null || !renderBox.attached) return;

    final position = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;
    final screenHeight = MediaQuery.of(context).size.height;

    // Check if widget is in viewport
    final isInViewport = position.dy < screenHeight &&
        position.dy + size.height > 0;

    if (isInViewport && !_isVisible) {
      setState(() => _isVisible = true);
      _triggerScrollEffect();
    } else if (!isInViewport && _isVisible) {
      setState(() => _isVisible = false);
      _resetEffect();
    }
  }

  void _triggerScrollEffect() {
    if (!widget.enableHoverEffect) return;

    // Get scroll direction from nearest scrollable
    final scrollable = Scrollable.maybeOf(context);
    if (scrollable != null) {
      final scrollDirection = scrollable.position.userScrollDirection;

      if (scrollDirection == ScrollDirection.reverse) {
        // Scrolling down - subtle tilt up
        _animateRotation(-8, 5);
      } else if (scrollDirection == ScrollDirection.forward) {
        // Scrolling up - subtle tilt down
        _animateRotation(8, -5);
      }
    }

    _pulseController.forward();
  }

  void _animateRotation(double targetX, double targetY) {
    setState(() {
      _rotateX = targetX;
      _rotateY = targetY;
    });

    // Auto reset after effect
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        _resetEffect();
      }
    });
  }

  void _resetEffect() {
    setState(() {
      _rotateX = 0;
      _rotateY = 0;
    });
    _pulseController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    // Check visibility on every frame
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkVisibility());

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollUpdateNotification) {
          _checkVisibility();
        }
        return false;
      },
      child: MouseRegion(
        onEnter: (_) {
          setState(() => _isVisible = true);
          _pulseController.forward();
        },
        onExit: (_) {
          setState(() => _isVisible = false);
          _resetEffect();
        },
        onHover: (event) {
          if (!widget.enableHoverEffect) return;
          final RenderBox renderBox = context.findRenderObject() as RenderBox;
          final size = renderBox.size;
          final localPosition = event.localPosition;

          final centerX = size.width / 2;
          final centerY = size.height / 2;

          final deltaX = (localPosition.dx - centerX) / centerX;
          final deltaY = (localPosition.dy - centerY) / centerY;

          final enhancedDepth = widget.depth * 2.5;
          setState(() {
            _rotateY = (deltaX * enhancedDepth).clamp(-enhancedDepth, enhancedDepth);
            _rotateX = (-deltaY * enhancedDepth).clamp(-enhancedDepth, enhancedDepth);
          });
        },
        child: AnimatedBuilder(
          animation: Listenable.merge([_controller, _pulseAnimation]),
          builder: (context, child) {
            return TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: _isVisible ? 1.0 : 0.0),
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOut,
              builder: (context, value, child) {
                return Transform.scale(
                  scale: 1.0 + (0.02 * value * _pulseAnimation.value),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeOut,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateX(_rotateX * math.pi / 180 * value)
                      ..rotateY(_rotateY * math.pi / 180 * value),
                    transformAlignment: Alignment.center,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: _isVisible
                            ? Border.all(
                          color: Color.lerp(
                            Colors.transparent,
                            const Color(0xFF8b5cf6).withOpacity(0.3),
                            value,
                          )!,
                          width: 1 * value,
                        )
                            : null,
                        boxShadow: [
                          if (_isVisible) ...[
                            BoxShadow(
                              color: Color.lerp(
                                Colors.transparent,
                                const Color(0xFF8b5cf6).withOpacity(0.15),
                                value * _pulseAnimation.value,
                              )!,
                              blurRadius: 20 * value,
                              spreadRadius: 2 * value,
                              offset: Offset(_rotateY / 3, _rotateX / 3),
                            ),
                            BoxShadow(
                              color: Colors.black.withOpacity(0.25 * value),
                              blurRadius: 25 * value,
                              spreadRadius: 3 * value,
                              offset: Offset(0, 8 * value),
                            ),
                          ] else
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 15,
                              spreadRadius: 1,
                              offset: const Offset(0, 5),
                            ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: widget.child,
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}