
// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:ushopie_ecom/features/cart/domain/usecases/cart_usecase.dart';
import 'package:ushopie_ecom/features/products/domain/usecases/products_usecase.dart';
import 'package:ushopie_ecom/features/cart/presentation/pages/cart_page.dart';
import 'package:ushopie_ecom/features/products/presentation/pages/catgory_page.dart';
import 'package:ushopie_ecom/features/products/presentation/pages/home_page.dart';
import 'package:ushopie_ecom/features/profile/presentation/pages/profile_page.dart';

class BottomNavBar extends StatelessWidget {

  final ProductUsecase productUsecase;
  final CartUsecase cartUsecase;
  const BottomNavBar({super.key, required this.productUsecase, required this.cartUsecase});

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(
      NavigationController(
        productUsecase: productUsecase,
        cartUsecase: cartUsecase
      )
    );
    return Scaffold(

      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 82,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) => controller.selectedIndex.value = index,
          

          destinations: const [

            NavigationDestination(icon: Icon(Icons.home), label: "Home"),
            NavigationDestination(icon: Icon(Icons.category), label: "Category"),
            NavigationDestination(icon: Icon(Icons.shopping_cart), label: "Cart"),
            NavigationDestination(icon: Icon(Icons.person), label: "Profile"),
            ],
        ),
      ),

      body: Obx(
        () => controller.screens[controller.selectedIndex.value]
      ),
    );
  }
}

class NavigationController extends GetxController {
  final ProductUsecase productUsecase;
  final CartUsecase cartUsecase;

  final Rx<int> selectedIndex = 0.obs;

  NavigationController({
    required this.productUsecase,
    required this.cartUsecase
  });

  List<Widget> get screens {
    return [
      HomePage(productUsecase: productUsecase,),
      CategoryPage(productUsecase: productUsecase),
      CartPage(cartUsecase: cartUsecase,),
      const ProfilePage(),
    ];
  }
}
