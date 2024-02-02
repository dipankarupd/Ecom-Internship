

import 'package:ushopie_ecom/features/cart/data/model/cart_model.dart';

abstract class CartRepo {

  Future<CartModel> getCartItems(int id);
}