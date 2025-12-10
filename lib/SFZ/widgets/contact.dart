import 'package:flutter/material.dart';
import 'package:untitled/SFZ/widgets/snackbar.dart';
import '../../contact_service.dart';
import '3d_Container.dart';
import 'Section_header.dart';

final _formKey = GlobalKey<FormState>();
Widget buildContactSection(BuildContext context, {
  required TextEditingController nameController,
  required TextEditingController emailController,
  required TextEditingController messageController,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
    constraints: const BoxConstraints(maxWidth: 1000),
    child: Column(
      children: [
        buildSectionHeader(context,'04.','Contact Information'),
        const SizedBox(height: 48),
        LayoutBuilder(
          builder: (context, constraints) {
            final isDesktop = constraints.maxWidth > 768;

            if (isDesktop) {
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
                  Expanded(
                    child: buildContactForm(
                      context,
                      nameController: nameController,
                      emailController: emailController,
                      messageController: messageController,
                    ),
                  ),
                ],
              );
            } else {
              return Column(
                children: [
                  _buildMobileContactInfo(),
                  const SizedBox(height: 32),
                  buildSectionHeader(context,'05.', 'Get In Touch'),
                  const SizedBox(height: 32),

                  buildContactForm(
                    context,
                    nameController: nameController,
                    emailController: emailController,
                    messageController: messageController,
                  ),
                 // const SizedBox(height: 32),
                ],
              );
            }
          },
        ),
      ],
    ),
  );
}

// Compact contact info for mobile
Widget _buildMobileContactInfo() {
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
          _buildCompactContactItem(
            icon: Icons.email,
            title: 'Email',
            content: 'faireenzaidi@gmail.com',
          ),
          Divider(
            color: const Color(0xFF8b5cf6).withOpacity(0.2),
            height: 32,
          ),
          _buildCompactContactItem(
            icon: Icons.phone,
            title: 'Phone',
            content: '+91 8178822136',
          ),
          Divider(
            color: const Color(0xFF8b5cf6).withOpacity(0.2),
            height: 32,
          ),
          _buildCompactContactItem(
            icon: Icons.location_on,
            title: 'Location',
            content: 'Noor Colony, Dubagga, Lucknow, UP',
          ),
        ],
      ),
    ),
  );
}

Widget _buildCompactContactItem({
  required IconData icon,
  required String title,
  required String content,
}) {
  return Row(
    children: [
      Container(
        padding: const EdgeInsets.all(10),
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
      const SizedBox(width: 16),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.grey[500],
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              content,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget buildContactForm(
    BuildContext context,
    {
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
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            _buildTextField(
              controller: nameController,
              hintText: 'Your Name',
              icon: Icons.person_outline,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: emailController,
              hintText: 'Your Email',
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: messageController,
              hintText: 'Your Message',
              icon: Icons.message_outlined,
              maxLines: 4,
              keyboardType: TextInputType.multiline,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (nameController.text.trim().isEmpty ||
                      emailController.text.trim().isEmpty ||
                      messageController.text.trim().isEmpty) {

                    ScaffoldMessenger.of(context).showSnackBar(
                      CustomSnackbar.show("Please fill all fields before sending.", SnackbarType.info),
                    );
                    return; // Stop execution
                  }

                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(emailController.text.trim())) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      CustomSnackbar.show("Please enter a valid email address.", SnackbarType.info),
                    );
                    return;
                  }

                  sendEmail(context, nameController, emailController, messageController);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8b5cf6),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 10,
                  shadowColor: const Color(0xFF8b5cf6).withOpacity(0.5),
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
    ),
  );
}

Widget _buildTextField({
  required TextEditingController controller,
  required String hintText,
  required IconData icon,
  int maxLines = 1,
  TextInputType keyboardType = TextInputType.text,
}) {
  return TextField(
    controller: controller,
    maxLines: maxLines,
    keyboardType: keyboardType,
    style: const TextStyle(color: Colors.white, fontSize: 15),
    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.grey[600], fontSize: 14),
      prefixIcon: Icon(icon, color: const Color(0xFF8b5cf6).withOpacity(0.7)),
      filled: true,
      fillColor: Colors.black.withOpacity(0.7),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: const Color(0xFF8b5cf6).withOpacity(0.4),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: const Color(0xFF8b5cf6).withOpacity(0.4),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: Color(0xFF8b5cf6),
          width: 2,
        ),
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


