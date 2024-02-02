// ignore_for_file: unused_import, use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ushopie_ecom/config/routes/app_route.dart';
import 'package:ushopie_ecom/config/themes/theme_constants.dart';
import 'package:ushopie_ecom/features/auth/data/models/user_profile.dart';
import 'package:ushopie_ecom/features/auth/presentation/providers/user_provider.dart';
import 'package:ushopie_ecom/features/cart/data/model/update_cart_model.dart';

import 'package:ushopie_ecom/features/products/domain/entity/products.dart';
import 'package:ushopie_ecom/features/wishlist/data/model/UpdateWishListModel.dart';

class ItemWidget extends StatefulWidget {
  final Product item;
  bool wishlistItem;
  ItemWidget({super.key, required this.item, required this.wishlistItem});

  @override
  State<ItemWidget> createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {


  // add to wishlist functionality: 

  Future<void> _updatewishlist(BuildContext context) async {
    try {
      UserProfileModel? user = await UserPreferences.loadUserProfile();

      if (user != null) {
        int id = user.id;
        UpdateWishlistModel wishlistItem = UpdateWishlistModel(
            wishList: widget.item.id.toString(), userId: id.toString());

        Map<String, dynamic> req = wishlistItem.toJson();

        Dio dio = Dio();
        final res = await dio.patch(
          "https://ecom-api-y3aj.onrender.com/api/v1/user/updateWishlist",
          data: req,
        );

        if (res.statusCode == 200) {
          setState(() {
            widget.wishlistItem = !widget.wishlistItem;
          });
          const snackBar = SnackBar(
            content: Text("Successfully updated wishlist"),
            duration: Duration(seconds: 2),
          );
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else {
          // Handle other status codes
          const snackBar = SnackBar(
            content: Text("Failed to update wishlist"),
            duration: Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 500) {
        // Handle status code 500 separately
        const snackBar = SnackBar(
          content: Text("Server error. Please try again later."),
          duration: Duration(seconds: 2),
        );
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        // Handle other Dio errors
        final snackBar = SnackBar(
          content: Text("Error adding to cart: ${e.message}"),
          duration: const Duration(seconds: 2),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (e) {
      // Handle other unexpected errors
      const snackBar = SnackBar(
        content: Text("Unexpected error adding to cart"),
        duration: Duration(seconds: 2),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoute.product, arguments: widget.item);
      },
      child: Card(
        color: Colors.white,
        child: SizedBox(
          height: 228,
          width: 144,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SizedBox(
                  height: 124,
                  width: 144,
                  child: Container(
                      padding: const EdgeInsets.only(top: 5),
                      child: Image.network(
                        widget.item.thumbNail,
                        fit: BoxFit.contain,
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  widget.item.title,
                  style: const TextStyle(fontSize: 12),
                ),
              ),
              const SizedBox(
                height: 9,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  "£ ${widget.item.price}",
                  style: const TextStyle(color: colorInfo, fontSize: 14),
                ),
              ),
              const SizedBox(
                height: 7,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    !widget.wishlistItem
                        ? const Text(
                            "Like ",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: colorSecondary),
                          )
                        : const Text("Unlike ",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: colorError)),
                    GestureDetector(
                      onTap: () {
                        _updatewishlist(context);
                      },
                      child: widget.wishlistItem
                          ? SvgPicture.asset("assets/images/fill_heart.svg")
                          : SvgPicture.asset("assets/images/heart.svg"),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
