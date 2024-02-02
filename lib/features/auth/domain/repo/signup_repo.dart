
import 'package:ushopie_ecom/features/auth/data/models/signup_req.dart';
import 'package:ushopie_ecom/features/auth/data/models/signup_res.dart';
import 'package:ushopie_ecom/features/auth/domain/entity/signup_res.dart';

abstract class SignupRepo {

  Future<AuthResponseModel> signup(SignupRequestModel request) ;
}