
import 'package:ushopie_ecom/features/auth/domain/entity/signin_req.dart';

class SigninRequestModel extends SigninRequest {
  SigninRequestModel({required super.email, required super.password});

  SigninRequestModel.fromJson(Map<String, dynamic> json)
    : super(
      email: json['email'],
      password: json['password']
    );
  

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['email'] = email;
    _data['password'] = password;
    return _data;
  }

}