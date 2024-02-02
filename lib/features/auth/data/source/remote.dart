// lib/features/auth/data/remote/remote_source.
import 'package:dio/dio.dart';
import 'package:ushopie_ecom/features/auth/data/models/signin_req.dart';
import 'package:ushopie_ecom/features/auth/data/models/signup_req.dart';
import 'package:ushopie_ecom/features/auth/data/models/signup_res.dart';

class RemoteSource {
  final Dio dio;
  

  RemoteSource({required this.dio}) {
    dio.options = BaseOptions(
      // Your other options...
      validateStatus: (status) {
        return true; // Add other success status codes as needed
      },
    );
  }

  Future<AuthResponseModel> signup(SignupRequestModel request) async {
    try {
      final response = await dio.post(
        'https://ecom-api-y3aj.onrender.com/api/v1/user/signup',
        data: request.toJson(),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data;
        final signupResponse = AuthResponseModel.fromJson(responseData);
        return signupResponse;
        
      } 

      
      
      else {
        throw Exception('Failed to signup. Status code: ${response.statusCode}');
      }
    } catch (e) {

      if (e is DioException) {
        throw Exception("Err");
      }
      // Handle any exceptions that may occur during the API call
      throw Exception('Failed to signup. Error: $e');
    }
  }


  // signin

Future<AuthResponseModel> signin(SigninRequestModel request) async {
  try {
    final response = await dio.post(
      "https://ecom-api-y3aj.onrender.com/api/v1/user/login",
      data: request.toJson(),
    );

    final Map<String, dynamic> responseData = response.data;

    if (response.statusCode == 200) {
      
      return AuthResponseModel.fromJson(responseData);
    } else if (response.statusCode == 405) {

      return AuthResponseModel(status: 'fail');

    } else if (response.statusCode == 500) {

      return AuthResponseModel(status: 'error', message: 'Something went very wrong!');
      //throw Exception('Error logging in');

    } else {

      throw Exception('Failed to signin. Status code: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to signin.');
  }
}


}
