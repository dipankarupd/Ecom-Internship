

import 'package:ushopie_ecom/features/cart/data/model/cart_model.dart';
import 'package:ushopie_ecom/features/cart/data/source/remote.dart';
import 'package:ushopie_ecom/features/cart/domain/repo/cart_repo.dart';

class CartRepoImpl implements CartRepo {


  final RemoteCartSource cartSource;

  CartRepoImpl({required this.cartSource});

  @override
  Future<CartModel> getCartItems(int id) {
   
    try {
      return cartSource.getCartItems(id);
    }
    catch (e) {
      throw Exception(e);
    }
    
  }

}