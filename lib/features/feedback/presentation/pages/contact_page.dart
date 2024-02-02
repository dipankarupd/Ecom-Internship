import 'package:flutter/material.dart';
import 'package:ushopie_ecom/config/themes/theme_constants.dart';
import 'package:ushopie_ecom/features/feedback/domain/usecases/contact_us_usecase.dart';
import 'package:ushopie_ecom/features/products/presentation/widges/app_bars.dart';
import 'package:ushopie_ecom/features/feedback/presentation/widges/contact_form.dart';

class ContactPage extends StatelessWidget {
  final ContactUsUsecase contactUsUsecase;
  const ContactPage({super.key, required this.contactUsUsecase});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: const InnerAppBar(title: "Contact Us"),
      body: Container(
        color: colorAccent,
        padding: const EdgeInsets.all(14),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Center(
              child: Text("Let us know if you have any query",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
            ),

            const SizedBox(height: 19,),

            // Form:
            ContactForm(contactUsUsecase: contactUsUsecase,),
          ],
        ),
      ),
    );
  }
}