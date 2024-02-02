
import 'package:ushopie_ecom/features/auth/domain/entity/signup_req.dart';

class SignupRequestModel extends SignupRequest {

  SignupRequestModel({
    required String name,
    required String email,
    required String password
  }) : super(name: name, email: email, password: password);


  SignupRequestModel.fromJson(Map<String, dynamic> json)
      : super(
          name: json['name'],
          email: json['email'],
          password: json['password'],
        );

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['email'] = email;
    _data['password'] = password;
    return _data;
  }
}