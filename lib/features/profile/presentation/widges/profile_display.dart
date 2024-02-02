import 'package:flutter/material.dart';
import 'package:ushopie_ecom/config/themes/theme_constants.dart';
import 'package:ushopie_ecom/features/auth/data/models/user_profile.dart';
import 'package:ushopie_ecom/features/auth/presentation/providers/user_provider.dart';

class ProfileDisplay extends StatefulWidget {
  const ProfileDisplay({Key? key}) : super(key: key);

  @override
  _ProfileDisplayState createState() => _ProfileDisplayState();
}

class _ProfileDisplayState extends State<ProfileDisplay> {
  late UserProfileModel _userProfile;
  late Future<UserProfileModel?> _userProfileFuture;

  @override
  void initState() {
    super.initState();
    _userProfileFuture = _loadUserProfile();
  }

  Future<UserProfileModel?> _loadUserProfile() async {
    return await UserPreferences.loadUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserProfileModel?>(
      future: _userProfileFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          _userProfile = snapshot.data!;
          return _buildUserProfileWidget();
        } else {
          return const Text('No user profile available.');
        }
      },
    );
  }

  Widget _buildUserProfileWidget() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: colorSecondary,
      ),
      height: 110,
      padding: const EdgeInsets.only(left: 21, top: 11),
      child: Row(
        children: [
          Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                width: 1,
                color: Colors.white,
              ),
            ),
            child: ClipOval(
              child: Image.network(
                'https://images.pexels.com/photos/9232043/pexels-photo-9232043.jpeg?auto=compress&cs=tinysrgb&w=800',
                fit: BoxFit.cover,
                width: 55,
                height: 55,
              ),
            ),
          ),
          const SizedBox(width: 35),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
               Text(
                "User ${_userProfile.id}",
                 style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                _userProfile.email,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
