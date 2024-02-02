
// import 'package:ushopie_ecom/features/auth/domain/entity/user_profile.dart';


// class UserProfileModel extends UserProfile {

//   UserProfileModel({
//     required int id,
//     required String email,
//     required List<dynamic> cart
//   }) : super(id: id, email: email, cart: cart);


//   // Getter for Cart
//   List<dynamic> get userCart => cart;

//   // Setter for Cart
//   set userCart(List<dynamic> newCart) {
//     cart = newCart;
//   }

  
//    UserProfileModel.fromJson(Map<String, dynamic> json)
//       : super(
//           id: json['id'],
//           email: json['email'], 
//           cart:List.castFrom<dynamic, dynamic>(json['cart']),
//           // Add other required parameters if any
//         );

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['id'] = id;
//     _data['email'] = email;
//     _data['cart'] = cart;
//     return _data;
//   }
// }

import 'package:ushopie_ecom/features/auth/domain/entity/user_profile.dart';

class UserProfileModel extends UserProfile {
  UserProfileModel({
    required int id,
    required String email,
    List<dynamic>? cart, // Make 'cart' property nullable
  }) : super(id: id, email: email, cart: cart ?? []); // Use null-aware operator

  // Getter for Cart
  List<dynamic> get userCart => cart ?? []; // Use null-aware operator

  // Setter for Cart
  set userCart(List<dynamic> newCart) {
    cart = newCart;
  }

  UserProfileModel.fromJson(Map<String, dynamic> json)
      : super(
          id: json['id'],
          email: json['email'],
          cart: List.castFrom<dynamic, dynamic>(json['cart'] ?? []), // Use null-aware operator
          // Add other required parameters if any
        );

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['email'] = email;
    _data['cart'] = cart ?? []; // Use null-aware operator
    return _data;
  }
}
