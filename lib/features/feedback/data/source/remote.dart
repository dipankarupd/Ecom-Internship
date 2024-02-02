

import 'package:dio/dio.dart';
import 'package:ushopie_ecom/features/feedback/data/models/contact_us_model.dart';

class ContactUsRemote {

  final Dio dio;


  ContactUsRemote({
    required this.dio
  });


  Future<void> submitContactUsForm(ContactUsModel req) async {

    final request = req.toJson();
    try {
      final response = await dio.post(
      "https://ecom-api-y3aj.onrender.com/utils/contactUs"
    );

      if (response.statusCode == 200) {
        return;
      }
  
    }
    catch(e) {
      throw Exception(e);
    }
  }
  
  
}