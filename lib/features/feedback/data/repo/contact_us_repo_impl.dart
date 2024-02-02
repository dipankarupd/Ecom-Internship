

import 'package:ushopie_ecom/features/feedback/data/models/contact_us_model.dart';
import 'package:ushopie_ecom/features/feedback/data/source/remote.dart';
import 'package:ushopie_ecom/features/feedback/domain/repo/contact_us_repo.dart';

class ContactUsRepoImpl implements ContactUsRepo {

  ContactUsRemote remote;
  ContactUsRepoImpl({required this.remote});

  @override
  Future<void> contactUs(ContactUsModel request) async{
    
    try {
      remote.submitContactUsForm(request);
      return;
    }
    catch(e) {
      throw Exception(e);
    }
  }

}