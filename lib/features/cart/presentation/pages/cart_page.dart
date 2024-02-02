import 'package:flutter/material.dart';
import 'package:ushopie_ecom/features/auth/data/models/user_profile.dart';
import 'package:ushopie_ecom/features/auth/presentation/providers/user_provider.dart';
import 'package:ushopie_ecom/features/cart/data/model/cart_model.dart';
import 'package:ushopie_ecom/features/cart/domain/entity/cart.dart';
import 'package:ushopie_ecom/features/cart/domain/usecases/cart_usecase.dart';
import 'package:ushopie_ecom/features/cart/presentation/widges/cart_item.dart';
import 'package:ushopie_ecom/features/products/presentation/widges/app_bars.dart';

class CartPage extends StatefulWidget {
  final CartUsecase cartUsecase;

  const CartPage({Key? key, required this.cartUsecase}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late Future<CartModel> cartFuture;



  @override
  void initState() {
    super.initState();
    cartFuture = _loadItems();
  }

  void _onItemRemoved() {
  setState(() {
    // Reload the cart items after an item is removed
    cartFuture = _loadItems();
  });
}

  // reload the page: 

  Future<CartModel> _loadItems() async {
    try {
      UserProfileModel? user = await UserPreferences.loadUserProfile();

      if (user != null) {
        int userId = user.id;
        return widget.cartUsecase.getCartItems(userId);
      } else {
        throw Exception("User not found");
      }
    } catch (e) {
      print("Error loading cart items: $e");
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ApplicationToolBar(title: "Cart"),
      body: FutureBuilder<Cart>(
        future: cartFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Error loading cart items"));
          } else if (!snapshot.hasData || snapshot.data!.products.isEmpty) {
            return const Center(child: Text("Empty cart"));
          } else {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.products.length,
                    itemBuilder: (context, index) {
                      return CartItemWidget(
                        product: snapshot.data!.products[index],
                        cartUsecase: widget.cartUsecase,
                        onItemRemoved: _onItemRemoved
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(24),
                  child: ElevatedButton(
                    child: const Text(
                      "Checkout",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () => {},
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
