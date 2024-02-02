
import 'package:ushopie_ecom/features/auth/data/models/signin_req.dart';
import 'package:ushopie_ecom/features/auth/data/models/signup_res.dart';
import 'package:ushopie_ecom/features/auth/domain/repo/signin_repo.dart';

class SigninUsecase {

  final SigninRepo signinRepo;

  SigninUsecase({required this.signinRepo});


  Future <AuthResponseModel> signinUser(SigninRequestModel req) async {

    try {

      final signinResult = await signinRepo.signin(req);
      return signinResult;
      
    } catch (e) {
      throw Exception('Failed to signup. Error: $e');
    }
  }
}