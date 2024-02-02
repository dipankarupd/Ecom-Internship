
import 'package:ushopie_ecom/features/auth/data/models/signin_req.dart';
import 'package:ushopie_ecom/features/auth/data/models/signup_res.dart';
import 'package:ushopie_ecom/features/auth/data/source/remote.dart';
import 'package:ushopie_ecom/features/auth/domain/repo/signin_repo.dart';

class SigninRepoImpl implements SigninRepo {

  final RemoteSource remoteSource;

  SigninRepoImpl({required this.remoteSource});

  @override
  Future<AuthResponseModel> signin(SigninRequestModel signinRequest) async {
    try {
      return remoteSource.signin(signinRequest);
    } catch (e) {
      throw Exception('Failed to signin. Error: $e');
    }
  }

}