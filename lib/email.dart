import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: EmailSender(),
    );
  }
}

class EmailSender extends StatefulWidget {
  @override
  _EmailSenderState createState() => _EmailSenderState();
}

class _EmailSenderState extends State<EmailSender> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  bool _isSending = false; // To show loading state

  Future<void> sendEmail() async {
    setState(() => _isSending = true);

    String username = "kit.25.21bad303@gmail.com"; // Replace with your email
    String password = "Consistency30"; // Use App Password (not your actual password)

    final smtpServer = gmail(username, password);
    final message = Message()
      ..from = Address(username, "Your App")
      ..recipients.add(_emailController.text)
      ..subject = _subjectController.text
      ..text = _messageController.text;

    try {
      await send(message, smtpServer);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("✅ Email sent successfully!")));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("❌ Error: $e")));
    }

    setState(() => _isSending = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Send Email')),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Recipient Email', border: OutlineInputBorder()),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _subjectController,
              decoration: InputDecoration(labelText: 'Subject', border: OutlineInputBorder()),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _messageController,
              decoration: InputDecoration(labelText: 'Message', border: OutlineInputBorder()),
              maxLines: 4,
            ),
            SizedBox(height: 20),
            _isSending
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: sendEmail,
                    child: Text("Send Email"),
                  ),
          ],
        ),
      ),
    );
  }
}
