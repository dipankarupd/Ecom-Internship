
import 'package:ushopie_ecom/features/auth/data/models/signin_req.dart';
import 'package:ushopie_ecom/features/auth/data/models/signup_res.dart';

abstract class SigninRepo {
  Future <AuthResponseModel> signin(SigninRequestModel signinRequest);
}