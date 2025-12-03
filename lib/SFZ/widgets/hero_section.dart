import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:universal_html/html.dart' as html;
import 'Section_header.dart';
import 'blinking_cursor.dart';
import 'contact.dart';



Widget buildHeroSection( BuildContext context,String typedText,  GlobalKey contactSectionKey,) {
  return Container(
    padding: const EdgeInsets.all(24),
    constraints: const BoxConstraints(maxWidth: 1200),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 100),
        // Hi text
        Row(
          children: const [
            Text('▸', style: TextStyle(color: Color(0xFF8b5cf6))),
            SizedBox(width: 8),
            Text(
              'Hi, my name is',
              style: TextStyle(
                color: Color(0xFF8b5cf6),
                fontSize: 14,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Name
        const Text(
          'Syed Faireena Zaidi',
          style: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        // Typed Text
        Row(
          children: [
            const Text(
              '\$',
              style: TextStyle(color: Color(0xFF8b5cf6), fontSize: 24),
            ),
            const SizedBox(width: 8),
            Text(
              typedText,
              style: const TextStyle(
                color: Color(0xFF8b5cf6),
                fontSize: 24,
              ),
            ),
            BlinkingCursor(),
          ],
        ),
        const SizedBox(height: 24),
        // Description
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              '// Results-driven developer specializing in',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            Text(
              '// cross-platform mobile development with',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            Text.rich(
              TextSpan(
                text: '// ',
                style: TextStyle(color: Color(0xFF8b5cf6)),
                children: [
                  TextSpan(
                    text: '1 year',
                    style: TextStyle(color: Color(0xFF8b5cf6)),
                  ),
                  TextSpan(
                    text: ' of production experience',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
        const SizedBox(height: 32),
        // Buttons
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            buildButton3D(
              label: '\$ Contact Me',
              isPrimary: false,
              onPressed: () {
                scrollToSection(contactSectionKey);
                print("Scrolling to contact section");
              },
            ),
            buildButton3D(
              label: 'Download CV',
              isPrimary: true,
              icon: Icons.download,
              onPressed: () {
                downloadCV(context);
                print("Button is Tapped");

              }
            ),
          ],
        ),
        const SizedBox(height: 32),
        // Social Links
        Row(
          children: [
            buildSocialButton(Icons.phone),
            const SizedBox(width: 16),
            buildSocialButton(Icons.work),
            const SizedBox(width: 16),
            buildSocialButton(Icons.code),
          ],
        ),
      ],
    ),
  );
}
Widget buildSocialButton(IconData icon) {
  return HoverButton3D(
    child: Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFF8b5cf6).withOpacity(0.5),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, size: 20),
    ),
  );
}


Widget buildButton3D({
  required String label,
  required bool isPrimary,
  IconData? icon,
  required VoidCallback onPressed,
}) {
  return GestureDetector(
    onTap: onPressed,
    child: HoverButton3D(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: isPrimary ? const Color(0xFF8b5cf6) : Colors.transparent,
          border: Border.all(
            color: const Color(0xFF8b5cf6),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
          boxShadow: isPrimary
              ? [
            BoxShadow(
              color: const Color(0xFF8b5cf6).withOpacity(0.5),
              blurRadius: 20,
              spreadRadius: 2,
            ),
          ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 20),
              const SizedBox(width: 8),
            ],
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
class HoverButton3D extends StatefulWidget {
  final Widget child;

  const HoverButton3D({Key? key, required this.child}) : super(key: key);

  @override
  State<HoverButton3D> createState() => HoverButton3DState();
}

class HoverButton3DState extends State<HoverButton3D> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: AnimatedScale(
        scale: _isHovering ? 1.05 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: widget.child,
      ),
    );
  }
}

Future<void> downloadCV(BuildContext context) async {
  try {
    if (kIsWeb) {
      final url = "https://raw.githubusercontent.com/faireenazaidi/my_portfolio_/main/Faireena_Resume-1.pdf";
      final anchor = html.AnchorElement(href: url)
        ..setAttribute("download", "Syed_Faireena_CV.pdf")
        ..click();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("CV download started in browser")),
      );
      return;
    }

    // For mobile platforms
    if (Platform.isAndroid) {
      if (await Permission.storage.request().isDenied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Storage permission denied")),
        );
        return;
      }
    }

    Directory downloadsDir;
    if (Platform.isAndroid) {
      downloadsDir = Directory('/storage/emulated/0/Download');
    } else if (Platform.isIOS) {
      downloadsDir = await getApplicationDocumentsDirectory();
    } else {
      downloadsDir = await getApplicationDocumentsDirectory();
    }

    final filePath = "${downloadsDir.path}/Syed_Faireena_CV.pdf";

    await Dio().download(
      "https://raw.githubusercontent.com/faireenazaidi/my_portfolio_/main/Faireena_Resume-1.pdf",
      filePath,
      onReceiveProgress: (received, total) {
        if (total != -1) {
          debugPrint("Downloading: ${(received / total * 100).toStringAsFixed(0)}%");
        }
      },
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
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
void scrollToSection(GlobalKey key) {
  final context = key.currentContext;
  if (context != null) {
    Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
      alignment: 0.1,
    );
  }
}