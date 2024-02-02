import 'dart:convert';
import 'package:ushopie_ecom/features/auth/data/models/user_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static Future<void> saveUserProfile(UserProfileModel userProfile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user_profile', json.encode(userProfile.toJson()));
  }

  static Future<UserProfileModel?> loadUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userProfileJson = prefs.getString('user_profile');

    if (userProfileJson != null) {
      Map<String, dynamic> decodedJson = json.decode(userProfileJson);
      return UserProfileModel.fromJson(decodedJson);
    }

    return null;
  }

  static Future<void> clearUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('user_profile');
    
  }
}
