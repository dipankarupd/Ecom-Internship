import 'package:dio/dio.dart';
import 'package:ushopie_ecom/features/cart/data/model/cart_model.dart';
import 'package:ushopie_ecom/features/cart/data/model/cart_product_model.dart';

class RemoteCartSource {
  final Dio dio;

  RemoteCartSource({required this.dio});

  Future<CartModel> getCartItems(int id) async {
    try {
      final response = await dio.get(
        "https://ecom-api-y3aj.onrender.com/api/v1/user/getCartItem/$id",
      );

      if (response.statusCode == 200) {
        final List<dynamic>? items = response.data['product'] as List<dynamic>?;

        // If 'products' is null, return an empty list
        final List<CartProductModel> products = items?.map(
              (item) => CartProductModel.fromJson(item),
            ).toList() ?? [];

        return CartModel(products: products);
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
