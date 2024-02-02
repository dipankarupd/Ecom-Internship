// import 'package:dio/dio.dart';
// import 'package:ushopie_ecom/features/products/data/models/products_model.dart';
// import 'package:ushopie_ecom/features/products/domain/entity/products.dart';

// class RemoteSourceProduct {
//   final Dio dio;

//   RemoteSourceProduct({required this.dio});

//   Future<List<Product>> getItems() async {
//     try {
//       final response = await dio.get(
//         "https://ecom-api-y3aj.onrender.com/api/v1/product/getAllProducts",
//       );

//       if (response.statusCode == 200) {
//         final List<dynamic> jsonProducts = response.data['products'];

//         List<Product> products = jsonProducts
//             .map((jsonProduct) => ProductModel.fromJson(jsonProduct))
//             .toList();

//         return products;
//       } else {
//         // Handle error if the response status code is not 200
//         throw DioException(
//           response: response,
//           error: "Failed to load products", 
//           requestOptions: RequestOptions(path: ''),
//         );
//       }
//     } on DioException catch (e) {
//       throw Exception(e.message);
//     }
//   }


//   Future<List<Product>> getItemByCategory(String category) async{
//     try {
//       final response = await dio.get(
//         "https://ecom-api-y3aj.onrender.com/api/v1/product/getProductByCategory/$category"
//       );

//       if (response.statusCode == 200) {
//         final List<dynamic> jsonProducts = response.data['products'];

//         List<Product> products = jsonProducts
//           .map((jsonProduct) => ProductModel.fromJson(jsonProduct))
//           .toList();

//         return products;
//       } else {
//         throw DioException(
//           response: response,
//           error: "Failed to load products", 
//           requestOptions: RequestOptions(path: ''),
//         );
//       }
//     } on DioException catch(e) {
//       throw Exception(e.message);
//     }
//   }

//   Future<Product> getIndividualItem(int id) async {

//     try {
//       final response = await dio.get(
//         "https://ecom-api-y3aj.onrender.com/api/v1/product/getSingleProduct/$id"
//       );

//       if(response.statusCode == 200) {
//         final Map<String, dynamic> product = response.data;
//         return ProductModel.fromJson(product);
//       } else {
//         throw DioException(
//           response: response,
//           error: "Failed to load products", 
//           requestOptions: RequestOptions(path: ''),
//         );
//       }

//     } on DioException catch (e) {
//       throw Exception(e.message);
//     }
//   }
// }


import 'package:dio/dio.dart';
import 'package:ushopie_ecom/features/products/data/models/products_model.dart';
import 'package:ushopie_ecom/features/products/domain/entity/products.dart';

class RemoteSourceProduct {
  final Dio dio;

  RemoteSourceProduct({required this.dio});

  Future<List<Product>> getItems() async {
    try {
      final response = await dio.get(
        "https://ecom-api-y3aj.onrender.com/api/v1/product/getAllProducts",
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonProducts = response.data['products'];

        List<Product> products = jsonProducts
            .map((jsonProduct) => ProductModel.fromJson(jsonProduct))
            .toList();

        return products;
      } else {
        throw DioException(
          response: response,
          error: "Failed to load products",
          requestOptions: RequestOptions(path: ''),
        );
      }
    } on DioException catch (e) {
      throw DioException(
        response: e.response,
        error: "Failed to load products. ${_handleDioError(e)}",
        requestOptions: RequestOptions(path: ''),
      );
    }
  }

  Future<List<Product>> getItemByCategory(String category) async {
    try {
      final response = await dio.get(
        "https://ecom-api-y3aj.onrender.com/api/v1/product/getProductByCategory/$category",
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonProducts = response.data['products'];

        List<Product> products = jsonProducts
            .map((jsonProduct) => ProductModel.fromJson(jsonProduct))
            .toList();

        return products;
      } else {
        throw DioException(
          response: response,
          error: "Failed to load products",
          requestOptions: RequestOptions(path: ''),
        );
      }
    } on DioError catch (e) {
      throw DioError(
        response: e.response,
        error: "Failed to load products by category. ${_handleDioError(e)}",
        requestOptions: RequestOptions(path: ''),
      );
    }
  }

  Future<Product> getIndividualItem(int id) async {
    try {
      final response = await dio.get(
        "https://ecom-api-y3aj.onrender.com/api/v1/product/getSingleProduct/$id",
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> product = response.data;
        return ProductModel.fromJson(product);
      } else {
        throw DioException(
          response: response,
          error: "Failed to load individual product",
          requestOptions: RequestOptions(path: ''),
        );
      }
    } on DioError catch (e) {
      throw DioError(
        response: e.response,
        error: "Failed to load individual product. ${_handleDioError(e)}",
        requestOptions: RequestOptions(path: ''),
      );
    }
  }

  String _handleDioError(DioError e) {
    if (e.response?.statusCode == 401) {
      return "Unauthorized. Please check your credentials.";
    } else if (e.response?.statusCode == 403) {
      return "Forbidden. You don't have permission to access this resource.";
    } else if (e.response?.statusCode == 404) {
      return "Resource not found.";
    } else {
      return "An unexpected error occurred.";
    }
  }
}
