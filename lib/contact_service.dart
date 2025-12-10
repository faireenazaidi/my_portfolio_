import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'SFZ/widgets/snackbar.dart';


final nameController = TextEditingController();
final emailController = TextEditingController();
final messageController = TextEditingController();

Future<void> sendEmail(BuildContext context,  TextEditingController nameController, TextEditingController emailController, TextEditingController messageController) async {
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
        'from_name': nameController.text.trim(),
        'from_email': emailController.text.trim(),
        'message': messageController.text.trim(),
      }
    }),
  );

  if (response.statusCode == 200) {
    print('Message sent!');
    // Success
    ScaffoldMessenger.of(context).showSnackBar(
      CustomSnackbar.show("Operation completed successfully!", SnackbarType.success),
    );


    nameController.clear();
    emailController.clear();
    messageController.clear();
  }
  else {
    print('Failed to send message: ${response.body}');
    ScaffoldMessenger.of(context).showSnackBar(
      CustomSnackbar.show("Something went wrong!", SnackbarType.error),
    );

  }
}
