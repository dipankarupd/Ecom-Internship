

import 'package:ushopie_ecom/features/feedback/data/models/contact_us_model.dart';

abstract class ContactUsRepo {

  Future<void> contactUs(ContactUsModel request);
}