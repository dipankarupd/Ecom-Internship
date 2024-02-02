
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:ushopie_ecom/di.dart';
import 'package:ushopie_ecom/features/auth/data/models/user_profile.dart';
import 'package:ushopie_ecom/features/auth/presentation/providers/user_provider.dart';
import 'package:ushopie_ecom/features/products/presentation/widges/bottom_navbar.dart';
import 'package:ushopie_ecom/features/util/pages/get_started.dart';
import 'package:ushopie_ecom/features/util/widges/app_logo.dart';  

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  Future<bool> _getLoginStatus() async {
   
   UserProfileModel? userProfile = await UserPreferences.loadUserProfile();
  return userProfile != null;
    
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _getLoginStatus(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          // Return the AnimatedSplashScreen with the determined next screen
          return AnimatedSplashScreen(
            duration: 2000,
            splash: const AppLogo(),
            splashTransition: SplashTransition.fadeTransition,
            //nextScreen: GetStarted(),
            nextScreen: snapshot.data! ? BottomNavBar(productUsecase: DependancyInjection.createProductUsecase(), cartUsecase: DependancyInjection.createCartUsecase()) : const GetStarted(),
          );
        }
      },
    );
  }
}
