

import 'package:ushopie_ecom/features/products/domain/entity/products.dart';

abstract class ProductsRepo {

  Future<List<Product>> getProducts();

  Future<List<Product>> getProductsByCategory(String category);

  Future<Product> getIndividualProduct(int id);
  
}