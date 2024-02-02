
// import 'package:ushopie_ecom/features/products/domain/entity/products.dart';
// import 'package:ushopie_ecom/features/products/domain/repo/products_repo.dart';

// class ProductUsecase {

//   final ProductsRepo productsRepo;

//   ProductUsecase({
//     required this.productsRepo
//   });

//   Future<List<Product>> getAllProducts () async {
    
//     try {

//       final products = await productsRepo.getProducts();
//       return products; 
//     }
//     catch (e) {
//       throw Exception(e);
//     }
//   }

//   // get the products by category
//   Future<List<Product>> getProductsByCategory (String category) async {
//     try {
//       final products = await productsRepo.getProductsByCategory(category);
//       return products;
//     } 
//     catch(e) {
//       throw Exception(e);
//     }
//   }

//   Future<Product> getIndividualProduct (int id) async {

//     try {
//       final product = await productsRepo.getIndividualProduct(id);
//       return product;
//     }
//     catch(e) {
//       throw Exception(e);
//     }
//   }
  
// }

import 'package:ushopie_ecom/features/products/domain/entity/products.dart';
import 'package:ushopie_ecom/features/products/domain/repo/products_repo.dart';

class ProductUsecase {
  final ProductsRepo productsRepo;

  ProductUsecase({
    required this.productsRepo,
  });

  Future<List<Product>> getAllProducts() async {
    try {
      final products = await productsRepo.getProducts();
      return products;
    } catch (e) {
      // Improve error handling with a more specific error message
      throw Exception('Failed to get all products. Error: $e');
    }
  }

  Future<List<Product>> getProductsByCategory(String category) async {
    try {
      final products = await productsRepo.getProductsByCategory(category);
      return products;
    } catch (e) {
      // Improve error handling with a more specific error message
      throw Exception('Failed to get products by category. Error: $e');
    }
  }

  Future<Product> getIndividualProduct(int id) async {
    try {
      final product = await productsRepo.getIndividualProduct(id);
      return product;
    } catch (e) {
      // Improve error handling with a more specific error message
      throw Exception('Failed to get individual product. Error: $e');
    }
  }
}
