import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

Future<void> sendEmail() async {
  String username = 'faireenazaidi7@gmail.com';
  String password = 'frcprakwyztkpshi';

  final smtpServer = gmail(username, password);

  final message = Message()
    ..from = Address(username, 'Faireena Portfolio')
    ..recipients.add('faireenazaidi7@gmail.com')
    ..subject = 'Test Email from Flutter'
    ..text = 'Hello, this is a test email sent from Flutter using Gmail SMTP.';

  try {
    final sendReport = await send(message, smtpServer);
    print('Message sent: $sendReport');
  }
  on MailerException
  catch (e) {
    print('Message not sent.');
    for (var p in e.problems) {
      print('Problem: ${p.code}: ${p.msg}');
    }
  }
}
