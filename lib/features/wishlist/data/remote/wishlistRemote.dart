import 'package:dio/dio.dart';
import 'package:ushopie_ecom/features/products/data/models/products_model.dart';
import 'package:ushopie_ecom/features/wishlist/data/model/WishlistModel.dart';

class WishlistRemote {
  final Dio dio;

  WishlistRemote({required this.dio});

  Future<WishlistItems> getWishlistItem(String id) async {
    try {
      final response = await dio.get(
        "https://ecom-api-y3aj.onrender.com/api/v1/user/getWishList/$id",
      );

      if (response.statusCode == 200) {
        final List<dynamic>? items = response.data['product'] as List<dynamic>?;
        final List<ProductModel> products = items
                ?.map(
                  (item) => ProductModel.fromJson(item),
                )
                .toList() ??
            [];

        return WishlistItems(product: products);
      } else {
        // Handle error if the response status code is not 200
        throw DioException(
          response: response,
          error: "Failed to load products",
          requestOptions: RequestOptions(path: ''),
        );
      }
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }
}
