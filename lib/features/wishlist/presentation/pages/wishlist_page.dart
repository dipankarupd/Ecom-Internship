// import 'package:flutter/material.dart';
// import 'package:ushopie_ecom/features/auth/data/models/user_profile.dart';
// import 'package:ushopie_ecom/features/auth/presentation/providers/user_provider.dart';
// import 'package:ushopie_ecom/features/products/presentation/widges/app_bars.dart';
// import 'package:ushopie_ecom/features/wishlist/data/model/WishlistModel.dart';
// import 'package:ushopie_ecom/features/wishlist/domain/usecase/wishlist_usecase.dart';

// class WishlistPage extends StatefulWidget {


//   final WishlistUsecase usecase;

//    WishlistPage({super.key, required this.usecase});

//   @override
//   State<WishlistPage> createState() => _WishlistPageState();
  
// }

// class _WishlistPageState extends State<WishlistPage> {

//   late Future<WishlistItems> items ;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     items = _loadItems();
//   }

//   Future<WishlistItems> _loadItems() async {
//     try {
//       UserProfileModel? user = await UserPreferences.loadUserProfile();

//       if (user != null) {
//         int userId = user.id;
//         return widget.usecase.getWishlistItems(userId.toString());
//       } else {
//         throw Exception("User not found");
//       }
//     }  catch (e) {
//       print("Error loading cart items: $e");
//       throw e;
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const InnerAppBar(title: "Wishlist"),
//       body: Container(
//         padding: const EdgeInsets.all(24),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
              
//             Expanded(
//               child: GridView.builder(
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 0.88), 
//                 itemBuilder: (context, index) {
                
//                 }
//               )
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:ushopie_ecom/config/themes/theme_constants.dart';
import 'package:ushopie_ecom/features/auth/data/models/user_profile.dart';
import 'package:ushopie_ecom/features/auth/presentation/providers/user_provider.dart';
import 'package:ushopie_ecom/features/products/presentation/widges/app_bars.dart';
import 'package:ushopie_ecom/features/products/presentation/widges/item_widget.dart';
import 'package:ushopie_ecom/features/wishlist/data/model/WishlistModel.dart';
import 'package:ushopie_ecom/features/wishlist/domain/usecase/wishlist_usecase.dart';

class WishlistPage extends StatefulWidget {
  final WishlistUsecase usecase;

  WishlistPage({Key? key, required this.usecase}) : super(key: key);

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  late Future<WishlistItems> items;

  @override
  void initState() {
    super.initState();
    items = _loadItems();
  }

  Future<WishlistItems> _loadItems() async {
    try {
      UserProfileModel? user = await UserPreferences.loadUserProfile();

      if (user != null) {
        int userId = user.id;
        return widget.usecase.getWishlistItems(userId.toString());
      } else {
        throw Exception("User not found");
      }
    } catch (e) {
      print("Error loading wishlist items: $e");
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const InnerAppBar(title: "Wishlist"),
      body: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Wishlist Items ", 
              style: TextStyle(color: colorSecondary, fontSize: 26, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12,),
            FutureBuilder<WishlistItems>(
              future: items,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: const CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                } else if (snapshot.hasData) {
                  return Expanded(
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.88,
                      ),
                      itemCount: snapshot.data!.product.length,
                      itemBuilder: (context, index) {
                        return ItemWidget(
                          item: snapshot.data!.product[index],
                          wishlistItem: true,
                        );
                      },
                    ),
                  );
                } else {
                  return const SizedBox(); // Placeholder for other states
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
