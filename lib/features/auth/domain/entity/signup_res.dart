
import 'package:ushopie_ecom/features/auth/data/models/user_profile.dart';

class AuthResponse {

   String status;
   String? token;
   UserProfileModel? userProfile;
   String? message;


  AuthResponse({
    required this.status,
    this.token,
    this.userProfile,
    this.message
  });
}