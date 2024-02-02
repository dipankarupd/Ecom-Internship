// lib/features/auth/data/repo/signup_repo_impl.dart

import 'package:ushopie_ecom/features/auth/data/models/signup_req.dart';
import 'package:ushopie_ecom/features/auth/data/models/signup_res.dart';
import 'package:ushopie_ecom/features/auth/data/source/remote.dart';
import 'package:ushopie_ecom/features/auth/domain/entity/signup_res.dart';
import 'package:ushopie_ecom/features/auth/domain/repo/signup_repo.dart';


class SignupRepoImpl implements SignupRepo {
  final RemoteSource remoteSource;

  SignupRepoImpl({required this.remoteSource});

  @override
  Future<AuthResponseModel> signup(SignupRequestModel request) async {
    try {
      // Call the remote data source to perform the signup operation
      return remoteSource.signup(request);
    } catch (e) {
      // Handle any exceptions that may occur during the API call
      throw Exception('Failed to signup. Error: $e');
    }
  }
}
