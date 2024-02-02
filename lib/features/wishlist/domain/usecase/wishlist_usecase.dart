
import 'package:ushopie_ecom/features/wishlist/data/model/WishlistModel.dart';
import 'package:ushopie_ecom/features/wishlist/domain/repo/getWishlistRepo.dart';

class WishlistUsecase {
  final GetWishlistRepo repo;

  WishlistUsecase({required this.repo});

  Future<WishlistItems> getWishlistItems(String id) async {
    try {
      return repo.getWishlistItems(id);
    }
    catch(e) {
      throw Exception(e);
    }
  }
}