

// Landing page AppBar

import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:ushopie_ecom/config/themes/theme_constants.dart';
import 'package:ushopie_ecom/features/util/widges/app_logo.dart';

class HomePageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomePageAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: colorAccent,
        title: const AppLogo(fontsize: 20),
        actions: [
          Container(
            width: 23,
            height: 23,
            margin: const EdgeInsets.only(right: 24),

            child: const Icon(Icons.notifications),
          )
        ],
    );
  }
  
  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}


// other Pages Appbar:

class ApplicationToolBar extends StatelessWidget implements PreferredSizeWidget {
  
  
  final String title;
  const ApplicationToolBar({super.key, required this.title});

  
  
  @override
  Widget build(BuildContext context) {
    
    return AppBar(
      backgroundColor: colorAccent,
        // leading:  Padding(
        //   padding: EdgeInsets.only(left: 30), 
        //   child: GestureDetector(
        //     onTap: () {
        //       Navigator.of(context).pop();
        //     },
        //     child: Icon(Icons.arrow_back_rounded,)
        //   ),
        // ),
        automaticallyImplyLeading: false,
        centerTitle: false,
        title:  Padding(
          padding: EdgeInsets.only(left: 30),
          child: Text(
            title, 
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              
            ),
          ),
        ),
        actions: [
          Container(
            padding: const EdgeInsets.only(right: 24.5),
            child: const Row(
              children: [
                Icon(Icons.notifications_outlined,),
                SizedBox(width: 10,),
                Icon(Icons.shopping_cart_outlined),
              ],
            ),
          )
        ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

}


class InnerAppBar extends StatelessWidget implements PreferredSizeWidget {
  
  
  final String title;
  const InnerAppBar({super.key, required this.title});

  
  
  @override
  Widget build(BuildContext context) {
    
    return AppBar(
      backgroundColor: colorAccent,
        leading:  Padding(
          padding: EdgeInsets.only(left: 30), 
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(Icons.arrow_back_rounded,)
          ),
        ),
        title:  Text(
          title, 
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        actions: [
          Container(
            padding: const EdgeInsets.only(right: 24.5),
            child: const Row(
              children: [
                Icon(Icons.notifications_outlined,),
                SizedBox(width: 10,),
                Icon(Icons.shopping_cart_outlined),
              ],
            ),
          )
        ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

}