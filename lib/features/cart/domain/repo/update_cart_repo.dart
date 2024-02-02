
import 'package:ushopie_ecom/features/cart/data/model/update_cart_model.dart';

abstract class UpdateCartRepo {

  Future<void> updateCart(UpdateCartModel updateCart);
}