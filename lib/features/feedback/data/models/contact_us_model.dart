
import 'package:ushopie_ecom/features/feedback/domain/entity/contact_us_entity.dart';

class ContactUsModel extends ContactUs{
  ContactUsModel({
    required super.email,
    required super.name,
    required super.subject,
    required super.message,
    required super.contact,
  });

  
  ContactUsModel.fromJson(Map<String, dynamic> json):super(
    email : json['email'],
    name : json['name'],
    subject : json['subject'],
    message : json['message'],
    contact : json['contact'],
  );
    

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['email'] = email;
    _data['name'] = name;
    _data['subject'] = subject;
    _data['message'] = message;
    _data['contact'] = contact;
    return _data;
  }
}
