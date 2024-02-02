
import 'package:ushopie_ecom/features/cart/domain/entity/cart.dart';

class UserProfile {
   int id;
   String email;
   List<dynamic> cart;

  UserProfile({
    required this.id,
    required this.email,
    required this.cart
  });
}