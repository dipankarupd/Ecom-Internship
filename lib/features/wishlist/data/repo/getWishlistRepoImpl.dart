
import 'package:ushopie_ecom/features/wishlist/data/model/WishlistModel.dart';
import 'package:ushopie_ecom/features/wishlist/data/remote/wishlistRemote.dart';
import 'package:ushopie_ecom/features/wishlist/domain/repo/getWishlistRepo.dart';

class GetWishListRepoImpl implements GetWishlistRepo {

  final WishlistRemote remote;

  GetWishListRepoImpl({required this.remote});
  @override
  Future<WishlistItems> getWishlistItems(String id) async{
    try {
      return remote.getWishlistItem(id);
    }

    catch(e) {
      throw Exception(e);
    }
    
  }

}