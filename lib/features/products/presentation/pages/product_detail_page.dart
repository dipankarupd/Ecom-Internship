import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ushopie_ecom/config/themes/theme_constants.dart';
import 'package:ushopie_ecom/features/auth/data/models/user_profile.dart';
import 'package:ushopie_ecom/features/auth/presentation/providers/user_provider.dart';
import 'package:ushopie_ecom/features/cart/data/model/update_cart_model.dart';
import 'package:ushopie_ecom/features/products/domain/entity/products.dart';
import 'package:ushopie_ecom/features/products/presentation/widges/app_bars.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int itemCount = 1;

  void decreaseCount() {
    setState(() {
      itemCount--;
      if (itemCount < 0) {
        itemCount = 0;
      }
    });
  }

  void increaseCount() {
    setState(() {
      itemCount++;
    });
  }

  Future<void> addToCart(BuildContext context) async {
    final Product item = ModalRoute.of(context)?.settings.arguments as Product;
    try {
      UserProfileModel? user = await UserPreferences.loadUserProfile();

      if (user != null) {
        int id = user.id;
        UpdateCartModel cart = UpdateCartModel(
            amount: itemCount.toString(), userId: id, productId: item.id.toString());
        Map<String, dynamic> request = cart.toJson();

        Dio dio = Dio();
        dio.options.validateStatus = (status) => status != null && status < 500;

        // Send PATCH request
        final res = await dio.patch(
          "https://ecom-api-y3aj.onrender.com/api/v1/user/updateCart",
          data: request,
        );

        if (res.statusCode == 200) {
          const snackBar = SnackBar(
            content: Text("Successfully added to cart"),
            duration: Duration(seconds: 2),
          );
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else {
          // Handle other status codes
          final snackBar = SnackBar(
            content:
                Text("Failed to add to cart. Status Code: ${res.statusCode}"),
            duration: const Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }
    } on DioError catch (e) {
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
    final Product product =
        ModalRoute.of(context)?.settings.arguments as Product;
    return Scaffold(
      appBar: const InnerAppBar(
        title: "Products Detail",
      ),
      body: Container(
        padding: const EdgeInsets.all(24),
        color: colorAccent,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromRGBO(0, 0, 0, 0.3))),
                  height: 221,
                  child: Image.network(
                    product.thumbNail,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(
                height: 13,
              ),
              Container(
                padding: const EdgeInsets.only(top: 18, left: 8, right: 8),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          product.title,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SvgPicture.asset("assets/images/heart.svg")
                      ],
                    ),
                    const SizedBox(
                      height: 26,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          product.price.toString(),
                          style: const TextStyle(
                              color: Colors.orange,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 13,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Product Details",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 13,
                        ),
                        // ignore: unnecessary_const
                        Text(
                          product.description,
                          softWrap: true,
                        ),
                      ],
                    )
                  ],
                ),
              ),

              // Related items field. Yet to implement
            ],
          ),
        ),
      ),
      // bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.fromLTRB(24, 0, 24, 68),
      //   child: ElevatedButton(
      //     onPressed: () async {
      //       await addToCart(context);
      //     },
      //     child: const Text(
      //       "Add to Cart",
      //       style: TextStyle(
      //           color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
      //     ),
      //   ),
      // ),

      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 68),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              child: GestureDetector(
                onTap: decreaseCount,
                child: SizedBox(
                  height: 28,
                  width: 28,
                  child: SvgPicture.asset("assets/images/icons/remove.svg"),
                ),
              ),
            ),
            const SizedBox(
              width: 6,
            ),
            Text(itemCount.toString(), style: TextStyle(fontSize: 16, color: colorSecondary, fontWeight: FontWeight.bold),),
            const SizedBox(
              width: 6,
            ),
            GestureDetector(
              onTap: increaseCount,
              child: SizedBox(
                height: 28,
                width: 28,
                child: SvgPicture.asset("assets/images/icons/add.svg"),
              ),
            ),
            SizedBox(width: 6,),
            ElevatedButton(
              onPressed: () async {
                await addToCart(context);
              },
              child: Text("Add to Cart", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),),
            )
          ],
        ),
      ),
    );
  }
}
