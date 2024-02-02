// lib/features/auth/domain/usecases/signup_usecase.dart

import 'package:ushopie_ecom/features/auth/data/models/signup_req.dart';
import 'package:ushopie_ecom/features/auth/data/models/signup_res.dart';
import 'package:ushopie_ecom/features/auth/domain/entity/signup_res.dart';
import 'package:ushopie_ecom/features/auth/domain/repo/signup_repo.dart';

class SignupUsecase {
  final SignupRepo signupRepo;

  SignupUsecase({required this.signupRepo});

  Future<AuthResponseModel> signupUser(SignupRequestModel request) async {
    try {
      // Call the repository to perform the signup operation
      final signupResult = await signupRepo.signup(request);

      // Return the result from the repository
      return signupResult;
    } catch (e) {
      // Handle any exceptions that may occur during the use case execution
      throw Exception(e);
    }
  }
}