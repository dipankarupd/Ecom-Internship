import 'package:flutter/material.dart';
import 'package:ushopie_ecom/features/feedback/data/models/contact_us_model.dart';
import 'package:ushopie_ecom/features/feedback/domain/usecases/contact_us_usecase.dart';

class ContactForm extends StatefulWidget {
  final ContactUsUsecase contactUsUsecase;
  const ContactForm({super.key, required this.contactUsUsecase});

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _key = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  _submitForm(BuildContext context) {
    final String name = _nameController.text;
    final String email = _emailController.text;
    final String subject = _subjectController.text;
    final String contact = _contactController.text;
    final String message = _messageController.text;

    final request = ContactUsModel(
        email: email,
        name: name,
        subject: subject,
        message: message,
        contact: contact);

    try {
      widget.contactUsUsecase.submitContactUsForm(request).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Message submitted successfully $name'),
          ),
        );
        _nameController.text = "";
        _emailController.text = "";
        _contactController.text = "";
        _messageController.text = "";
        _subjectController.text = "";
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error sending the message")
        )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 21),
              child: Text(
                "Fill the form",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 13),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            const SizedBox(height: 13),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                // Add more email validation logic if needed
                return null;
              },
            ),
            const SizedBox(height: 13),
            TextFormField(
              controller: _subjectController,
              decoration: const InputDecoration(
                labelText: 'Subject',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter Subject';
                }
                // Add more phone number validation logic if needed
                return null;
              },
            ),
            const SizedBox(height: 13),
            TextFormField(
              controller: _contactController,
              decoration: const InputDecoration(
                labelText: 'Contact',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your contact';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 13,
            ),
            TextFormField(
              controller: _messageController,
              maxLines: 5,
              maxLength: 250,
              decoration: const InputDecoration(
                labelText: 'Enter your message here',
                alignLabelWithHint: true,
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return ("Enter the message");
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (_key.currentState!.validate()) {
                    // Validation succeeded
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   const SnackBar(
                    //     content: Text('Message submitted successfully'),
                    //   ),
                    // );

                    _submitForm(context);
                  }
                },
                child: const Text(
                  'Submit',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
