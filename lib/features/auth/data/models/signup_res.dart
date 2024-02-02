import 'package:ushopie_ecom/features/auth/data/models/user_profile.dart';
import 'package:ushopie_ecom/features/auth/domain/entity/signup_res.dart';

class AuthResponseModel extends AuthResponse {

  AuthResponseModel({
    required String status,
    String? token,
    UserProfileModel? userProfile,
    String? message,
  }) : super(status: status, token: token, userProfile: userProfile, message: message);

  AuthResponseModel.fromJson(Map<String, dynamic> json)
      : super(
          status: json['status'],
          token: json.containsKey('token') ? json['token'] : null,
          userProfile: json.containsKey('userProfile') ? UserProfileModel.fromJson(json['userProfile']) : null,
          message: json.containsKey('message') ? json['message'] : null,
        );

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['token'] = token;
    _data['userProfile'] = (userProfile as UserProfileModel).toJson();
    _data['message'] = message;
    return _data;
  }
}
