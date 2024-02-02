import 'package:flutter/material.dart';
import 'package:ushopie_ecom/config/routes/app_route.dart';
import 'package:ushopie_ecom/config/themes/theme_constants.dart';
import 'package:ushopie_ecom/features/auth/presentation/providers/user_provider.dart';
import 'package:ushopie_ecom/features/products/presentation/widges/app_bars.dart';
import 'package:ushopie_ecom/features/profile/presentation/widges/profile_display.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  void _performLogout(BuildContext context) async {
  // Clear user profile data
  await UserPreferences.clearUserProfile();

  // Navigate to GetStarted page
  Navigator.pushReplacementNamed(context, AppRoute.getstarted);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: const ApplicationToolBar(title: "Profile"),

      body: SingleChildScrollView(
        child: Container(
          color: colorAccent,
          padding: const EdgeInsets.all(24),
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile container:
              const ProfileDisplay(),
        
              // Accessibility list

              const SizedBox(height: 13,),
              itemCard("Wishlist", AppRoute.wishlist, Icons.card_travel, context),
              // const SizedBox(height: 8,),
              // itemCard("Cart",AppRoute.cart, Icons.phone, context),
              const SizedBox(height: 8,),
              itemCard("Order History",AppRoute.wishlist, Icons.backpack, context),
              const SizedBox(height: 8,),
              itemCard("Contact us",AppRoute.contact, Icons.phone, context),
              const SizedBox(height: 8,),
              itemCard("Terms and Conditionss","", Icons.policy, context),
              const SizedBox(height: 8,),
              itemCard("Privacy Policy","", Icons.policy_outlined, context),
              const SizedBox(height: 8,),
              itemCard("Change Language","", Icons.language, context),
              const SizedBox(height: 8,),
              itemCard("Change Password","", Icons.password_outlined, context),
              const SizedBox(height: 8,),
              //itemCard("Logout",AppRoute.getstarted, Icons.phone, context, color: Colors.red),
            
              GestureDetector(
                onTap: () => _performLogout(context),
                child: Container(
                  height: 50,
                  color: Colors.white,
                  padding: const EdgeInsets.fromLTRB(12, 13, 12, 13),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Logout", style: TextStyle(color: Colors.red),),
                      Icon(Icons.arrow_right)
                    ],
                  ),
                ),
              )
            ],
            
          ),
        ),
      ),
    );
  }

  itemCard(String title, String route, IconData icon,BuildContext context, {Color color =Colors.black}) {
    return GestureDetector(
      onTap: () {
        if(route.isEmpty) {
          return;
        }
        Navigator.pushNamed(context, route);
      },
      child: Container(
        height: 50,
        color: Colors.white,
        padding: const EdgeInsets.fromLTRB(12, 13, 12, 13),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon),
                const SizedBox(width: 4,),
                Text(title, style: TextStyle(color: color),),
              ],
            ),
            const Icon(Icons.arrow_right)
          ],
        ),
      ),
    );
  }
}

