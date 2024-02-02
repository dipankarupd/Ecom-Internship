
import 'package:flutter/material.dart';
import 'package:ushopie_ecom/config/routes/app_route.dart';
import 'package:ushopie_ecom/config/themes/theme_constants.dart';
import 'package:ushopie_ecom/di.dart';
import 'package:ushopie_ecom/features/auth/presentation/pages/login_page.dart';
import 'package:ushopie_ecom/features/auth/presentation/pages/signup_page.dart';
import 'package:ushopie_ecom/features/cart/presentation/pages/cart_page.dart';
import 'package:ushopie_ecom/features/feedback/presentation/pages/contact_page.dart';
import 'package:ushopie_ecom/features/products/presentation/pages/product_detail_page.dart';
import 'package:ushopie_ecom/features/wishlist/presentation/pages/wishlist_page.dart';
import 'package:ushopie_ecom/features/products/presentation/widges/bottom_navbar.dart';
import 'package:ushopie_ecom/features/util/pages/get_started.dart';
import 'package:ushopie_ecom/features/util/pages/splash_screen.dart';

void main() {

  
  runApp(
    EcomApp()
  );

}


class EcomApp extends StatelessWidget {
  const EcomApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      theme: lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoute.first,
      routes: {
        AppRoute.first : (context) =>  const SplashScreen(),
        AppRoute.login: (context) =>   LoginPage(loginUsecase: DependancyInjection.createLoginUsecase(),),
        AppRoute.signup: (context) => SignUpPage(signupUsecase: DependancyInjection.createSignupUsecase()),
        AppRoute.home: (context) =>  BottomNavBar(
          productUsecase: DependancyInjection.createProductUsecase(),
          cartUsecase: DependancyInjection.createCartUsecase(),
        ),
        AppRoute.wishlist: (context) =>  WishlistPage(usecase: DependancyInjection.createWishlistUsecase(),),
        AppRoute.cart: (context) =>  CartPage(cartUsecase: DependancyInjection.createCartUsecase()),
        // AppRoute.history: (context) => HistoryPage(),
         AppRoute.contact: (context) =>  ContactPage(contactUsUsecase: DependancyInjection.createContactUsUsecase(),),
         AppRoute.product: (context) => const ProductDetails(),
         AppRoute.getstarted: (context) => const GetStarted(),
      },
    );
  }
}
