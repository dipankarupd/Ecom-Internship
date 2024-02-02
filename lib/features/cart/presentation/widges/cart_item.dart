

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ushopie_ecom/config/themes/theme_constants.dart';
import 'package:ushopie_ecom/di.dart';
import 'package:ushopie_ecom/features/auth/data/models/user_profile.dart';
import 'package:ushopie_ecom/features/auth/presentation/providers/user_provider.dart';
import 'package:ushopie_ecom/features/cart/data/model/cart_product_model.dart';
import 'package:ushopie_ecom/features/cart/data/model/update_cart_model.dart';
import 'package:ushopie_ecom/features/cart/domain/usecases/cart_usecase.dart';
import 'package:ushopie_ecom/features/cart/presentation/pages/cart_page.dart';


class CartItemWidget extends StatefulWidget {
  final CartProductModel product;
  final CartUsecase cartUsecase;
  final VoidCallback onItemRemoved;

  CartItemWidget({Key? key, required this.product, required this.cartUsecase, required this.onItemRemoved}) : super(key: key);

  @override
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {

   
  
  @override
  void initState() {
    super.initState();
  }

  Future<void> update(BuildContext context) async{
    
    try {
      UserProfileModel? user = await UserPreferences.loadUserProfile();

      if (user != null) {
        int id = user.id;
        UpdateCartModel cart = UpdateCartModel(
            amount: "0", userId: id, productId: widget.product.id.toString());
        Map<String, dynamic> request = cart.toJson();

        Dio dio = Dio();
        dio.options.validateStatus = (status) => status != null && status < 500;

        // Send PATCH request
        final res = await dio.patch(
          "https://ecom-api-y3aj.onrender.com/api/v1/user/updateCart",
          data: request,
        );

        if (res.statusCode == 200) {
          
          widget.onItemRemoved();
          const snackBar = SnackBar(
            content: Text("Successfully removed from cart"),
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
    double price = double.parse(widget.product.amount) * widget.product.price;
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 4, 16, 4),
      child: Card(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 67,
                width: 83,
                child: Center(
                  child: Image.network(widget.product.thumbNail),
                ),
              ),
              const SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 151,
                    child: Text(
                      widget.product.title,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 13,),
                  Text("Quantity: ${widget.product.amount}")
                  
                ],
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
      
                    GestureDetector(
                      onTap: () async {
                        await update(context);
                      },
                      child: SizedBox(
                        height: 24,
                        width: 24,
                        child: SvgPicture.asset("assets/images/icons/cross.svg"),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Text("£ $price", style: const TextStyle(color: colorInfo)),
                    
                    
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
