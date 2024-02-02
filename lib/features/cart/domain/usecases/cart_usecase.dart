

import 'package:ushopie_ecom/features/cart/data/model/cart_model.dart';
import 'package:ushopie_ecom/features/cart/domain/repo/cart_repo.dart';

class CartUsecase {
  final CartRepo cartRepo;

  CartUsecase({required this.cartRepo, });

  Future<CartModel> getCartItems(int id) async {
    
    try {
      return cartRepo.getCartItems(id);
    }
    catch(e) {
      throw Exception(e);
    }
  }


}