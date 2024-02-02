
import 'package:ushopie_ecom/features/feedback/data/models/contact_us_model.dart';
import 'package:ushopie_ecom/features/feedback/domain/repo/contact_us_repo.dart';

class ContactUsUsecase {

  final ContactUsRepo contactUsRepo;

  ContactUsUsecase({required this.contactUsRepo});

  Future<void> submitContactUsForm(ContactUsModel req) async {

    try {
      contactUsRepo.contactUs(req);
    }
    catch (e) {
      throw Exception(e);
    }
  }

}