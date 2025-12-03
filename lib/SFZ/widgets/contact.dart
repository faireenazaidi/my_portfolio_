import 'package:flutter/material.dart';
import '3d_Container.dart';
import 'Section_header.dart';

Widget buildContactSection({
required TextEditingController nameController,
required TextEditingController emailController,
required TextEditingController messageController,
})
{

  return Container(
    padding: const EdgeInsets.all(24),
    constraints: const BoxConstraints(maxWidth: 1000),
    child: Column(
      children: [
        buildSectionHeader('04.', 'Get In Touch'),
        const SizedBox(height: 48),
        LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 768) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        buildContactCard(
                          icon: Icons.email,
                          title: 'Email',
                          content: 'faireenzaidi@gmail.com',
                        ),
                        const SizedBox(height: 16),
                        buildContactCard(
                          icon: Icons.phone,
                          title: 'Phone',
                          content: '+91 8178822136',
                        ),
                        const SizedBox(height: 16),
                        buildContactCard(
                          icon: Icons.location_on,
                          title: 'Location',
                          content: 'Noor Colony, Dubagga, Lucknow, UP',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(child: buildContactForm(
                    nameController: nameController,
                    emailController: emailController,
                    messageController: messageController,
                  )),
                ],
              );
            }
            return Column(
              children: [
                buildContactCard(
                  icon: Icons.email,
                  title: 'Email',
                  content: 'faireenzaidi@gmail.com',
                ),
                const SizedBox(height: 16),
                buildContactForm(
                  nameController: nameController,
                  emailController: emailController,
                  messageController: messageController,
                ),
              ],
            );
          },
        ),
      ],
    ),
  );
}

Widget buildContactForm({
  required TextEditingController nameController,
  required TextEditingController emailController,
  required TextEditingController messageController,
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
        children: [
          TextField(
            controller: nameController,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Your Name',
              hintStyle: TextStyle(color: Colors.grey[600]),
              filled: true,
              fillColor: Colors.black.withOpacity(0.7),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: const Color(0xFF8b5cf6).withOpacity(0.4),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: Color(0xFF8b5cf6),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: emailController,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Your Email',
              hintStyle: TextStyle(color: Colors.grey[600]),
              filled: true,
              fillColor: Colors.black.withOpacity(0.7),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: const Color(0xFF8b5cf6).withOpacity(0.4),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: Color(0xFF8b5cf6),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: messageController,
            maxLines: 4,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Your Message',
              hintStyle: TextStyle(color: Colors.grey[600]),
              filled: true,
              fillColor: Colors.black.withOpacity(0.7),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: const Color(0xFF8b5cf6).withOpacity(0.4),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: Color(0xFF8b5cf6),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Handle send
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8b5cf6),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 10,
                shadowColor: const Color(0xFF8b5cf6),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.send, size: 18),
                  SizedBox(width: 8),
                  Text(
                    'Send Message',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildContactCard({
  required IconData icon,
  required String title,
  required String content,
}) {
  return Container3D(
    child: Container(
      padding: const EdgeInsets.all(20),
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
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 12,
            ),
          ),
        ],
      ),
    ),
  );

}

