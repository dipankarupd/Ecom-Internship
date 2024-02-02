
import 'package:ushopie_ecom/features/wishlist/data/model/WishlistModel.dart';

abstract class GetWishlistRepo {
  Future<WishlistItems> getWishlistItems(String id);
}