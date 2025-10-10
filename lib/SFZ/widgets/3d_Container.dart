import 'package:flutter/material.dart';


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

  const Container3D({Key? key, required this.child}) : super(key: key);

  @override
  State<Container3D> createState() => Container3DState();
}

class Container3DState extends State<Container3D> {
  double _rotateX = 0;
  double _rotateY = 0;
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) {
        setState(() {
          _isHovering = false;
          _rotateX = 0;
          _rotateY = 0;
        });
      },
      onHover: (event) {
        final box = context.findRenderObject() as RenderBox;
        final localPosition = box.globalToLocal(event.position);
        final width = box.size.width;
        final height = box.size.height;

        setState(() {
          _rotateY = ((localPosition.dx / width) - 0.5) * 0.2;
          _rotateX = ((localPosition.dy / height) - 0.5) * -0.2;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateX(_rotateX)
          ..rotateY(_rotateY)
          ..scale(_isHovering ? 1.02 : 1.0),
        child: widget.child,
      ),
    );
  }
}